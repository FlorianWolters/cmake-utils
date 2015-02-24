#.rst:
# Debug
# -----
#
# Debugging functions for the build system "CMake".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# ------------------------------------------------------------------------------
# Include guard.
# ------------------------------------------------------------------------------

if(florianwolters_debug_included)
  return()
endif()

set(florianwolters_debug_included 1)

function(debug_cmake_location_variables)
  message(STATUS "CMAKE_CURRENT_LIST_FILE  = ${CMAKE_CURRENT_LIST_FILE}")
  message(STATUS "CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
  message(STATUS "CMAKE_CURRENT_LIST_LINE = ${CMAKE_CURRENT_LIST_LINE}")
  message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
  message(STATUS "CMAKE_CURRENT_SOURCE_DIR = ${CMAKE_CURRENT_SOURCE_DIR}")
  message(STATUS "CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")
  message(STATUS "CMAKE_CURRENT_BINARY_DIR = ${CMAKE_CURRENT_BINARY_DIR}")
  message(STATUS "CMAKE_FILES_DIRECTORY = ${CMAKE_FILES_DIRECTORY}")
  message(STATUS "CMAKE_COMMAND = ${CMAKE_COMMAND}")
  message(STATUS "CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}")
  message(STATUS "CMAKE_ROOT = ${CMAKE_ROOT}")
  message(STATUS "EXECUTABLE_OUTPUT_PATH = ${EXECUTABLE_OUTPUT_PATH}")
  message(STATUS "LIBRARY_OUTPUT_PATH = ${LIBRARY_OUTPUT_PATH}")
  message(STATUS "PROJECT_NAME = ${PROJECT_NAME}")
  message(STATUS "CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}")
  message(STATUS "PROJECT_SOURCE_DIR = ${PROJECT_SOURCE_DIR}")
  message(STATUS "PROJECT_BINARY_DIR = ${PROJECT_BINARY_DIR}")
endfunction()

function(debug_cmake_system_and_compiler_information_variables)
  message(STATUS "CMAKE_MAJOR_VERSION = ${CMAKE_MAJOR_VERSION}")
  message(STATUS "CMAKE_MINOR_VERSION = ${CMAKE_MINOR_VERSION}")
  message(STATUS "CMAKE_PATCH_VERSION = ${CMAKE_PATCH_VERSION}")
  message(STATUS "CMAKE_TWEAK_VERSION = ${CMAKE_TWEAK_VERSION}")
  message(STATUS "CMAKE_VERSION = ${CMAKE_VERSION}")
  message(STATUS "CMAKE_SYSTEM = ${CMAKE_SYSTEM}")
  message(STATUS "CMAKE_SYSTEM_NAME = ${CMAKE_SYSTEM_NAME}")
  message(STATUS "CMAKE_SYSTEM_VERSION = ${CMAKE_SYSTEM_VERSION}")
  message(STATUS "CMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}")
  message(STATUS "CMAKE_GENERATOR = ${CMAKE_GENERATOR}")
  message(STATUS "UNIX = ${UNIX}")
  message(STATUS "WIN32 = ${WIN32}")
  message(STATUS "APPLE = ${APPLE}")
  message(STATUS "MINGW = ${MINGW}")
  message(STATUS "MSYS = ${MSYS}")
  message(STATUS "CYGWIN = ${CYGWIN}")
  message(STATUS "BORLAND = ${BORLAND}")
  message(STATUS "WATCOM = ${WATCOM}")
  message(STATUS "MSVC = ${MSVC}")
  message(STATUS "MSVC_IDE = ${MSVC_IDE}")
  message(STATUS "MSVC60 = ${MSVC60}")
  message(STATUS "MSVC70 = ${MSVC70}")
  message(STATUS "MSVC71 = ${MSVC71}")
  message(STATUS "MSVC80 = ${MSVC80}")
  message(STATUS "CMAKE_COMPILER_2005 = ${CMAKE_COMPILER_2005}")
  message(STATUS "MSVC90 = ${MSVC90}")
  message(STATUS "MSVC10 = ${MSVC10}")
  message(STATUS "CMAKE_C_COMPILER_ID = ${CMAKE_C_COMPILER_ID}")
  message(STATUS "CMAKE_CXX_COMPILER_ID = ${CMAKE_CXX_COMPILER_ID}")
  message(STATUS "CMAKE_COMPILER_IS_GNUCC = ${CMAKE_COMPILER_IS_GNUCC}")
  message(STATUS "CMAKE_COMPILER_IS_GNUCXX = ${CMAKE_COMPILER_IS_GNUCXX}")
endfunction()

function(debug_cmake_various_options_variables)
  message(STATUS "CMAKE_SKIP_RULE_DEPENDENCY = ${CMAKE_SKIP_RULE_DEPENDENCY}")
  message(STATUS "CMAKE_SKIP_INSTALL_ALL_DEPENDENCY = ${CMAKE_SKIP_INSTALL_ALL_DEPENDENCY}")
  message(STATUS "CMAKE_SKIP_RPATH = ${CMAKE_SKIP_RPATH}")
  message(STATUS "CMAKE_INCLUDE_CURRENT_DIR = ${CMAKE_INCLUDE_CURRENT_DIR}")
  message(STATUS "CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE = ${CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE}")
  message(STATUS "CMAKE_VERBOSE_MAKEFILE = ${CMAKE_VERBOSE_MAKEFILE}")
  message(STATUS "CMAKE_SUPPRESS_REGENERATION = ${CMAKE_SUPPRESS_REGENERATION}")
  message(STATUS "CMAKE_COLOR_MAKEFILE = ${CMAKE_COLOR_MAKEFILE}")
  message(STATUS "CMAKE_SKIP_PREPROCESSED_SOURCE_RULES = ${CMAKE_SKIP_PREPROCESSED_SOURCE_RULES}")
  message(STATUS "CMAKE_SKIP_ASSEMBLY_SOURCE_RULES = ${CMAKE_SKIP_ASSEMBLY_SOURCE_RULES}")
  message(STATUS "CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS = ${CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS}")
  message(STATUS "CMAKE_SKIP_RULE_DEPENDENCY = ${CMAKE_SKIP_RULE_DEPENDENCY}")
  message(STATUS "CMAKE_SKIP_RULE_DEPENDENCY = ${CMAKE_SKIP_RULE_DEPENDENCY}")
endfunction()

function(debug_biicode_block_variables)
  message(STATUS "BII_BLOCK_NAME = ${BII_BLOCK_NAME}")
  message(STATUS "BII_BLOCK_USER = ${BII_BLOCK_USER}")
  message(STATUS "BII_LIB_SRC = ${BII_LIB_SRC}")
  message(STATUS "BII_LIB_TYPE = ${BII_LIB_TYPE}")
  message(STATUS "BII_LIB_DEPS = ${BII_LIB_DEPS}")
  message(STATUS "BII_LIB_SYSTEM_HEADERS = ${BII_LIB_SYSTEM_HEADERS}")
endfunction()

function(debug_biicode_targets_variables)
  message(STATUS "BII_BLOCK_TARGET = ${BII_BLOCK_TARGET}")
  message(STATUS "BII_LIB_TARGET = ${BII_LIB_TARGET}")
  message(STATUS "BII_BLOCK_TARGETS = ${BII_BLOCK_TARGETS}")
  message(STATUS "BII_BLOCK_EXES = ${BII_BLOCK_EXES}")
endfunction()
