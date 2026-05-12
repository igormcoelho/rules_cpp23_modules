load("//cc_module:defs.bzl", "cc_module", "cc_module_binary", "cc_compiled_module")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_module(
    name = "spanish_english_dictionary",
    src = "spanish_english_dictionary.cppm",
    impl_srcs = [
        "spanish_english_dictionary_impl.cc",
    ],
    copts = [ "-std=c++23" ],
    deps = [
        ":std",
    ],
)

cc_module(
    name = "speech",
    src = "speech.cppm",
    impl_srcs = [
        "speech_impl.cc",
    ],
    copts = [ "-std=c++23" ],
    impl_deps = [
        ":spanish_english_dictionary",
    ],
    deps = [ ":std" ],
)

cc_module_binary(
    name = "multi_src_demo",
    srcs = [
        "main.cc",
    ],
    deps = [
        ":speech",
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