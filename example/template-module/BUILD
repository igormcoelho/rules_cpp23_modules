load("//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")

cc_module(
    name = "algorithm",
    src = "algorithm.cppm",
    copts = [
        "-fmodule-file=std=example/template-module/std.pcm",
        "-std=c++23",
    ],
    deps = [":std"],
)


cc_module_binary(
    name = "example",
    srcs = [
        "main.cc",
    ],
    deps = [
        ":algorithm",
        ":std"
    ],
    copts = [
        "-fmodule-file=std=example/template-module/std.pcm",
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
