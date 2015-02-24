# test/TestList/CMakeLists.cmake
#
# Tests the "CMake" module `List.cmake` with the build system "CMake".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)

include("../../Includes/Assert.cmake")
include("../../Includes/List.cmake")

function(test_list_remove_duplicates_and_sort)
  set(INPUT a z b c a c)
  set(EXPECTED "a;b;c;z")

  list_remove_duplicates_and_sort(INPUT ACTUAL)
  assert_equal("${EXPECTED}" "${ACTUAL}")
endfunction()

test_list_remove_duplicates_and_sort()
