#.rst:
# GoogleTest
# ----------
#
# Defines functions related to the C++ testing framework "Google Test (GTest)"
# for build system "CMake".
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

if(florianwolters_google_test_included)
  return()
endif()

set(florianwolters_google_test_included 1)

# Downloads, configures and builds the test framework "Google Test".
#
# TODO(wolters): The function get_googletest does work, but it would be nice to
# have a callback system like "find_library".
#
# Input parameters:
#
# GTEST_VERSION    - [optional] The version of "Google Test" to download. Has to
#    be the exact version, e. g. "1.7.0" instead of "1.7". (default = "1.7.0")
# DOWNLOAD_TIMEOUT - [optional] The time in seconds allowed for the download of
#    "Google Test". (default = 15)
#
# Output parameters:
#
# GTEST_INCLUDE_DIR  - The absolute directory path to the directory containing
#    the header files of "Google Test".
# GTEST_INCLUDE_DIRS - Equal to GTEST_INCLUDE_DIR.
# GTEST_LIBRARY      - The absolute file path to the "Google Test" library
#    `gtest`.
# GTEST_MAIN_LIBRARY - The absolute file path to the "Google Test" library
#    `gtest_main`.
#
# Example:
#
# Download, configure and build version 1.6.0 of the test framework "Google
# Test", with a maximum download time of 10 seconds.
#
#     get_googletest("1.6.0" 10)
function(get_googletest)
  set(GTEST_VERSION ${ARGV0})
  set(DOWNLOAD_TIMEOUT ${ARGV1})

  if(NOT GTEST_VERSION)
    set(GTEST_VERSION "1.7.0")
  endif()

  if(NOT DOWNLOAD_TIMEOUT)
    set(DOWNLOAD_TIMEOUT 15)
  endif()

  set(GTEST_EXTERNAL_PROJECT_NAME "get_googletest")
  set(GTEST_DOWNLOAD_URL "https://googletest.googlecode.com/files/gtest-${GTEST_VERSION}.zip")
  ExternalProject_Add(${GTEST_EXTERNAL_PROJECT_NAME}
                      # Download step.
                      URL ${GTEST_DOWNLOAD_URL}
                      TIMEOUT ${DOWNLOAD_TIMEOUT}
                      # Configure step.
                      CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                                 -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG:PATH=Debug
                                 -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE:PATH=Release
                                 -Dgtest_force_shared_crt=ON
                                 -Wno-dev
                      # Install step.
                      INSTALL_COMMAND ""
                      # Output logging.
                      LOG_DOWNLOAD 1
                      LOG_CONFIGURE 1
                      LOG_INSTALL 1)
  ExternalProject_Get_Property(${GTEST_EXTERNAL_PROJECT_NAME} source_dir)
  set(GTEST_INCLUDE_DIR "${source_dir}/include" CACHE INTERNAL "" FORCE)
  set(GTEST_INCLUDE_DIRS ${GTEST_INCLUDE_DIR} CACHE INTERNAL "" FORCE)

  ExternalProject_Get_Property(${GTEST_EXTERNAL_PROJECT_NAME} binary_dir)
  set(GTEST_PREFIX "gtest")

  if (WIN32)
    set(GTEST_PREFIX "lib${GTEST_PREFIX}")
  endif()

  set(GTEST_LIBRARY "${binary_dir}/${CMAKE_BUILD_TYPE}/${GTEST_PREFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}" CACHE INTERNAL "" FORCE)
  set(GTEST_MAIN_LIBRARY "${binary_dir}/${CMAKE_BUILD_TYPE}/${GTEST_PREFIX}_main${CMAKE_STATIC_LIBRARY_SUFFIX}" CACHE INTERNAL "" FORCE)
  set(GTEST_BOTH_LIBRARIES ${GTEST_LIBRARY} ${GTEST_MAIN_LIBRARY} CACHE INTERNAL "" FORCE)
  set(GTEST_FOUND TRUE CACHE INTERNAL "" FORCE)
endfunction()
