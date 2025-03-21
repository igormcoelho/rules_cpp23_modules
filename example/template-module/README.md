# Example: template-module

This is an example for project [rules_cpp23_modules](https://github.com/igormcoelho/rules_cpp23_modules).

This example is inspired by [rules_cc_module/example/template-module](https://github.com/rnburn/rules_cc_module/tree/main/example/template-module), however using C++23 `import std;` and a new rule called `cc_compiled_module`.

## Example

There are two files:

- algorithm.cppm, a c++20 module that uses `import std;` from c++23
- main.cc, a c++ source/binary file that uses `import algorithm;` and also `import std;`.

To build it on bazel, normally main.cc would be a `cc_binary` (here is a `cc_module_binary`) and algorithm.cppm is a `cc_module`. 

For std, we need to Manually Build it (see [post on medium](https://igormcoelho.medium.com/its-time-to-use-cxx-modules-on-modern-c-41a574b77e83)), generating CMI `std.pcm`, on clang 19; or CMI `gcm.cache/std.gcm`, on gcc 15 (still does not work on bazel, but works on makefile!).
This CMI is imported into bazel with the new **experimental** rule `cc_compiled_module`.

## How to run it

This is tested on Clang 19, and one needs to build `std.pcm` manually (an example is provided in [Makefile](Makefile), for both gcc and clang). For clang just run `make example_clang` or `make std.pcm`

After that, just run: `bazel build //example/template-module:example`

```
$ bazel run //example/template-module:example
INFO: Analyzed target //example/template-module:example (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //example/template-module:example up-to-date:
  bazel-bin/example/template-module/example
INFO: Elapsed time: 0.240s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
INFO: Running command line: bazel-bin/example/template-module/example

1
7.2
```

## Known Issues

If `std.pcm` is not provided, then this error will occur (see hello-world example).

## More advices

We also provide a CMakeLists.txt if you want to try it with CMake 4.0 (tested on clang 19 and gcc 15). See hello-world example.

