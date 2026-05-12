# BUILD file
load("@rules_cpp23_modules//cc_module:defs.bzl", "cc_compiled_module", "cc_module_binary")

cc_binary(
    name = "demo_nostd",
    srcs = ["main.cpp"],
    copts = ["-std=c++23"],
)

cc_module_binary(
    name = "demo_std",
    srcs = ["main2.cpp"],
    copts = ["-std=c++23"],
    deps = [":std"]
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
