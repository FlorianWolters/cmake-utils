#.rst:
# distclean_target
# ----------------
#
# Internal helper file required for the function `add_distclean_target`.
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

include("${CMAKE_CURRENT_LIST_DIR}/CMake.cmake")

clean_cmake_cache()
