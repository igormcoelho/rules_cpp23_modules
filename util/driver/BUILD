load("@rules_python//python:defs.bzl", "py_binary")

py_binary(
    name = "driver",
    srcs = [
        "driver.py",
        "clang.py",
        "gcc.py",
    ],
    python_version = "PY3",
    visibility = ["//visibility:public"],
)
