---
BINDINGS: lists all known libcurl language bindings and where to find them
BUGS: how to report bugs and where
CODE_OF_CONDUCT.md: how we expect people to behave in this project
CONTRIBUTE: what to think about when contributing to the project
curl.1: the curl command-line tool man page, in nroff format
curl-config.1: the curl-config man page, in nroff format
FAQ: frequently asked questions about various curl-related subjects
FEATURES: an incomplete list of curl features
HISTORY: describes how the project started and has evolved over the years
HTTP2.md: how to use HTTP/2 with curl and libcurl
HTTP-COOKIES: how curl supports and works with HTTP cookies
index.html: a basic HTML page as a documentation index page
INSTALL: how to build and install curl and libcurl from source
INSTALL.cmake: how to build curl and libcurl with CMake
INSTALL.devcpp: how to build curl and libcurl with devcpp
INTERNALS: details curl and libcurl internal structures
KNOWN_BUGS: list of known bugs and problems
LICENSE-MIXING: describes how to combine different third party modules and their individual licenses
MAIL-ETIQUETTE: this is how to communicate on our mailing lists
MANUAL: a tutorial-like guide on how to use curl
mk-ca-bundle.1: the mk-ca-bundle tool man page, in nroff format
READMEdotcmake: CMake details
READMEdotnetware: Netware details
READMEdotwin32: win32 details
RELEASE-PROCEDURE: how to do a curl and libcurl release
RESOURCES: further resources for further reading on what, why and how curl does things
ROADMAPdotmd: what we want to work on in the future
SECURITY: how we work on security vulnerabilities
SSLCERTS: TLS certificate handling documented
SSL-PROBLEMS: common SSL problems and their causes
THANKS: thanks to this extensive list of friendly people, curl exists today.
TheArtOfHttpScripting: a tutorial into HTTP scripting with curl
TODO: things we or you can work on implementing
VERSIONS: how the version numbering of libcurl works
---
  

All libcurl functions have their own man pages in individual files with .3 extensions, using nroff format, in this directory. There are also a few other files that are described 
ABI
index.html
libcurl.3
libcurl-easy.3
libcurl-errors.3
libcurl.m4
libcurl-multi.3
libcurl-share.3
libcurl-thread.3
libcurl-tutorial.3
symbols-in-versions
docs/libcurl/opts

This directory contains the man pages for the individual options for three different libcurl functions.

curl_easy_setopt() options start with CURLOPT_, curl_multi_setopt() options start with CURLMOPT_ and curl_easy_getinfo() options start with CURLINFO_.

docs/examples

Contains around 100 stand-alone examples that are meant to help readers understand how libcurl can be used.

See also the libcurl examples section of this book.

scripts

Handy scripts.

contributors.sh: extracts all contributors from the git repository since a given hash/tag. The purpose is to generate a list for the RELEASE-NOTES file and to allow manually added names to remain in there even on updates. The script uses the THANKS-filter file to rewrite some names.
contrithanks.sh: extracts contributors from the git repository since a given hash/tag, filters out all the names that are already mentioned in THANKS, and then outputs THANKS to stdout with the list of new contributors appended at the end; it is meant to allow easier updates of the THANKS document. The script uses the THANKS-filter file to rewrite some names.
log2changes.pl: generates the CHANGES file for releases, as used by the release script. It converts git log output.
zsh.pl: helper script to provide curl command-line completions to users of the zsh shell.
