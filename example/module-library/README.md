# Example: module-library

This is an example for project [rules_cpp23_modules](https://github.com/igormcoelho/rules_cpp23_modules).

This example is inspired by [rules_cc_module/example/module-library](https://github.com/rnburn/rules_cc_module/tree/main/example/module-library), however using C++23 `import std;` and a new rule called `cc_compiled_module`.

## Example

There are four files:

- a.cppm, a c++20 module
- b.cc, a c++ source/binary file that uses b.h header and also `import a;`
- main.cc, a c++ source/binary file and also `import std;`.

To build it on bazel, normally main.cc would be a `cc_binary`, b.c and b.h would be a cc_library (here is a `cc_module_library`) and a.cppm is a `cc_module`. 

For std, we need to Manually Build it (see [post on medium](https://igormcoelho.medium.com/its-time-to-use-cxx-modules-on-modern-c-41a574b77e83)), generating CMI `std.pcm`, on clang 19; or CMI `gcm.cache/std.gcm`, on gcc 15 (still does not work on bazel, but works on makefile!).
This CMI is imported into bazel with the new **experimental** rule `cc_compiled_module`.

## How to run it

This is tested on Clang 19, and one needs to build `std.pcm` manually (an example is provided in [Makefile](Makefile), for both gcc and clang). For clang just run `make hello_world_clang` or `make std.pcm`

After that, just run: `bazel build //example/module-library:module_library`

```
$ bazel run //example/module-library:module_library
INFO: Analyzed target //example/module-library:module_library (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //example/module-library:module_library up-to-date:
  bazel-bin/example/module-library/module_library
INFO: Elapsed time: 0.129s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
INFO: Running command line: bazel-bin/example/module-library/module_library

3
```

## A modern `main.cc` with std::print

It is very easy to use `std::print` now with `import std;`:

```
#include "b.h"

import std;

int main() {
  std::println("{}", plus_float(1.0, 2.0));
  return 0;
}
```

## Known Issues

If `std.pcm` is not provided, then an error (same as hello-world example).

## More advices

We also provide a CMakeLists.txt if you want to try it with CMake 4.0 (tested on clang 19 and gcc 15). Check hello-world example.

