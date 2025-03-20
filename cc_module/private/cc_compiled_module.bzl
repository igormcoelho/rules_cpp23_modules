# Copyright 2019 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ==================================================================
# INSPIRED BY cc_module.bzl (cc_module_header) from rules_cc_modules
# ==================================================================

load("//cc_module/private:cc_module_archive.bzl", "cc_module_archive_action")
load("//cc_module/private:cc_module_compile.bzl", 
     "cc_module_compile_action",
     "cc_header_module_compile_action",
)
load("//cc_module/private:cc_module_link.bzl", "cc_module_link_action")
load("//cc_module/private:utility.bzl", 
      "get_cc_info_deps",
      "get_module_deps",
      "get_header_module_name",
      "make_module_mapper",
      "make_module_compilation_context",
     )
load("//cc_module/private:provider.bzl", "ModuleCompileInfo", "ModuleCompilationContext")


_common_attrs = {
  "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
  "_driver": attr.label(
      default = Label("//util/driver"),
      executable = True,
      cfg = "exec",
  ),
  "deps": attr.label_list(),
  "copts": attr.string_list(),
  "linkopts": attr.string_list(),
}


###########################################################################################
# cc_compiled_module (INSPIRED BY cc_header_module)
###########################################################################################
def _cc_compiled_module_impl(ctx):
  hdr = ctx.file.cmi
  module_name = "./" + hdr.path

  module_out_file = ctx.actions.declare_file(hdr.basename) 

  includes = []
  hdr_dep = [hdr]
  outputs = [module_out_file]

  deps = ctx.attr.deps
  cc_info_deps = get_cc_info_deps(deps)

  module_deps = get_module_deps(deps)

  module_info = ModuleCompileInfo(
      module_name = module_name,
      module_file = module_out_file,
      module_dependencies = module_deps,
  )
  module_map = make_module_mapper(
      ctx.label.name,
      ctx.actions, 
      module_deps)
  compilation_context = make_module_compilation_context(cc_info_deps, module_map, module_deps)
  # ================ WORKAROUND ===============
  #cc_header_module_compile_action(ctx, src=hdr,
  #                         compilation_context=compilation_context,
  #                         module_info=module_info)
  #
  # HELP:  I just need to pass .gcm / .pcm file directly to bazel, so I fake it here...
  # HELP2: there MUST be a better way of doing this...
  # ============================================
  ctx.actions.run_shell(
    outputs = [module_out_file],
    command = "touch %s" % module_out_file.path,
  )
  # ===========================================

  hdr_compilation_context = cc_common.create_compilation_context(
      headers = depset(hdr_dep),
      includes = depset(includes),
  )
  cc_info = CcInfo(
      compilation_context = hdr_compilation_context,
  )
  cc_info = cc_common.merge_cc_infos(cc_infos=[cc_info, cc_info_deps])
  
  return [
        DefaultInfo(files = depset(outputs)),
        cc_info,
        module_info,
  ]


_cc_compiled_module_attrs = {
  "cmi": attr.label(mandatory = True, allow_single_file = True),
}

cc_compiled_module = rule(
    implementation = _cc_compiled_module_impl,
    attrs = dict(_common_attrs.items() + _cc_compiled_module_attrs.items()),
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
    incompatible_use_toolchain_transition = True,
    fragments = ["cpp"],
)