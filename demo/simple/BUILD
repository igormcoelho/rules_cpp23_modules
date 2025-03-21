# BUILD file
load("@rules_cpp23_modules//cc_module:defs.bzl", "cc_compiled_module", "cc_module_binary")

cc_binary(
    name = "demo",
    srcs = ["main.cpp"],
    copts = ["-std=c++23", "-stdlib=libc++"],
    linkopts = ["-stdlib=libc++"]
)

cc_module_binary(
    name = "demo2",
    srcs = ["main2.cpp"],
    copts = [
        "-fmodule-file=std=std.pcm",
        "-std=c++23",
    ],
    linkopts = ["-stdlib=libc++"],
    deps = [":std"]
)

cc_compiled_module(
    name="std",
    cmi="std.pcm"
)
