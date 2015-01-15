# GoogleCpplint.cmake
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

if(florianwolters_google_cpplint_included)
  return()
endif()

set(florianwolters_google_cpplint_included TRUE)

# Enables the style checker "Google cpplint" for the current directory and its
# subdirectories.
#
# Used variables:
#
# CPPLINT_SCRIPT                  - The absolute file path to the "Google
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
  set(CPPLINT_TARGET_NAME "cpplint")

  if(NOT PYTHONINTERP_FOUND)
    message(STATUS "python not found; '${CPPLINT_TARGET_NAME}' target will not be available")
    return()
  endif()

  if(NOT CPPLINT_FOUND)
    message(STATUS "cpplint.py not found; '${CPPLINT_TARGET_NAME}' target will not be available")
    return()
  endif()

  if(MSVC)
    set(CPPLINT_OUTPUT "vs7")
  else()
    set(CPPLINT_OUTPUT "emacs")
  endif()

  if(PROJECT_DECLARATION_DIR_NAME)
    set(CPPLINT_ROOT ${PROJECT_DECLARATION_DIR_NAME})
  else()
    set(CPPLINT_ROOT "include")
  endif()

  if(PROJECT_MAXIMUM_LINE_LENGTH)
    set(CPPLINT_LINELENGTH ${PROJECT_MAXIMUM_LINE_LENGTH})
  else()
    set(CPPLINT_LINELENGTH 80)
  endif()

  if(PROJECT_FILE_EXTENSIONS)
    string(REPLACE "." " " CPPLINT_EXTENSIONS ${PROJECT_SOURCE_FILE_SUFFIX_LIST})
    string(STRIP ${CPPLINT_EXTENSIONS} CPPLINT_EXTENSIONS)
    string(REPLACE " " "," CPPLINT_EXTENSIONS ${CPPLINT_EXTENSIONS})
  else()
    set(CPPLINT_EXTENSIONS "cc,cpp,cu,cuh,h")
  endif()

  set(TMP_PROJECT_SOURCE_FILES_LIST ${PROJECT_SOURCE_FILES_LIST})
  list(SORT TMP_PROJECT_SOURCE_FILES_LIST)
  list(REMOVE_DUPLICATES TMP_PROJECT_SOURCE_FILES_LIST)

  add_custom_target(${CPPLINT_TARGET_NAME}
                    COMMAND ${PYTHON_EXECUTABLE}
                            ${CPPLINT_SCRIPT}
                            "--verbose=5"
                            "--output=${CPPLINT_OUTPUT}"
                            "--counting=toplevel"
                            "--root=${CPPLINT_ROOT}"
                            "--linelength=${CPPLINT_LINELENGTH}"
                            "--extensions=${CPPLINT_EXTENSIONS}"
                            ${TMP_PROJECT_SOURCE_FILES_LIST}
                    DEPENDS ${CPPLINT_SCRIPT}
                            ${PROJECT_SOURCE_FILES_LIST}
                    COMMENT "Checking coding style with \"Google cpplint\"."
                    VERBATIM)
endfunction()
