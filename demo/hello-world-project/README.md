# Demo: hello-world project

This is an demo for project [rules_cpp23_modules](https://github.com/igormcoelho/rules_cpp23_modules).


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

## Understanding the Demo

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
load("@rules_cpp23_module//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")
```

Finally, modules `hello` and `std` from c++23 can be built together into `myproject` binary demo.

Good luck!