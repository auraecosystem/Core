%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function prototypes required for standard Yacc compilation
int yylex(void);
void yyerror(const char *s);

// Struct definitions to store Semantic Version structures
typedef struct {
    int major;
    int minor;
    int patch;
    char *prerelease;
    char *build;
} SemVer;

SemVer parsed_version;
%}

/* Define the semantic data types for tokens and non-terminals */
%union {
    int num;
    char *str;
}

/* Token definitions sent from the Lex lexical scanner */
%token <num> NUMBER
%token <str> IDENTIFIER
%token DOT DASH PLUS
%token CARET TILDE EQUAL LESS GREATER

/* Type definitions for non-terminals */
%type <str> prerelease_ident build_ident optional_prerelease optional_build

%%

/* Top-level grammar entry point */
semver_runtime:
    version_core optional_prerelease optional_build {
        parsed_version.prerelease = $2;
        parsed_version.build = $3;
        printf("Successfully Parsed SemVer: %d.%d.%d\n", 
               parsed_version.major, parsed_version.minor, parsed_version.patch);
        if(parsed_version.prerelease) printf("  Prerelease: %s\n", parsed_version.prerelease);
        if(parsed_version.build)      printf("  Build Metadata: %s\n", parsed_version.build);
    }
    ;

/* Core system mapping Major.Minor.Patch variables */
version_core:
    NUMBER DOT NUMBER DOT NUMBER {
        parsed_version.major = $1;
        parsed_version.minor = $3;
        parsed_version.patch = $5;
    }
    ;

/* Structural logic managing pre-release extensions (e.g., -alpha.1) */
optional_prerelease:
    DASH prerelease_ident { $$ = $2; }
    | /* empty */         { $$ = NULL; }
    ;

prerelease_ident:
    IDENTIFIER                { $$ = strdup($1); }
    | NUMBER                  { char buf[32]; sprintf(buf, "%d", $1); $$ = strdup(buf); }
    | prerelease_ident DOT IDENTIFIER { 
        char *res = malloc(strlen($1) + strlen($3) + 2);
        sprintf(res, "%s.%s", $1, $3);
        $$ = res;
    }
    ;

/* Structural logic managing build tracking extensions (e.g., +build.123) */
optional_build:
    PLUS build_ident  { $$ = $2; }
    | /* empty */     { $$ = NULL; }
    ;

build_ident:
    IDENTIFIER           { $$ = strdup($1); }
    | NUMBER             { char buf[32]; sprintf(buf, "%d", $1); $$ = strdup(buf); }
    | build_ident DOT IDENTIFIER {
        char *res = malloc(strlen($1) + strlen($3) + 2);
        sprintf(res, "%s.%s", $1, $3);
        $$ = res;
    }
    ;

%%

/* Global diagnostic utility when processing syntax validation faults */
void yyerror(const char *s) {
    fprintf(stderr, "SemVer Syntax Error: %s\n", s);
}

int main(void) {
    printf("Enter SemVer string to validate: ");
    return yyparse();
}
