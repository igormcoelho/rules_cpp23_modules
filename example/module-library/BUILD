#load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//cc_module:defs.bzl", "cc_module", "cc_module_library", "cc_module_binary", "cc_compiled_module")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_module(
    name = "a",
    src = "a.cppm",
    copts = [ "-std=c++23" ],
)

cc_module_library(
    name = "b",
    hdrs = [
        "b.h",
    ],
    srcs = [
        "b.cc",
    ],
    deps = [
        ":a",
    ],
    copts = [ "-std=c++23" ],
)

cc_module_binary(
    name = "module_library",
    srcs = [
        "main.cc",
    ],
    deps = [
        ":b",
        ":std"
    ],
    copts = [ "-std=c++23" ],
)


cc_compiled_module(
    name = "std",
    cmi = "gcm.cache/std.gcm",
    module_name = "std",  # for both clang and gcc!
)

#cc_compiled_module(
#    name="std",
#    cmi="std.pcm",
#    module_name = "std",  # for both clang and gcc!
#)
