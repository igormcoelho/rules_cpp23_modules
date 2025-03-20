# rules_cpp23_module

This project is the same as [rburn/rules_cc_module](https://github.com/rnburn/rules_cc_module), but including a **VERY EXPERIMENTAL** rule called `cc_compiled_module` to allow using C++23 `import std;` feature on bazel.

At the time of writing, there's no official support in Bazel, although two ongoing PRs may solve this (I hope very soon!).

- https://github.com/bazelbuild/bazel/pull/22553
- https://github.com/bazelbuild/bazel/pull/22555

See [Issue 15 on rules_cc_module](https://github.com/rnburn/rules_cc_module/issues/15).

When those two PRs above are merged and bazel officially supports modules, you must **Abandon this project!**.

For now, feel free to test modules and `import std;` on Bazel 8  ;)

## Getting started

See examples!

For now, see [example/hello-world/README.md](./example/hello-world/README.md).


## Copyleft

Apache 2.0 (inherited from rules_cc_modules)

Igor M. Coelho, 2025