# Example: hello-world

This example is inspired by [rules_cc_module/example/hello-world](https://github.com/rnburn/rules_cc_module/tree/main/example/hello-world), however using C++23 `import std;` and a new rule called `cc_compiled_module`.

## Example

There are two files:

- hello.cppm, a c++20 module that uses `import std;` from c++23
- main.cc, a c++ source/binary file that uses `import hello;` and also `import std;`.

To build it on bazel, normally main.cc would be a `cc_binary` (here is a `cc_binary_module`) and hello.cppm is a `cc_module`. 

For std, we need to Manually Build it (see [post on medium](https://igormcoelho.medium.com/its-time-to-use-cxx-modules-on-modern-c-41a574b77e83)), generating CMI `std.pcm`, on clang 19; or CMI `gcm.cache/std.gcm`, on gcc 15 (still does not work on bazel, but works on makefile!).
This CMI is imported into bazel with the new **experimental** rule `cc_compiled_module`.

## How to run it

This is tested on Clang 19, and one needs to build `std.pcm` manually (an example is provided in [Makefile](Makefile), for both gcc and clang). For clang just run `make hello_world_clang` or `make std.pcm`

After that, just run: `bazel build //example/hello-world:hello_world`

```
$ bazel run //example/hello-world:hello_world 
INFO: Analyzed target //example/hello-world:hello_world (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //example/hello-world:hello_world up-to-date:
  bazel-bin/example/hello-world/hello_world
INFO: Elapsed time: 0.166s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
INFO: Running command line: bazel-bin/example/hello-world/hello_world

Hello world!
```

## Known Issues

If `std.pcm` is not provided, then this error will occur:

```
$ bazel build //example/hello-world:hello_world 
INFO: Analyzed target //example/hello-world:hello_world (1 packages loaded, 6 targets configured).
ERROR: ......./rules_cpp23_modules/example/hello-world/BUILD:3:10: Action example/hello-world/cc_module_interface-hello.o failed: missing input file '//example/hello-world:std.pcm'
ERROR: ......./rules_cpp23_modules/example/hello-world/BUILD:3:10: Action example/hello-world/cc_module_interface-hello.o failed: 1 input file(s) do not exist
Target //example/hello-world:hello_world failed to build
Use --verbose_failures to see the command lines of failed build steps.
ERROR: ......./rules_cpp23_modules/example/hello-world/BUILD:3:10 Action example/hello-world/cc_module_interface-hello.o failed: 1 input file(s) do not exist
INFO: Elapsed time: 0.248s, Critical Path: 0.00s
INFO: 1 process: 6 action cache hit, 1 internal.
ERROR: Build did NOT complete successfully
``` 

## More advices

We also provide a CMakeLists.txt if you want to try it with CMake 4.0 (tested on clang 19 and gcc 15).

