#.rst:
# CMake
# -----
#
# Unsorted macros and functions for the build system "CMake".
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

if(florianwolters_cmake_included)
  return()
endif()

set(florianwolters_cmake_included 1)

function(add_check_target)
  add_custom_target("check" COMMAND ${CMAKE_CTEST_COMMAND})
endfunction()

# Disallows in-source builds in favor of out-of-source builds.
function(assert_out_of_source_build)
  # Ensure the user does not play dirty with symbolic links.
  get_filename_component(SOURCE_DIR "${CMAKE_SOURCE_DIR}" REALPATH)
  get_filename_component(BINARY_DIR "${CMAKE_BINARY_DIR}" REALPATH)

  # Check for in-source build.
  if(${SOURCE_DIR} STREQUAL ${BINARY_DIR})
    message("Attempt to build inside of the source directory.")
    message("Please run the build from a directory outside of the source directory.")
    message(FATAL_ERROR "In-source builds are forbidden.")
  endif()

  # Check for polluted source directory.
  if(EXISTS "${CMAKE_SOURCE_DIR}/CMakeCache.txt" OR EXISTS "${CMAKE_SOURCE_DIR}/CMakeFiles")
    message("Found results from an in-source build in the source directory.")
    clean_cmake_cache()
    message(FATAL_ERROR "Cleaned up source directory, please re-run CMake.")
  endif()
endfunction()

# Attempts to delete the "CMake" cache files.
function(clean_cmake_cache)
  file(REMOVE_RECURSE "${CMAKE_SOURCE_DIR}/CMakeCache.txt"
                      "${CMAKE_SOURCE_DIR}/CMakeFiles")
endfunction()

# Adds a target with the name "distclean", which clears the CMake cache.
function(add_distclean_target)
  add_custom_target("distclean"
                    COMMAND ${CMAKE_COMMAND} -P "${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/distclean_target.cmake"
                    #WORKING_DIRECTORY ${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}
                    COMMENT "Clears the CMake cache by deleting files used for caching by CMake.")
endfunction()
