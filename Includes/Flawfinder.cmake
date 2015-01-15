# Flawfinder.cmake
#
# Allows to run the static security analyzer "Flawchecker" as a custom target
# with the build system "CMake".
#
# This file requires the following "CMake" modules:
#
#     FindFlawfinder
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_flawfinder_included)
  return()
endif()

set(florianwolters_flawfinder_included TRUE)
# End of include guard.

function(get_flawfinder)
  set(FLAWFINDER_VERSION ${ARGV0})
  set(DOWNLOAD_TIMEOUT ${ARGV1})

  if(NOT FLAWFINDER_VERSION)
    set(FLAWFINDER_VERSION "1.31")
  endif()

  if(NOT DOWNLOAD_TIMEOUT)
    set(DOWNLOAD_TIMEOUT 15)
  endif()

  set(FLAWFINDER_EXTERNAL_PROJECT_NAME "get_flawfinder")
  set(FLAWFINDER_DOWNLOAD_URL "http://dwheeler.com/flawfinder/flawfinder-${FLAWFINDER_VERSION}.tar.gz")
  ExternalProject_Add(${FLAWFINDER_EXTERNAL_PROJECT_NAME}
                      # Download step.
                      URL ${FLAWFINDER_DOWNLOAD_URL}
                      TIMEOUT ${DOWNLOAD_TIMEOUT}
                      CONFIGURE_COMMAND ""
                      BUILD_COMMAND ""
                      INSTALL_COMMAND ""
                      # Output logging.
                      LOG_DOWNLOAD 1
                      LOG_CONFIGURE 1
                      LOG_INSTALL 1)
  ExternalProject_Get_Property(${FLAWFINDER_EXTERNAL_PROJECT_NAME} source_dir)
  set(FLAWFINDER_COMMAND "${source_dir}/flawfinder" CACHE INTERNAL "" FORCE)
  set(FLAWFINDER_FOUND TRUE CACHE INTERNAL "" FORCE)
endfunction()

# Enables the static code analyzer "Flawfinder" for the current directory and
# its subdirectories.
#
# Used variables:
#
# FLAWFINDER_COMMAND        - The command to run "Flawfinder".
# PROJECT_SOURCE_FILES_LIST - The files to be linted.
#
# Example:
#
#     enable_flawfinder()
function(enable_flawfinder)
  add_flawfinder_target("flawfinder"
                        ${PROJECT_SOURCE_FILES_LIST})
endfunction()

function(add_flawfinder_target
         target_name
         source_files_list)
  if(NOT FLAWFINDER_FOUND)
    find_package(Flawfinder QUIET)

    if(NOT FLAWFINDER_FOUND)
      message(WARNING "Flawfinder not found; \"${target_name}\" target will not be available")
      return()
    endif()
  endif()

  # TODO(wolters): Move to utility function.
  set(SORTED_SOURCE_FILES_LIST ${source_files_list})
  list(SORT SORTED_SOURCE_FILES_LIST)
  list(REMOVE_DUPLICATES SORTED_SOURCE_FILES_LIST)

  add_custom_target(${target_name}
                    COMMAND ${PYTHON_EXECUTABLE}
                            ${FLAWFINDER_COMMAND}
                            "--quiet"
                            ${SORTED_SOURCE_FILES_LIST}
                    DEPENDS ${PYTHON_EXECUTABLE}
                            ${FLAWFINDER_COMMAND}
                            ${source_files_list}
                    COMMENT "Finding source code vulnerabilities with \"Flawfinder\"."
                    VERBATIM)
endfunction()
