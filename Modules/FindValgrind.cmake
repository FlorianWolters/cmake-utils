# FindValgrind.cmake
#
# Finds the profiler and memory debugger "Valgrind" with the build system
# "CMake".
#
# This module accepts the following INPUT variables:
#
# VALGRIND_ROOT_DIR - [optional] The directory containing "Valgrind".
#
# This module defines the following OUTPUT variables:
#
# VALGRIND_FOUND       - Whether "Valgrind" has been found. TRUE if "Valgrind"
#    has been found or "FALSE" if "Valgrind" has not been found.
# VALGRIND_COMMAND     - The command to run "Valgrind".
# VALGRIND_INCLUDE_DIR - The absolute path to the directory containing the
#    header files of "Valgrind".
# VALGRIND_VERSION     - The version of "Valgrind".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_find_valgrind_included)
  return()
endif()

set(florianwolters_find_valgrind_included TRUE)
# End of include guard.

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)

set(VALGRIND_ROOT_DIR ${VALGRIND_ROOT_DIR}
    CACHE PATH "The absolute directory path to start searching for \"Valgrind\".")

find_program(VALGRIND_COMMAND
             NAMES valgrind
             HINTS ${VALGRIND_ROOT_DIR}
             PATHS /usr
                   /usr/local
             PATH_SUFFIXES bin
             DOC "The command to run \"Valgrind\".")

if(VALGRIND_COMMAND)
    execute_process(COMMAND ${VALGRIND_COMMAND} --version
                    OUTPUT_VARIABLE VALGRIND_VERSION
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
    string(REGEX REPLACE "^valgrind-([0-9].[0-9].[0-9])$" "\\1" VALGRIND_VERSION ${VALGRIND_VERSION})
endif()

include(FindPackageHandleStandardArgs)

# Handle the REQUIRED, QUIET and version-related arguments to the find_package
# command and set the VALGRIND_FOUND variable.
find_package_handle_standard_args(Valgrind
                                  FOUND_VAR VALGRIND_FOUND
                                  REQUIRED_VARS VALGRIND_COMMAND
                                                VALGRIND_VERSION
                                  VERSION_VAR VALGRIND_VERSION)

set(VALGRIND_HAS_RETURN_CHILD_RESULT FALSE)

if(VALGRIND_FOUND)
  if(VALGRIND_VERSION VERSION_GREATER 6.3)
    set(VALGRIND_HAS_RETURN_CHILD_RESULT TRUE)
  endif()

  find_path(VALGRIND_INCLUDE_DIR
            NAMES valgrind.h memcheck.h helgrind.h
            PATHS /usr
                  ${VALGRIND_ROOT_DIR}
            PATH_SUFFIXES include valgrind local
            DOC "The directory containing the header files of \"Valgrind\".")

  if(NOT VALGRIND_INCLUDE_DIR)
    message(WARNING "Unable to find the source files of \"Valgrind\". Install \"valgrind-devel\" to be able to use \"Valgrind\" in the source code of the project.")
  endif()

  mark_as_advanced(VALGRIND_ROOT_DIR VALGRIND_INCLUDE_DIR)
endif()

# Mark the named cached variables as advanced. An advanced variable will not be
# displayed in any of the CMake GUIs unless the show advanced option is on.
mark_as_advanced(VALGRIND_COMMAND)
