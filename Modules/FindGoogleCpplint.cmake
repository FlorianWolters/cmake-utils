# FindGoogleCpplint.cmake
#
# Finds the style checker "Google cpplint" with the build system "CMake".
#
# Cache Variable:
#  CPPLINT_SCRIPT
#
# Non-cache variables you might use in your CMakeLists.txt:
#  CPPLINT_FOUND
#  CPPLINT_ROOT_DIR
#  CPPLINT_DEFAULT_LOCATIONS
#  CPPLINT_NOT_FOUND_MSG
#  CPPLINT_FIND_QUIETLY
#  CPPLINT_MARK_AS_ADVANCED - whether to mark our vars as advanced even
#    if we don't find this program.
#
# Requires these CMake modules:
#  FindPackageHandleStandardArgs (known included with CMake >=2.6.2)
#  FindPythonInterp
#  FindPythonLibs
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

if(florianwolters_find_google_cpplint_included)
  return()
endif()

set(florianwolters_find_google_cpplint_included TRUE)

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)

# Check python installation as cpplint is a python script
if(NOT PYTHONINTERP_FOUND)
  find_package(PythonInterp)
endif()

if(NOT PYTHONLIBS_FOUND)
  find_package(PythonLibs)
endif()

if(PYTHONINTERP_FOUND AND PYTHONLIBS_FOUND)
  set(_python_found true)
endif()

file(TO_CMAKE_PATH "${CPPLINT_ROOT_DIR}" CPPLINT_ROOT_DIR)
set(CPPLINT_ROOT_DIR
    "${CPPLINT_ROOT_DIR}"
    CACHE
    PATH
    "Path to search for cpplint")

if(CPPLINT_SCRIPT AND NOT EXISTS "${CPPLINT_SCRIPT}")
  set(CPPLINT_SCRIPT NOTFOUND CACHE PATH "" FORCE)
endif()

# If we have a custom path, look there first.
if(CPPLINT_ROOT_DIR)
  find_file(CPPLINT_SCRIPT
            NAMES "cpplint.py"
            PATHS ${CPPLINT_ROOT_DIR}
            NO_DEFAULT_PATH)
endif()

set(CPPLINT_SCRIPT_DEFAULT_LOCATIONS
    ${CMAKE_SOURCE_DIR}
    "${CMAKE_SOURCE_DIR}/cmake"
    "${CMAKE_SOURCE_DIR}/cmake/deps")

find_file(CPPLINT_SCRIPT
  NAMES cpplint.py
  PATHS ${CPPLINT_SCRIPT_DEFAULT_LOCATIONS})

if(_python_found)
  set(CPPLINT_NOT_FOUND_MSG "Could NOT find cpplint.py. Please copy e.g. http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py into one of the following directories:\n")

  foreach(location ${CPPLINT_SCRIPT_DEFAULT_LOCATIONS})
    set(CPPLINT_NOT_FOUND_MSG "${CPPLINT_NOT_FOUND_MSG} ${location} \n")
  endforeach(location ${CPPLINT_SCRIPT_DEFAULT_LOCATIONS})

  set(CPPLINT_NOT_FOUND_MSG "${CPPLINT_NOT_FOUND_MSG} or set CPPLINT_ROOT_DIR to the desired location\n")
else()
  set(CPPLINT_NOT_FOUND_MSG "Could NOT find python needed to run cpplint.py. Please check both executable and libraries are installed.")
endif()

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(cpplint "${CPPLINT_NOT_FOUND_MSG}" PYTHONINTERP_FOUND PYTHONLIBS_FOUND CPPLINT_SCRIPT)

if(CPPLINT_FOUND OR CPPLINT_MARK_AS_ADVANCED)
  mark_as_advanced(CPPLINT_ROOT_DIR)
endif()

mark_as_advanced(CPPLINT_SCRIPT)

if(CPPLINT_FOUND AND NOT CPPLINT_FIND_QUIETLY)
  message(STATUS "Found cpplint in ${CPPLINT_SCRIPT}")
endif()
