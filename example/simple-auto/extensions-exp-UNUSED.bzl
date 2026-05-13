load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")
def _libcxx_extension_impl(mctx):
    path = None
    for mod in mctx.modules:
        for tag in mod.tags.configure:
            path = tag.path
    new_local_repository(
        name = "local_libcxx",
        path = path,
        build_file_content = '''
load("@rules_cc//cc:defs.bzl", "cc_library")
load("@rules_cpp23_modules//cc_module:defs.bzl", "cc_compiled_module")

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
''',
    )

configure = tag_class(attrs = {
    "path": attr.string(mandatory = True),
})

local_libcxx_extension = module_extension(
    implementation = _libcxx_extension_impl,
    tag_classes = {"configure": configure},
)