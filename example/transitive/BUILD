load("//cc_module:defs.bzl", "cc_module", "cc_compiled_module", "cc_module_binary")


cc_module(
    name = "b",
    src = "b.cppm",
    copts = [ "-std=c++23" ],
    deps = [":std"],
)

cc_module(
    name = "a",
    src = "a.cppm",
    copts = [ "-std=c++23" ],
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