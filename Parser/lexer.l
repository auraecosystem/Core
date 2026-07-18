%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"  /* Generated automatically by Yacc to coordinate shared tokens */
%}

/* Tell Lex to generate a standard scanner without expecting an external wrapper library */
%option noyywrap

%%

[0-9]+ {
    /* Convert numeric text string into an integer token attribute */
    yylval.num = atoi(yytext);
    return NUMBER;
}

[a-zA-Z0-9]+ {
    /* Copy alphabetic string literal structures onto the Yacc data stack */
    yylval.str = strdup(yytext);
    return IDENTIFIER;
}

"."         { return DOT; }
"-"         { return DASH; }
"+"         { return PLUS; }
"^"         { return CARET; }
"~"         { return TILDE; }
"="         { return EQUAL; }
"<"         { return LESS; }
">"         { return GREATER; }

[ \t\r\n]   { /* Intentionally discard whitespace, tabs, and newlines safely */ }

.           { printf("Unexpected lexical character ignored: %s\n", yytext); }

%%
