load("@rules_cpp23_modules//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")

cc_module(
    name = "hello",
    src = "hello.cppm",
    copts = [
        "-fmodule-file=std=std.pcm",
        "-std=c++23",
    ],
    deps = [":std"],
)


cc_module_binary(
    name = "myproject",
    srcs = [
        "main.cc",
    ],
    deps = [
        ":hello",
        ":std"
    ],
    copts = [
        "-fmodule-file=std=std.pcm",
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
