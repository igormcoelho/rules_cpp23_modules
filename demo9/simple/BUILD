load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
# IMPORTANT: this demo9/ folder does NOT depend on rules_cpp23_modules anymore!
# Bazel 9 has official support for modules (at least for clang compiler...)
# See demo/ for demonstrations with rules_cpp23_modules and Bazel 8, for gcc and clang.

cc_binary(
    name = "demo_nostd",
    srcs = ["main.cpp"],
)

cc_binary(
    name = "demo_std",
    srcs = ["main2.cpp"],
    features = ["cpp_modules"],
    #deps = [":std"]
    deps = ["@local_libcxx//:std_modules"]
)

'''
# this is for local symlink strategy proposed by @unennhexium: 
# https://github.com/rnburn/rules_cc_module/issues/19
# ln -vs /usr/lib/llvm-21/share/libc++/v1 std
#
cc_library(
    name = "std",
    features = ["cpp_modules"],
    srcs = glob(["std/std/*.inc"]),
    module_interfaces = ["std/std.cppm"],
)
'''
