# Bootstrap.cmake
#
# Bootstrapping of the project "florianwolters/cmake-utils" for the build system
# "CMake".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2014 - 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_include_included)
  return()
endif()

set(florianwolters_include_included TRUE)
# End of include guard.

# ------------------------------------------------------------------------------
# Include official "CMake" modules.
# ------------------------------------------------------------------------------
include(ExternalProject)

# ------------------------------------------------------------------------------
# Include project specific "CMake" modules.
# ------------------------------------------------------------------------------
include("${CMAKE_CURRENT_LIST_DIR}/SetCommonVariables.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/CMake.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Cppcheck.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Doxygen.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Flawfinder.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/GoogleCpplint.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/GoogleTest.cmake")

assert_out_of_source_build()
