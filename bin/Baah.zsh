# 1. Clear out stale headers and generate parser templates
yacc -d parser.y

# 2. Build the state engine transitions for scanning
lex lexer.l

# 3. Create the binary system distribution
gcc y.tab.c lex.yy.c -o semver_range_validator
