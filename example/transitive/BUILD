load("//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")


cc_module(
    name = "b",
    src = "b.cppm",
    copts = [
        "-fmodule-file=std=example/transitive/std.pcm",
        "-std=c++23",
    ],
    deps = [":std"],
)

cc_module(
    name = "a",
    src = "a.cppm",
    copts = [
        "-fmodule-file=std=example/transitive/std.pcm",
        "-std=c++23",
    ],
    deps = [":b", ":std"],
)


cc_module_binary(
    name = "trans",
    srcs = [
        "main.cc",
    ],
    deps = [
        ":a",
        ":std"
    ],
    copts = [
        "-fmodule-file=std=example/transitive/std.pcm",
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
