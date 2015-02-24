# test/TestGoogleCpplint/CMakeLists.cmake
#
# Tests the "CMake" module `GoogleCpplint.cmake` with the build system "CMake".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

cmake_minimum_required(VERSION 2.6.2 FATAL_ERROR)

include("../../Includes/GoogleCpplint.cmake")

# ------------------------------------------------------------------------------
# Test of function `get_google_cpplint`.
# ------------------------------------------------------------------------------
get_google_cpplint()
enable_google_cpplint()

message("PROJECT_SOURCE_FILES_LIST = ${PROJECT_SOURCE_FILES_LIST}")
message("GOOGLE_CPPLINT_SCRIPT = ${GOOGLE_CPPLINT_SCRIPT}")
message("GOOGLE_CPPLINT_FOUND = ${GOOGLE_CPPLINT_FOUND}")
