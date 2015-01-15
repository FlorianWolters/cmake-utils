# Cppcheck.cmake
#
# Allows to run the static code analyzer "Cppcheck" as a custom target and with
# the build system "CMake".
#
# This file requires the following "CMake" modules:
#
#     FindCppcheck
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_cppcheck_included)
  return()
endif()

set(florianwolters_cppcheck_included TRUE)
# End of include guard.

cmake_minimum_required(VERSION 2.6 FATAL_ERROR)

function(enable_cppcheck)
  add_cppcheck_target("cppcheck"
                      ${PROJECT_SOURCE_FILES_LIST})
endfunction()

function(add_cppcheck_target
         target_name
         source_files_list)
  set(CPPCHECK_TARGET_NAME "cppcheck")

  if(NOT CPPCHECK_FOUND)
    find_package(Cppcheck QUIET)

    if(NOT CPPCHECK_FOUND)
      message(WARNING "Cppcheck not found; \"${CPPCHECK_TARGET_NAME}\" target will not be available")
      return()
    endif()
  endif()

  # TODO(wolters): Move to utility function.
  set(SORTED_SOURCE_FILES_LIST ${source_files_list})
  list(SORT SORTED_SOURCE_FILES_LIST)
  list(REMOVE_DUPLICATES SORTED_SOURCE_FILES_LIST)

  # TODO(wolters): Allow complex configurations.
  add_custom_target(${target_name}
                    COMMAND ${CPPCHECK_COMMAND}
                            "--enable=all"
                            "--language=c++"
                            "--platform=unix32"
                            "--quiet"
                            "--std=c++11"
                            ${SORTED_SOURCE_FILES_LIST}
                    DEPENDS ${CPPCHECK_COMMAND}
                            ${source_files_list}
                    COMMENT "Finding bugs in the source code with \"Cppcheck\"."
                    VERBATIM)
endfunction()
