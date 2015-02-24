#.rst:
# Bootstrap
# ---------
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

# ------------------------------------------------------------------------------
# Include guard.
# ------------------------------------------------------------------------------

if(florianwolters_bootstrap_included)
  return()
endif()

set(florianwolters_bootstrap_included 1)

# ------------------------------------------------------------------------------
# Initialize project.
# ------------------------------------------------------------------------------

if(NOT PROJECT_VERSION_MAJOR)
  set(PROJECT_VERSION_MAJOR 0)
endif()

if(NOT PROJECT_VERSION_MINOR)
  set(PROJECT_VERSION_MINOR 1)
endif()

if(NOT PROJECT_VERSION_PATCH)
  set(PROJECT_VERSION_PATCH 0)
endif()

set(PROJECT_VERSION
    "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES CXX C)

# ------------------------------------------------------------------------------
# Load and run "CMake" code from a file or module.
# ------------------------------------------------------------------------------

include(ExternalProject)

# ------------------------------------------------------------------------------
# Include project specific "CMake" modules.
# ------------------------------------------------------------------------------

include("${CMAKE_CURRENT_LIST_DIR}/SetCommonVariables.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Assert.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/CMake.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Debug.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/List.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Variable.cmake")

include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Cppcheck.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Doxygen.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/Flawfinder.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/GoogleCpplint.cmake")
include("${PROJECT_CMAKE_INCLUDES_SOURCE_DIR}/GoogleTest.cmake")

assert_out_of_source_build()
add_check_target()

# ------------------------------------------------------------------------------
# Provide options that the user can optionally select.
# ------------------------------------------------------------------------------

option(BUILD_TESTS "Build the test executables of the project." ON)
option(BUILD_EXAMPLES "Build the example executables of the project." ON)

# ------------------------------------------------------------------------------
# Build tests.
# ------------------------------------------------------------------------------

if(BUILD_TESTS)
  set(PROJECT_DEPENDENCY_TEST_LIBRARIES ${PROJECT_DEPENDENCY_LIBRARIES})

  find_package(Threads REQUIRED)
  list(APPEND PROJECT_DEPENDENCY_TEST_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})

  # Find "Google Test (GTest)".
  find_package(GTest ${PROJECT_DEPENDENCY_GTEST_VERSION})
  list(APPEND PROJECT_DEPENDENCY_TEST_LIBRARIES ${GTEST_BOTH_LIBRARIES})

  if(NOT ${GTEST_FOUND})
    get_googletest(${PROJECT_DEPENDENCY_GTEST_VERSION})
  endif()

  # "Google Test" is available now.
  enable_testing()

  include_directories(SYSTEM ${GTEST_INCLUDE_DIRS})

  foreach(TEST_SOURCE_FILE ${PROJECT_TEST_DEFINITION_SOURCE_FILES_LIST})
    get_filename_component(TEST_NAME ${TEST_SOURCE_FILE} NAME_WE)
    add_executable(${TEST_NAME} ${TEST_SOURCE_FILE})
    target_include_directories(${TEST_NAME} PRIVATE
                               ${PROJECT_DECLARATION_SOURCE_DIR}
                               ${PROJECT_TEST_SOURCE_DIR})
    target_link_libraries(${TEST_NAME} ${PROJECT_DEPENDENCY_TEST_LIBRARIES})
    set_target_properties(${TEST_NAME}
                          PROPERTIES CXX_STANDARD 11
                                     CXX_STANDARD_REQUIRED ON)

    set(REQUIRED_COMPILE_FEATURES
        cxx_defaulted_functions
        cxx_deleted_functions)

    if(!WIN32)
        target_compile_features(${TEST_NAME}
                                PRIVATE ${REQUIRED_COMPILE_FEATURES})
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    endif()

    add_test(NAME ${TEST_NAME} COMMAND ${TEST_NAME})
    add_dependencies("check" ${TEST_NAME})
  endforeach()
endif()

# ------------------------------------------------------------------------------
# Build examples.
# ------------------------------------------------------------------------------

if(BUILD_EXAMPLES)
  # TODO(wolters): Eliminate Copy & Paste with test creation.
  foreach(EXAMPLE_SOURCE_FILE ${PROJECT_EXAMPLE_DEFINITION_SOURCE_FILES_LIST})
    get_filename_component(EXAMPLE_NAME ${EXAMPLE_SOURCE_FILE} NAME_WE)
    add_executable(${EXAMPLE_NAME} ${EXAMPLE_SOURCE_FILE})
    target_include_directories(${EXAMPLE_NAME} PRIVATE
                               ${PROJECT_DECLARATION_SOURCE_DIR})
    target_link_libraries(${EXAMPLE_NAME}
                          ${PROJECT_DEPENDENCY_LIBRARIES})
    set_target_properties(${PROJECT_TARGET_EXAMPLE_EXECUTABLE}
                          PROPERTIES CXX_STANDARD 11
                                     CXX_STANDARD_REQUIRED ON)

    set(REQUIRED_COMPILE_FEATURES
        cxx_defaulted_functions
        cxx_deleted_functions)

    if(!WIN32)
        target_compile_features(${EXAMPLE_NAME}
                                PRIVATE ${REQUIRED_COMPILE_FEATURES})
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    endif()
  endforeach()
endif()
