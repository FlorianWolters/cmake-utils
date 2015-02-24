#.rst:
# GoogleCpplint
# -------------
#
# Allows to add a custom target for the style checker "Google cpplint" to the
# build system "CMake".
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

if(florianwolters_google_cpplint_included)
  return()
endif()

set(florianwolters_google_cpplint_included 1)

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)
cmake_policy(SET CMP0011 NEW)
include(ExternalProject)
include(FindSubversion)

function(get_google_cpplint)
  find_package("Subversion" REQUIRED)
  set(REVISION ${ARGV0})
  set(DOWNLOAD_TIMEOUT ${ARGV1})

  if(NOT REVISION)
    set(REVISION 141)
  endif()

  if(NOT DOWNLOAD_TIMEOUT)
    set(DOWNLOAD_TIMEOUT 15)
  endif()

  set(TARGET_NAME "get_cpplint")
  set(REPOSITORY_URL "https://google-styleguide.googlecode.com/svn/trunk/cpplint")
  ExternalProject_Add(${TARGET_NAME}
                      # Download step.
                      SVN_REPOSITORY ${REPOSITORY_URL}
                      TIMEOUT ${DOWNLOAD_TIMEOUT}
                      SVN_REVISION "-r" ${REVISION}
                      CONFIGURE_COMMAND ""
                      BUILD_COMMAND ""
                      INSTALL_COMMAND ""
                      # Output logging.
                      LOG_DOWNLOAD 1
                      LOG_CONFIGURE 1
                      LOG_INSTALL 1)
  ExternalProject_Get_Property(${TARGET_NAME} source_dir)
  set(GOOGLE_CPPLINT_SCRIPT "${source_dir}/cpplint.py" CACHE INTERNAL "" FORCE)
  set(GOOGLE_CPPLINT_FOUND TRUE CACHE INTERNAL "" FORCE)
endfunction()

# Enables the style checker "Google cpplint" for the current directory and its
# subdirectories.
#
# Used variables:
#
# GOOGLE_CPPLINT_SCRIPT                  - The absolute file path to the "Google
#    cpplint" script.
# PROJECT_SOURCE_FILES_LIST       - The files to be linted.
# PROJECT_MAXIMUM_LINE_LENGTH     - [optional] The allowed line length for the
#    project. (default = 80)
# PROJECT_SOURCE_FILE_SUFFIX_LIST - [optional] The allowed file suffixes for the
#    project. (default = ".cc .cpp .cu .cuh .h")
#
# Example:
#
#     enable_google_cpplint()
function(enable_google_cpplint)
  set(TARGET_NAME "cpplint")

  if(NOT PYTHONINTERP_FOUND)
    find_package("PythonInterp" 2 QUIET)

    if(NOT PYTHONINTERP_FOUND)
      message(STATUS "Python interpretet not found; '${TARGET_NAME}' target will not be available")
      return()
    endif()
  endif()

  if(NOT GOOGLE_CPPLINT_FOUND)
    find_package("GoogleCpplint" QUIET)

    if(NOT GOOGLE_CPPLINT_FOUND)
      message(WARNING "Google cpplint not found; \"${TARGET_NAME}\" target will not be available")
      return()
    endif()
  endif()

  if(NOT PROJECT_SOURCE_FILES_LIST)
    message(WARNING "No source files found; \"${TARGET_NAME}\" target will not be available")
    return()
  endif()

  if(MSVC)
    set(CPPLINT_OUTPUT "vs7")
  else()
    set(CPPLINT_OUTPUT "emacs")
  endif()

  if(PROJECT_DECLARATION_DIR_NAME)
    set(ROOT ${PROJECT_DECLARATION_DIR_NAME})
  else()
    set(ROOT "include")
  endif()

  if(PROJECT_MAXIMUM_LINE_LENGTH)
    set(LINELENGTH ${PROJECT_MAXIMUM_LINE_LENGTH})
  else()
    set(LINELENGTH 80)
  endif()

  if(PROJECT_FILE_EXTENSIONS)
    string(REPLACE "." " " EXTENSIONS ${PROJECT_SOURCE_FILE_SUFFIX_LIST})
    string(STRIP ${EXTENSIONS} EXTENSIONS)
    string(REPLACE " " "," EXTENSIONS ${EXTENSIONS})
  else()
    set(EXTENSIONS "cc,cpp,cu,cuh,h")
  endif()

  list_remove_duplicates_and_sort(PROJECT_SOURCE_FILES_LIST
                                  PROJECT_SOURCE_FILES_LIST)

  add_custom_target(${TARGET_NAME}
                    COMMAND ${PYTHON_EXECUTABLE}
                            ${GOOGLE_CPPLINT_SCRIPT}
                            "--verbose=5"
                            "--output=${CPPLINT_OUTPUT}"
                            "--counting=toplevel"
                            "--root=${ROOT}"
                            "--linelength=${LINELENGTH}"
                            "--extensions=${EXTENSIONS}"
                            ${TMP_PROJECT_SOURCE_FILES_LIST}
                    DEPENDS ${GOOGLE_CPPLINT_SCRIPT}
                            ${PROJECT_SOURCE_FILES_LIST}
                    COMMENT "Checking coding style with \"Google cpplint\"."
                    VERBATIM)
endfunction()
