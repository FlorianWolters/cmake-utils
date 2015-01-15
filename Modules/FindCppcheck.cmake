# FindCppcheck.cmake
#
# Finds the static code analyzer "Cppcheck" with the build system "CMake".
#
# This module accepts the following INPUT variables:
#
# CPPCHECK_ROOT_DIR - [optional] The directory containing "Cppcheck".
#
# This module defines the following OUTPUT variables:
#
# CPPCHECK_FOUND       - Whether "Cppcheck" has been found. TRUE if "Cppcheck"
#    has been found or "FALSE" if "Cppcheck" has not been found.
# CPPCHECK_COMMAND     - The command to run "Cppcheck".
# CPPCHECK_VERSION     - The version of "Cppcheck".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_find_cppcheck_included)
  return()
endif()

set(florianwolters_find_cppcheck_included TRUE)
# End of include guard.

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)

set(CPPCHECK_ROOT_DIR ${CPPCHECK_ROOT_DIR}
    CACHE PATH "The absolute directory path to start searching for \"Cppcheck\".")

find_program(CPPCHECK_COMMAND
             NAMES cppcheck
             PATHS ${CPPCHECK_ROOT_DIR}
             DOC "The command to run \"Cppcheck\".")

if(CPPCHECK_COMMAND)
  execute_process(COMMAND ${CPPCHECK_COMMAND} --version
                  OUTPUT_VARIABLE CPPCHECK_VERSION
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
  string(REGEX REPLACE "^Cppcheck ([0-9].[0-9][0-9])$" "\\1" CPPCHECK_VERSION ${CPPCHECK_VERSION})
endif()


include(FindPackageHandleStandardArgs)

# Handle the REQUIRED, QUIET and version-related arguments to the find_package
# command and set the VALGRIND_FOUND variable.
find_package_handle_standard_args(Cppcheck
                                  FOUND_VAR CPPCHECK_FOUND
                                  REQUIRED_VARS CPPCHECK_COMMAND
                                                CPPCHECK_VERSION
                                  VERSION_VAR CPPCHECK_VERSION)

if(CPPCHECK_FOUND)
  mark_as_advanced(CPPCHECK_ROOT_DIR)
endif()

# Mark the named cached variables as advanced. An advanced variable will not be
# displayed in any of the CMake GUIs unless the show advanced option is on.
mark_as_advanced(CPPCHECK_COMMAND)
