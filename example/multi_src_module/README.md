# Example: multi_src_module

This is an example for project [rules_cpp23_modules](https://github.com/igormcoelho/rules_cpp23_modules).

This example is inspired by [rules_cc_module/example/multi_src_module](https://github.com/rnburn/rules_cc_module/tree/main/example/multi_src_module), however using C++23 `import std;` and a new rule called `cc_compiled_module`.

## Quicks

This example works fine on `Makefile` for Clang (not implemented on GCC).

- IMPORTANT: It only works on bazel if no `#include <string>` or `import <string>;` is present...
this is related to how rules_cc_module orders these compilation units.
    * This is not a problem afterall, because it works fine with `import std;`  ;)

## Example

There are five files:

- spanish_english_dictionary.cppm, a c++20 module that uses `import std;` from c++23
   * its implementation is on spanish_english_dictionary_impl.cc
- speech.cppm, a c++20 module that uses `import std;` from c++23
   * its implementation is on speech_impl.cc (it uses spanish_english_dictionary module)
- main.cc, a c++ source/binary file that uses `import speech;` and also `import std;`.

To build it on bazel, normally main.cc would be a `cc_binary` (here is a `cc_module_binary`); both spanish_english_dictionary and speech are `cc_module`, also declaring their respective impl files.

For std, we need to Manually Build it (see [post on medium](https://igormcoelho.medium.com/its-time-to-use-cxx-modules-on-modern-c-41a574b77e83)), generating CMI `std.pcm`, on clang 19; or CMI `gcm.cache/std.gcm`, on gcc 15 (still does not work on bazel, but works on makefile!).
This CMI is imported into bazel with the new **experimental** rule `cc_compiled_module`.

## How to run it

This is tested on Clang 19, and one needs to build `std.pcm` manually (an example is provided in [Makefile](Makefile), for both gcc and clang). For clang just run `make multi_src_clang` or `make std.pcm`

After that, just run: `bazel build //example/multi_src_module:multi_src_demo`

```
$ bazel run //example/multi_src_modu
le:multi_src_demo
INFO: Analyzed target //example/multi_src_module:multi_src_demo (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //example/multi_src_module:multi_src_demo up-to-date:
  bazel-bin/example/multi_src_module/multi_src_demo
INFO: Elapsed time: 0.155s, Critical Path: 0.00s
INFO: 1 process: 1 action cache hit, 1 internal.
INFO: Build completed successfully, 1 total action
INFO: Running command line: bazel-bin/example/multi_src_module/multi_src_demo

Hello, world!
Hello, world!
```

## Known Issues

If `std.pcm` is not provided, then this error will occur (see hello-world example).

## More advices

We also provide a CMakeLists.txt if you want to try it with CMake 4.0 (tested on clang 19 and gcc 15). See hello-world example.

