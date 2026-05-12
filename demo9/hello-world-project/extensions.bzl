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
cc_library(
    name = "std_modules",
    deps = [
        ":std",
        ":std_compat",
    ],
    visibility = ["//visibility:public"],
)
cc_library(
    name = "std",
    features = ["cpp_modules"],
    srcs = glob(["std/*.inc"]),
    module_interfaces = ["std.cppm"],
    visibility = ["//visibility:public"],
)
cc_library(
    name = "std_compat",
    features = ["cpp_modules"],
    srcs = glob(["std.compat/*.inc"]),
    module_interfaces = ["std.compat.cppm"],
    deps = [":std"],
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
