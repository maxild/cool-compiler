# Stanford CS143 Compilers Course Project - Cool

The full name of "Cool" is "The Classroom Object-Oriented Language". It is a small language designed for use in an undergraduate compiler course project by Stanford University. Cool has many of the features of modern programming languages, including objects, automatic memory management, and strong static typing. It generates code for a MIPS simulator.

More info:

* [The Cool Reference Manual](http://web.stanford.edu/class/cs143/materials/cool-manual.pdf)
* [A Tour of the Cool Support Code](http://web.stanford.edu/class/cs143/materials/cool-tour.pdf)
* [The Cool Runtime System](http://web.stanford.edu/class/cs143/materials/cool-runtime.pdf)
* [Flex manual](http://westes.github.io/flex/manual/)
* [Bison manual](http://www.gnu.org/software/bison/manual/html_node/index.html)

## Troubleshooting

### SPIM: No such file or directory (means loader `ld.so` fails)

This is because the course is ancient and most people today are running
64-bit linux, which does not have the 32-bit
libc installed. More precisely 32-bit versions of the `ld-linux.so.2` interpreter and the
2 standard shared libs `libc.so.6` and `libm.so.6`.

The loader problems can be debugged using the
SDK tools `readelf` and `ldd`. With a little `patchelf` magic and using the Nix
package manager the `libc6-386` can be installed and the spim executable can be
changed such that interpreter and rpath is configured correctly into the nix
store.

### libfl.so: undefined reference to 'yylex'

* Set the line `%option noyywrap` in the `cool.flex` file
* Remove the `-lfl` part of the `LIB=` line in the makefile
