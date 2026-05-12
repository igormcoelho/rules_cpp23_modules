load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
# IMPORTANT: this demo9/ folder does NOT depend on rules_cpp23_modules anymore!
# Bazel 9 has official support for modules (at least for clang compiler...)
# However, this still depends on locally exposing the std.cppm file for clang (see MODULE.bazel)
# For Bazel 8-, see demo/ for demonstrations with rules_cpp23_modules, for gcc and clang.

cc_library(
    name = "hello",
    features = ["cpp_modules"],
    module_interfaces = ["hello.cppm"],
    deps = ["@local_libcxx//:std_modules"]
)

cc_binary(
    name = "myproject",
    srcs = ["main.cc"],
    deps = [":hello"],
    features = ["cpp_modules"],
)

