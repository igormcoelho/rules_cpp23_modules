# Demo9: hello-world project

This is an demo for project [rules_cpp23_modules](https://github.com/igormcoelho/rules_cpp23_modules).

> IMPORTANT: This demonstration requires Bazel 9 and only works with Clang compiler (not yet GCC!).

> For Bazel 8 or GCC compatible examples, see [demo/hello-world-project](../../demo/hello-world-project/README.md).

## How to use it (on clang!)

To expose the local std library, create an [extensions.bzl](./extensions.bzl) file for local repository `local_libcxx`:

```
load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")

def _libcxx_extension_impl(mctx):
    path = None
    for mod in mctx.modules:
        for tag in mod.tags.configure:
            path = tag.path
    new_local_repository(
        name = "local_libcxx",
        path = path,
        build_file_content = '''
load("@rules_cc//cc:defs.bzl", "cc_library")
cc_library(
    name = "std_modules",
    deps = [
        ":std",
        ":std_compat",
    ],
    visibility = ["//visibility:public"],
)
cc_library(
    name = "std",
    features = ["cpp_modules"],
    srcs = glob(["std/*.inc"]),
    module_interfaces = ["std.cppm"],
    visibility = ["//visibility:public"],
)
cc_library(
    name = "std_compat",
    features = ["cpp_modules"],
    srcs = glob(["std.compat/*.inc"]),
    module_interfaces = ["std.compat.cppm"],
    deps = [":std"],
    visibility = ["//visibility:public"],
)
''',
    )

configure = tag_class(attrs = {
    "path": attr.string(mandatory = True),
})

local_libcxx_extension = module_extension(
    implementation = _libcxx_extension_impl,
    tag_classes = {"configure": configure},
)
```

Then use it on your [MODULE.bazel](./MODULE.bazel) file:

```
bazel_dep(name = "rules_cc", version = "0.2.17")
local_libcxx = use_extension("//:extensions.bzl", "local_libcxx_extension")
local_libcxx.configure(path = "/usr/lib/llvm-21/share/libc++/v1")
use_repo(local_libcxx, "local_libcxx")
```

**IMPORTANT:** update the local libc++ path according to your clang version.

Update your [BUILD](./BUILD) with the targets that require `std_modules`:

```
    deps = ["@local_libcxx//:std_modules"]
```

Update your [.bazelrc](./.bazelrc) with clang toolchain:

```
build --repo_env=BAZEL_COMPILER=clang
build --repo_env=BAZEL_CXXOPTS=-stdlib=libc++
build --repo_env=BAZEL_LINKOPTS=-stdlib=libc++ 

build --experimental_cpp_modules
build --cxxopt=-std=c++23
```

### Just run bazel

```
$ bazel run //:myproject
Starting local Bazel server (9.1.0) and connecting to it...
INFO: Analyzed target //:myproject (86 packages loaded, 605 targets configured).
INFO: From Compiling std.cppm:
external/+local_libcxx_extension+local_libcxx/std.cppm:167:15: warning: 'std' is a reserved name for a module [-Wreserved-module-identifier]
  167 | export module std;
      |               ^
1 warning generated.
INFO: From Compiling std.compat.cppm:
external/+local_libcxx_extension+local_libcxx/std.compat.cppm:83:15: warning: 'std' is a reserved name for a module [-Wreserved-module-identifier]
   83 | export module std.compat;
      |               ^
1 warning generated.
INFO: Found 1 target...
Target //:myproject up-to-date:
  bazel-bin/myproject
INFO: Elapsed time: 6.665s, Critical Path: 2.83s
INFO: 33 processes: 13 internal, 20 linux-sandbox.
INFO: Build completed successfully, 33 total actions
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
  std::println("Hello {}!", name);
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

After Bazel 9, things are straightforward:

- all .cppm modules can be loaded with: `module_interfaces = ["hello.cppm"],`
- all regular .cc or .cpp sources can be loaded with: `srcs = ["main.cc"],`

IMPORTANT: remember to add `features = ["cpp_modules"]`, since this is still experimental.

Finally, modules `hello` and `std` from c++23 can be built together into `myproject` binary demo.

Good luck!