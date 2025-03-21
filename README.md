# rules_cpp23_module

This project is the same as [rburn/rules_cc_module](https://github.com/rnburn/rules_cc_module), but including a **VERY EXPERIMENTAL** rule called `cc_compiled_module` to allow using C++23 `import std;` feature on bazel.

At the time of writing, there's no official support in Bazel, although two ongoing PRs may solve this (I hope very soon!).

- https://github.com/bazelbuild/bazel/pull/22553
- https://github.com/bazelbuild/bazel/pull/22555

See [Issue 15 on rules_cc_module](https://github.com/rnburn/rules_cc_module/issues/15).

When those two PRs above are merged and bazel officially supports modules, you must **Abandon this project!**.

For now, feel free to test modules and `import std;` on Bazel 8  ;)

## Getting started

See examples, and remember they expect Clang 19 and Bazel 8 (trying to make it work on GCC 15, and perhaps MSVC too, didn't try yet)!

First, remember to *MANUALLY GENERATE* `std.pcm` MCI file for each example... each README demonstrate how!

1.  [example/hello-world/README.md](./example/hello-world/README.md)
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/hello-world:hello_world`
2.  [example/module-library/README.md](./example/module-library/README.md)
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/module-library:module_library`
3.  [example/multi_src_module/README.md](./example/multi_src_module/README.md)
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/multi_src_module:multi_src_demo`
4.  [example/template-module/README.md](./example/template-module/README.md)
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/template-module:example`
5.  [example/transitive/README.md](./example/transitive/README.md)
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel build //example/transitive:trans`


## Feel free to try our demo project

See demo on [demo/hello-world-project](./demo/hello-world-project/README.md)

### Steps to use it 
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

For std, we need to Manually Build it (see [post on medium](https://igormcoelho.medium.com/its-time-to-use-cxx-modules-on-modern-c-41a574b77e83)), generating CMI `std.pcm`, on clang 19; or CMI `gcm.cache/std.gcm`, on gcc 15 (still does not work on bazel, but works on makefile!).
This CMI is imported into bazel with the new **experimental** rule `cc_compiled_module`.

Just type: `make std.pcm` to build it with clang 19.


### Just run bazel

```
$ bazel run //:myproject
INFO: Analyzed target //:myproject (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //:myproject up-to-date:
  bazel-bin/myproject
INFO: Elapsed time: 0.151s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
INFO: Running command line: bazel-bin/myproject

Hello world!
```

### Understanding the Demo: the C++

On C++ side, we have module `hello.cppm` that uses c++23 `import std` module:

```
// hello.cppm

export module hello;

import std;

export inline void say_hello(std::string_view const &name)
{
  std::cout << "Hello " << name << "!\n";
}
```

And also the C++ source `main.cc`, that consumes module `hello`:

```
// main.cc
import hello;

int main() {
  say_hello("world");
  return 0;
}
```

### Understanding the Demo: the bazel side

The BUILD file is very intuitive: `cc_module` declares modules, where `cc_module_binary` declares targets that consume modules.
Since `std.pcm` is built manually, then one must manually declare its dependency in targets with:

```
    copts = [
        "-fmodule-file=std=std.pcm",
        "-std=c++23",
    ],
```

Remember to use relevant rules from load statement: 

```
load("@rules_cpp23_modules//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")
```

See the complete `BUILD` for the demo (considering clang 19 compiler):

```
load("@rules_cpp23_modules//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")

cc_module(
    name = "hello",
    src = "hello.cppm",
    copts = [
        "-fmodule-file=std=std.pcm",
        "-std=c++23",
    ],
    deps = [":std"],
)

cc_module_binary(
    name = "myproject",
    srcs = [
        "main.cc",
    ],
    deps = [
        ":hello",
        ":std"
    ],
    copts = [
        "-fmodule-file=std=std.pcm",
        "-std=c++23",
    ],
    linkopts = [
        "-stdlib=libc++",
    ],
)

cc_compiled_module(
    name="std",
    cmi="std.pcm"
)
```

Finally, modules `hello` and `std` from c++23 can be built together into `myproject` binary demo.

Good luck!


## Copyleft

Apache 2.0 (inherited from rules_cc_modules project)

Igor M. Coelho, 2025