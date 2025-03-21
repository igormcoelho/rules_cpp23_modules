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

1.  [example/hello-world/README.md](./example/hello-world/README.md).
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/hello-world:hello_world`
2.  [example/module-library/README.md](./example/module-library/README.md).
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/module-library:module_library`
3.  [example/multi_src_module/README.md](./example/multi_src_module/README.md).
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/multi_src_module:multi_src_demo`
4.  [example/template-module/README.md](./example/template-module/README.md).
   * Or manually generate `std.pcm` (see instructions on readme) and run: `bazel run //example/template-module:example`

More coming soon...

## Copyleft

Apache 2.0 (inherited from rules_cc_modules project)

Igor M. Coelho, 2025