#load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//cc_module:defs.bzl", "cc_module", "cc_module_library", "cc_compiled_module")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_module(
    name = "a",
    src = "a.cppm",
    copts = [
        "-std=c++23",
    ],
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
    copts = [
        "-std=c++23",
    ],
)

cc_binary(
    name = "module_library",
    srcs = [
        "main.cc",
    ],
    deps = [
        ":b",
        ":std"
    ],
    copts = [
        "-fmodule-file=std=example/module-library/std.pcm",
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
