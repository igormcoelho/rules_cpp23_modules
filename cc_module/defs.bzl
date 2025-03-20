load("//cc_module/private:cc_module.bzl",
     _cc_module = "cc_module",
     _cc_header_module = "cc_header_module",
     _cc_module_binary = "cc_module_binary",
     _cc_module_library = "cc_module_library",
)

load("//cc_module/private:cc_compiled_module.bzl",
     _cc_compiled_module = "cc_compiled_module",
)

cc_module = _cc_module
cc_header_module = _cc_header_module
cc_compiled_module = _cc_compiled_module
cc_module_binary = _cc_module_binary
cc_module_library = _cc_module_library
