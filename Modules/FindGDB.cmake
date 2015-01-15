# FindGDB.cmake
#
# Finds the "GNU Debugger (GDB)" with the build system "CMake".
#
# This module accepts the following INPUT variables:
#
# GDB_ROOT_DIR - [optional] The directory containing "GNU Debugger (GDB)".
#
# This module defines the following OUTPUT variables:
#
# GDB_FOUND                   - Whether "GNU Debugger (GDB)" has been found.
#    TRUE if "GNU Debugger (GDB)" has been found or "FALSE" if "GNU Debugger
#    (GDB)" has not been found.
# GDB_COMMAND                 - The command to run "GNU Debugger (GDB)".
# GDB_VERSION                 - The version of "GNU Debugger (GDB)".
# GDB_HAS_RETURN_CHILD_RESULT - If the --return-child-result flag is supported.
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_find_gdb_included)
  return()
endif()

set(florianwolters_find_gdb_included TRUE)
# End of include guard.

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)

set(GDB_ROOT_DIR ${GDB_ROOT_DIR}
    CACHE PATH "The absolute directory path to start searching for \"GNU Debugger (GDB)\".")

find_program(GDB_COMMAND
             NAMES gdb
             HINTS ${GDB_ROOT_DIR}
             PATH_SUFFIXES bin libexec
             DOC "The command to run \"GNU Debugger (GDB)\".")

if(GDB_COMMAND)
  execute_process(COMMAND ${GDB_COMMAND} --version
                  COMMAND head -n 1
                  OUTPUT_VARIABLE GDB_VERSION
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
  string(REGEX REPLACE "[^0-9]*([0-9]+[0-9.]*).*" "\\1" GDB_VERSION ${GDB_VERSION})
endif()

include(FindPackageHandleStandardArgs)

# Handle the REQUIRED, QUIET and version-related arguments to the find_package
# command and set the GDB_FOUND variable.
find_package_handle_standard_args(GDB
                                  FOUND_VAR GDB_FOUND
                                  REQUIRED_VARS GDB_COMMAND GDB_VERSION
                                  VERSION_VAR GDB_VERSION)

set(GDB_HAS_RETURN_CHILD_RESULT FALSE)

if(GDB_FOUND)
  if(GDB_VERSION VERSION_GREATER 6.3)
    set(GDB_HAS_RETURN_CHILD_RESULT TRUE)
  endif()

  mark_as_advanced(GDB_ROOT_DIR)
endif()

# Mark the named cached variables as advanced. An advanced variable will not be
# displayed in any of the CMake GUIs unless the show advanced option is on.
mark_as_advanced(GDB_COMMAND)
