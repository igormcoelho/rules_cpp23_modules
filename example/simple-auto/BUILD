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
    # deps = ["@local_libcxx//:std"]
    deps = [":std"]
)

'''
# THIS REQUIRES MOUNTING THE LOCAL std.cppm DIRECTORY...
genrule(
    name = "build_std_pcm",
    srcs = ["std.cppm"] + glob(["std/*.inc"]),
    outs = ["std_generated.pcm"],
    cmd = "clang++ -std=c++23 -stdlib=libc++" +
          " -U_FORTIFY_SOURCE -fstack-protector -Wall" +
          " -Wthread-safety -Wself-assign -Wunused-but-set-parameter" +
          " -Wno-free-nonheap-object -fcolor-diagnostics" +
          " -fno-omit-frame-pointer -fPIC" +
          " -Wno-reserved-module-identifier -Wno-reserved-identifier" +
          " --precompile -o $@ $(location std.cppm)",
)
'''

genrule(
    name = "build_std_gcm",
    srcs = [],
    outs = ["std_generated.gcm"],
    cmd = "g++ -std=c++23 -fmodules -fPIC -fstack-protector" +
          " -U_FORTIFY_SOURCE -Wall -Wunused-but-set-parameter" +
          " -Wno-free-nonheap-object -fno-omit-frame-pointer" +
          " -c -fmodules -fsearch-include-path bits/std.cc" +
          " && cp gcm.cache/std.gcm $@",
)

cc_compiled_module(
    name = "std",
    cmi = ":build_std_gcm",
    module_name = "std",
    visibility = ["//visibility:public"],
)

#cc_compiled_module(
#    name = "std",
#    cmi = "gcm.cache/std.gcm",
#    module_name = "std",  # for both clang and gcc!
#)

#cc_compiled_module(
#    name="std",
#    cmi="std.pcm",
#    module_name = "std",  # for both clang and gcc!
#)
