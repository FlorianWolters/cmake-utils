#.rst:
# Assert
# ------
#
# Assertion functions for the build system "CMake".
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

if(florianwolters_assert_included)
  return()
endif()

set(florianwolters_assert_included 1)

function(assert variable)
  if(NOT ${variable})
    message(FATAL_ERROR
            "\nAssertion failed: ${variable} (value is '${${variable}}')\n")
  endif()
endfunction()

function(assert_unset variable)
  if(${variable})
    message(FATAL_ERROR
            "\nAssertion failed: '${variable}' is set but should not be (value is '${${variable}}')\n")
  endif()
endfunction()

function(assert_equal expected actual)
  if(NOT "${actual}" STREQUAL "${expected}")
    message(FATAL_ERROR
            "\nAssertion failed: Expected value '${expected}' is not equal to actual value '${actual}'\n")
  endif()
endfunction()

function(assert_file_exists file_path error_message)
  if(NOT file_path)
    message(FATAL_ERROR
            "\nAssertion failed: check for file existence, but filename (${file_path}) unset. Message: ${error_message}\n")
  endif()

  if(NOT EXISTS ${file_path})
    message(FATAL_ERROR
            "\nAssertion failed: file '${file_path}' does not exist.  Message: ${error_message}\n")
  endif()
endfunction()
