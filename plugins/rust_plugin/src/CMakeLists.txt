# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(rust_plugin_library VERSION 0.0.1 LANGUAGES C)

add_library(rust_plugin SHARED
  "rust_plugin.c"
)

set_target_properties(rust_plugin PROPERTIES
  PUBLIC_HEADER rust_plugin.h
  OUTPUT_NAME "rust_plugin"
)

target_compile_definitions(rust_plugin PUBLIC DART_SHARED_LIB)

set_directory_properties(PROPERTIES EP_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/rust_project_name)

execute_process(
  COMMAND cargo build --release
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/rust_project_name
  OUTPUT_VARIABLE outVar
)

if (WIN32)
  set(SIM_LIB_NAME "rust_project_name.dll")
endif()

install(
  FILES "rust_project_name/target/${SIM_LIB_NAME}"
  DESTINATION "${CMAKE_INSTALL_PREFIX}/lib"
)