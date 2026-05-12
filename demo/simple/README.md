# Demo: hello-world project

This is an demo for project [rules_cpp23_modules](https://github.com/igormcoelho/rules_cpp23_modules).

> IMPORTANT: This is for Bazel 8 and before, since after Bazel 9 there's official support for modules (at least for clang!).

> For Bazel 9 with clang, see [demo9/simple](../../demo9/simple/README.md).


## How to use it 
To use it, just add this to your `MODULE.bazel` file:

```
bazel_dep(name = "rules_cpp23_modules", dev_dependency = True)

git_override(
    module_name = "rules_cpp23_modules",
    remote = "https://github.com/igormcoelho/rules_cpp23_modules.git",
    commit = "f3607b4b55ccfec0c14f13dcd73095659adc1245",
)
```

Update this hash above with latest one.

### Remember to build `std.pcm`

For std, we need to Manually Build it (see [post on medium](https://igormcoelho.medium.com/its-time-to-use-cxx-modules-on-modern-c-41a574b77e83)), see instructions for generating CMI on [Makefile](./Makefile):

- CMI `std.pcm`, on clang 19; 
- or CMI `gcm.cache/std.gcm`, on gcc 15 (now working too!).

This CMI is imported into bazel with the new **experimental** rule `cc_compiled_module`.

Just type: 

- `make std.pcm` to build it with clang++
- `make std_gcm` to build it with g++

Choose compiler in [.bazelrc](./.bazelrc):

- `build --repo_env=BAZEL_COMPILER=gcc`  (default for this example)

```
$ make std_gcm 
g++ -std=c++23  -fmodules -U_FORTIFY_SOURCE -fstack-protector -Wall  -Wunused-but-set-parameter -Wno-free-nonheap-object  -fno-omit-frame-pointer '-std=c++23' -fPIC  -c -fmodules -fsearch-include-path bits/std.cc  
```


### Just run bazel

To build with CMI built on gcm.cache/std.gcm:

```
$ bazel build ... --verbose_failures 
Starting local Bazel server and connecting to it...
WARNING: Couldn't auto load rules or symbols, because no dependency on module/repository 'rules_android' found. This will result in a failure if there's a reference to those rules or symbols.
INFO: Analyzed 3 targets (82 packages loaded, 3467 targets configured).
INFO: Found 3 targets...
INFO: Elapsed time: 5.845s, Critical Path: 0.96s
INFO: 20 processes: 15 internal, 5 linux-sandbox.
INFO: Build completed successfully, 20 total actions
```

Then run:

```
$ bazel run //:demo_std
INFO: Analyzed target //:demo_std (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //:demo_std up-to-date:
  bazel-bin/demo_std
INFO: Elapsed time: 0.077s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
INFO: Running command line: bazel-bin/demo_std
hi world
```

## Understanding the Demo

### Understanding the Demo: the C++

On C++ side, we have sources `main2.cpp`, that uses c++23 `import std` module, and `main.cpp` that does not use:

```
// main2.cpp
// #include <print>
import std;

auto main() -> int {
  std::println("hi world");
  return 0;
}

```

```
// main.cpp
#include <print>

auto main() -> int {
  std::println("hi world");
  return 0;
}
```

### Understanding the Demo: the bazel side

The BUILD file is very intuitive: `cc_module` declares modules, where `cc_module_binary` declares targets that consume modules.
Since `std.pcm` (or `std.gcm`) is built manually, then one must manually declare CMI targets with:


```
# for gcc
cc_compiled_module(
    name = "std",
    cmi = "gcm.cache/std.gcm",
    module_name = "std",  # for both clang and gcc!
)
```

```
# for clang
cc_compiled_module(
    name="std",
    cmi="std.pcm",
    module_name = "std",  # for both clang and gcc!
)
```

Remember to use relevant rules from load statement: 

```
load("@rules_cpp23_module//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")
```

Finally, both applications with and without std modules can be built together.

Good luck!