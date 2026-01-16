cmake_minimum_required(VERSION 3.14)
project(app_permission_manager_plugin LANGUAGES CXX)

add_library(app_permission_manager_plugin SHARED
  app_permission_manager_plugin.cpp
  app_permission_manager_plugin.h
)

target_link_libraries(app_permission_manager_plugin PUBLIC flutter_wrapper_plugin)

target_compile_definitions(app_permission_manager_plugin PUBLIC FLUTTER_PLUGIN_IMPL)
