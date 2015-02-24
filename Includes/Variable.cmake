#.rst:
# Variable
# --------
#
# Functions related to variables for the build system "CMake".
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

if(florianwolters_variable_included)
  return()
endif()

set(florianwolters_variable_included 1)

function(append input result)
  set(${input} ${${input}}${${result}} PARENT_SCOPE)
endfunction()
