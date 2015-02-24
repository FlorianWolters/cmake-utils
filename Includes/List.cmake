#.rst:
# List
# ----
#
# Functions related to lists for the build system "CMake".
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

if(florianwolters_list_included)
  return()
endif()

set(florianwolters_list_included 1)

function(list_remove_duplicates_and_sort input result)
  list(REMOVE_DUPLICATES ${input})
  list(SORT ${input})
  set(${result} ${${input}} PARENT_SCOPE)
endfunction()
