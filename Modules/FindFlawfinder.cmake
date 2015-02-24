#.rst:
# FindFlawfinder
# --------------
#
# Finds the static code analyzer "Flawfinder" with the build system "CMake".
#
# This module accepts the following INPUT variables:
#
# FLAWFINDER_ROOT_DIR - [optional] The directory containing "Flawfinder".
#
# This module defines the following OUTPUT variables:
#
# FLAWFINDER_FOUND   - Whether "Flawfinder" has been found. TRUE if "Flawfinder"
#    has been found or "FALSE" if "Flawfinder" has not been found.
# FLAWFINDER_COMMAND - The command to run "Flawfinder".
# FLAWFINDER_VERSION - The version of "Flawfinder".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_find_flawfinder_included)
  return()
endif()

set(florianwolters_find_flawfinder_included TRUE)
# End of include guard.

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)

# A "Python" interpreter is required, since "Flawfinder" is implemented as a
# "Python" script.
if(NOT PYTHONINTERP_FOUND)
  find_package(PythonInterp 2 REQUIRED)
endif()

set(FLAWFINDER_ROOT_DIR ${FLAWFINDER_ROOT_DIR}
    CACHE PATH "The absolute directory path to start searching for \"Flawfinder\".")

find_program(FLAWFINDER_COMMAND
             NAMES flawfinder
             HINTS ${FLAWFINDER_ROOT_DIR}
             PATH_SUFFIXES bin
             DOC "The command to run \"Flawfinder\".")

if(FLAWFINDER_COMMAND)
  execute_process(COMMAND ${PYTHON_EXECUTABLE} ${FLAWFINDER_COMMAND} --version
                  OUTPUT_VARIABLE FLAWFINDER_VERSION
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

include(FindPackageHandleStandardArgs)

# Handle the REQUIRED, QUIET and version-related arguments to the find_package
# command and set the FLAWFINDER_FOUND variable.
find_package_handle_standard_args(FLAWFINDER
                                  FOUND_VAR FLAWFINDER_FOUND
                                  REQUIRED_VARS FLAWFINDER_COMMAND FLAWFINDER_VERSION
                                  VERSION_VAR FLAWFINDER_VERSION)

if(FLAWFINDER_FOUND)
  mark_as_advanced(FLAWFINDER_ROOT_DIR)
endif()

# Mark the named cached variables as advanced. An advanced variable will not be
# displayed in any of the CMake GUIs unless the show advanced option is on.
mark_as_advanced(FLAWFINDER_COMMAND)
