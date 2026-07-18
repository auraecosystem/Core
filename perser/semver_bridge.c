#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdio.h>
#include <stdlib.h>

#define OP_EQ  1
#define OP_LT  2
#define OP_GT  3
#define OP_LTE 4
#define OP_GTE 5
#define OP_CAR 6
#define OP_TIL 7

typedef struct {
    int op;
    int major;
    int minor;
    int patch;
} ConstraintResult;

// Global communication objects linked directly to Yacc tracking rules
ConstraintResult current_constraint;
extern int yyparse(void);
typedef struct yy_buffer_state *YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string(const char *str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

// Helper function to evaluate target vs rule version bounds
int match_version(int target_maj, int target_min, int target_pat, ConstraintResult rule) {
    long target_val = (target_maj * 1000000L) + (target_min * 1000L) + target_pat;
    long rule_val = (rule.major * 1000000L) + (rule.minor * 1000L) + rule.patch;

    switch (rule.op) {
        case OP_EQ:  return target_val == rule_val;
        case OP_LT:  return target_val < rule_val;
        case OP_GT:  return target_val > rule_val;
        case OP_LTE: return target_val <= rule_val;
        case OP_GTE: return target_val >= rule_val;
        case OP_CAR: // Caret rule: major stays fixed, minor/patch can go up
            return (target_maj == rule.major) && (target_val >= rule_val);
        case OP_TIL: // Tilde rule: major and minor stay fixed, patch can go up
            return (target_maj == rule.major) && (target_min == rule.minor) && (target_val >= rule_val);
        default: return 0;
    }
}

static PyObject* method_filter_versions(PyObject* self, PyObject* args) {
    const char* rule_str;
    PyObject* version_list;

    if (!PyArg_ParseTuple(args, "sO!", &rule_str, &PyList_Type, &version_list)) {
        return NULL;
    }

    // Step 1: Parse condition rule boundaries into current_constraint structural mapping
    YY_BUFFER_STATE rule_buf = yy_scan_string(rule_str);
    int rule_status = yyparse();
    yy_delete_buffer(rule_buf);

    if (rule_status != 0) {
        PyErr_SetString(PyExc_ValueError, "Invalid SemVer expression query format syntax.");
        return NULL;
    }

    ConstraintResult compiled_rule = current_constraint;
    PyObject* matching_list = PyList_New(0);
    Py_ssize_t list_size = PyList_Size(version_list);

    // Step 2: Iterate through version array
    for (Py_ssize_t i = 0; i < list_size; i++) {
        PyObject* item = PyList_GetItem(version_list, i);
        if (!PyUnicode_Check(item)) continue;

        const char* ver_str = PyUnicode_AsUTF8(item);

        // Run version string format checks via Lex/Yacc entrypoints
        YY_BUFFER_STATE check_buf = yy_scan_string(ver_str);
        current_constraint.op = OP_EQ; // resetting flag state variables
        int parse_status = yyparse();
        yy_delete_buffer(check_buf);

        if (parse_status == 0) {
            if (match_version(current_constraint.major, current_constraint.minor, current_constraint.patch, compiled_rule)) {
                PyList_Append(matching_list, item);
            }
        }
    }

    return matching_list;
}

static PyMethodDef SemverMethods[] = {
    {"filter_versions", method_filter_versions, METH_VARARGS, "Filters software release array maps against constraints."},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef semvermodule = {
    PyModuleDef_HEAD_INIT, "semver_native", NULL, -1, SemverMethods
};

PyMODINIT_FUNC PyInit_semver_native(void) {
    return PyModule_Create(&semvermodule);
}
