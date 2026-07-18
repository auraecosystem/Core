# SemVer Runtime Architecture Core

[![License: CC BY 4.0](https://shields.io)](https://creativecommons.org/licenses/by/4.0/)

An ultra-fast, low-level [Semantic Versioning (SemVer)](https://semver.org) runtime engine written in C, Yacc, and Lex. This repository compiles a high-performance parsing pipeline optimized for evaluating package metadata and solving large-scale dependency graph restrictions efficiently.

## 🚀 Key Features

* **Compiler-Grade Tokenizer:** Built using Lex (`standard.lex`) to slice complex version constraint ranges efficiently.
* **Grammar-Strict Parsing:** Backed by Backus-Naur Form grammar (`semver.bnf`) and compiled Yacc files to parse semantic expressions securely.
* **Advanced Range Evaluator:** Handles mathematical operations, carets (`^`), tildes (`~`), wildcards, and compound conditions (e.g., `>=1.2.0 <2.0.0`).
* **Graph Dependency Resolver:** Resolves overlapping nested module conflicts down into unified execution footprints.

---

## 📂 Repository Blueprint

```text
semver/
├── compare/               # Mathematical order controllers
│   └── comparator         # Base calculation utilities
├── constraint/            # Rule range handlers
│   ├── evaluator          # Range validation machines
│   ├── parser             # Boundary expression parsing
│   └── range              # High/Low version bounding boundaries
├── docs/                  # Specifications and reference documentation
├── grammar/               # Language grammar frameworks
│   └── semver.bnf         # Formal Backus-Naur Form logic rules
├── include/               # System definitions and headers
│   └── semver.h           # Unified C runtime architecture maps
├── parser/                # Syntax processor engines
│   ├── lexer              # Word tokenizer mechanics
│   ├── parser             # Node processing frameworks
│   └── tokenizer          # Concrete character processing loops
├── resolver/              # Topological sequence controllers
│   └── dependency_resolver # Graph dependency calculation engine
├── runtime/               # Core execution structures
│   └── semver_runtime     # Entry execution system environments
├── spec/                  # Verification metrics
├── tests/                 # Test suites and harnesses
└── validator/             # Version format alignment validations
```

---

## 🛠️ Build and Compilation

### Prerequisites

Ensure your development environment includes:
* A standard C compiler (`gcc` or `clang`)
* `lex` / `flex` (Lexical Analyzer Generator)
* `yacc` / `bison` (Parser Generator)

### Local Assembly

Compile the engine binary files through your shell:

```bash
# Clean previous targets and recompile lexer and parser definitions
flex standard.lex
yacc -d semver.bnf

# Build the runtime source files
gcc -O3 main.c parser/*.c compare/*.c constraint/*.c resolver/*.c -o bin/semver_core
```

---

## 💻 Usage & Verification

### Version Comparison
Pass a mock version check argument to verify operations:

```bash
./bin/semver_core --compare "2.1.3" "^1.2.0"
```

### Dependency Resolution
The dependency resolver maps module targets by reviewing local configuration rules. Setup a test `Package.toml` workspace manifest inside your runtime folders to map allocations:

```toml
[package]
name = "demo_app"
version = "1.0.0"

[dependencies]
core_library = "^2.4.0"
helper_plugin = ">=1.0.2 <1.5.0"
```

Execute the solver manually to process a locked dependency array map output file (`Lockfile.mkdn`):

```bash
./bin/semver_core --resolve Package.toml
```

---

## 🧪 Testing and Memory Audit

### Runtime Debugging
To confirm memory tracking integrity locally without external applications, uncomment the tracking wrappers mapping global definitions inside `semver.h`. This prints an active balance summary when closing execution loops:

```c
// At the conclusion of your test harness runtime lifecycle loop:
report_memory_leaks();
```

### Valgrind Verification
If you have Valgrind available on your system architecture, perform a deep byte inspection:

```bash
valgrind --leak-check=full --show-leak-kinds=all ./bin/semver_core
```

---

## 📜 License & Compliance

Distributed under open systems architecture guidelines. Review the local `spec.txt` or `docs/ specifications` configurations for explicit syntax and grammar validation metrics.

Semver_core © 2025 by [Seriki Walter Yakub](https://github.com/auraecosystem). This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).
