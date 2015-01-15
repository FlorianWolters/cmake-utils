# SetCommonVariables.cmake
#
# Sets common variables for the build system "CMake".
#
# Author: Florian Wolters <wolters.fl@gmail.com>
#
# Copyright Florian Wolters (http://blog.florianwolters.de) 2014 - 2015.
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# Start of include guard.
if(florianwolters_set_common_variables_included)
  return()
endif()

set(florianwolters_set_common_variables_included TRUE)
# End of include guard.

# ------------------------------------------------------------------------------
# Set variables related to Coding style.
# ------------------------------------------------------------------------------

set(PROJECT_MAXIMUM_LINE_LENGTH 80 CACHE INTERNAL "PROJECT_MAXIMUM_LINE_LENGTH")

# ------------------------------------------------------------------------------
# Set variables related to file extensions.
# ------------------------------------------------------------------------------

set(PROJECT_DECLARATION_FILE_SUFFIX ".h"
    CACHE INTERNAL "PROJECT_DECLARATION_FILE_SUFFIX")
set(PROJECT_DEFINITION_FILE_SUFFIX ".cc"
    CACHE INTERNAL "PROJECT_DEFINITION_FILE_SUFFIX")
set(PROJECT_SOURCE_FILE_SUFFIX_LIST ${PROJECT_DECLARATION_FILE_SUFFIX}
                                    ${PROJECT_DEFINITION_FILE_SUFFIX}
    CACHE INTERNAL "PROJECT_SOURCE_FILE_SUFFIX_LIST")

# ------------------------------------------------------------------------------
# Set variables related to directory base file names.
# ------------------------------------------------------------------------------

set(PROJECT_ARCHIVE_DIR_NAME "lib" CACHE INTERNAL "PROJECT_ARCHIVE_DIR_NAME")
set(PROJECT_BUILD_DIR_NAME "build" CACHE INTERNAL "PROJECT_BUILD_DIR_NAME")
set(PROJECT_CMAKE_DIR_NAME "cmake" CACHE INTERNAL "PROJECT_CMAKE_DIR_NAME")
set(PROJECT_CONFIG_DIR_NAME "config" CACHE INTERNAL "PROJECT_CONFIG_DIR_NAME")
set(PROJECT_DOCUMENT_DIR_NAME "doc" CACHE INTERNAL "PROJECT_DOCUMENT_DIR_NAME")
set(PROJECT_DECLARATION_DIR_NAME "include" CACHE INTERNAL "PROJECT_DECLARATION_DIR_NAME")
set(PROJECT_DEFINITION_DIR_NAME "src" CACHE INTERNAL "PROJECT_DEFINITION_DIR_NAME")
set(PROJECT_DEPENDENCY_DIR_NAME "deps" CACHE INTERNAL "PROJECT_DEPENDENCY_DIR_NAME")
set(PROJECT_EXAMPLE_DIR_NAME "example" CACHE INTERNAL "PROJECT_EXAMPLE_DIR_NAME")
set(PROJECT_LIBRARY_DIR_NAME "lib" CACHE INTERNAL "PROJECT_LIBRARY_DIR_NAME")
set(PROJECT_RUNTIME_DIR_NAME "bin" CACHE INTERNAL "PROJECT_RUNTIME_DIR_NAME")
set(PROJECT_PACKAGE_DIR_NAME "dist" CACHE INTERNAL "PROJECT_PACKAGE_DIR_NAME")
set(PROJECT_TEST_DIR_NAME "test" CACHE INTERNAL "PROJECT_TEST_DIR_NAME")

# ------------------------------------------------------------------------------
# Set variables related to source (input) directories.
# ------------------------------------------------------------------------------

set(PROJECT_CMAKE_SOURCE_DIR "${PROJECT_SOURCE_DIR}/${PROJECT_CMAKE_DIR_NAME}" CACHE INTERNAL "PROJECT_CMAKE_SOURCE_DIR")
set(PROJECT_CMAKE_INCLUDES_SOURCE_DIR "${PROJECT_CMAKE_SOURCE_DIR}/Includes" CACHE INTERNAL "PROJECT_CMAKE_INCLUDES_SOURCE_DIR")
set(PROJECT_CMAKE_MODULES_SOURCE_DIR "${PROJECT_CMAKE_SOURCE_DIR}/Modules" CACHE INTERNAL "PROJECT_CMAKE_MODULES_SOURCE_DIR")
set(PROJECT_CMAKE_TEMPLATES_SOURCE_DIR "${PROJECT_CMAKE_SOURCE_DIR}/Templates" CACHE INTERNAL "PROJECT_CMAKE_TEMPLATES_SOURCE_DIR")
set(PROJECT_CONFIG_SOURCE_DIR "${PROJECT_SOURCE_DIR}/${PROJECT_CONFIG_DIR_NAME}" CACHE INTERNAL "PROJECT_CONFIG_SOURCE_DIR")
set(PROJECT_DECLARATION_SOURCE_DIR "${PROJECT_SOURCE_DIR}/${PROJECT_DECLARATION_DIR_NAME}" CACHE INTERNAL "PROJECT_DECLARATION_SOURCE_DIR")
set(PROJECT_DEFINITION_SOURCE_DIR "${PROJECT_SOURCE_DIR}/${PROJECT_DEFINITION_DIR_NAME}" CACHE INTERNAL "PROJECT_DEFINITION_SOURCE_DIR")
set(PROJECT_DOCUMENT_SOURCE_DIR "${PROJECT_SOURCE_DIR}/${PROJECT_DOCUMENT_DIR_NAME}" CACHE INTERNAL "PROJECT_DOCUMENT_SOURCE_DIR")
set(PROJECT_EXAMPLE_SOURCE_DIR "${PROJECT_DOCUMENT_SOURCE_DIR}/${PROJECT_EXAMPLE_DIR_NAME}" CACHE INTERNAL "PROJECT_EXAMPLE_SOURCE_DIR")
set(PROJECT_TEST_SOURCE_DIR "${PROJECT_SOURCE_DIR}/${PROJECT_TEST_DIR_NAME}" CACHE INTERNAL "PROJECT_TEST_SOURCE_DIR")

# ------------------------------------------------------------------------------
# Set variables related to resource files.
# ------------------------------------------------------------------------------

set(PROJECT_CHANGELOG_RESOURCE_FILE "${PROJECT_SOURCE_DIR}/CHANGELOG")
set(PROJECT_LICENSE_RESOURCE_FILE "${PROJECT_SOURCE_DIR}/LICENSE")
set(PROJECT_README_RESOURCE_FILE "${PROJECT_SOURCE_DIR}/README.md")

# ------------------------------------------------------------------------------
# Find source files.
# ------------------------------------------------------------------------------

file(GLOB_RECURSE
     PROJECT_DECLARATION_SOURCE_FILES_LIST
     "${PROJECT_DECLARATION_SOURCE_DIR}/*${PROJECT_DECLARATION_FILE_SUFFIX}")
file(GLOB_RECURSE
     PROJECT_DEFINITION_SOURCE_FILES_LIST
     "${PROJECT_DEFINITION_SOURCE_DIR}/*${PROJECT_DEFINITION_FILE_SUFFIX}")
set(PROJECT_SOURCE_FILES_LIST ${PROJECT_DECLARATION_SOURCE_FILES_LIST} ${PROJECT_DEFINITION_SOURCE_FILES_LIST})

# ------------------------------------------------------------------------------
# Set variables related to target (output) directories.
# ------------------------------------------------------------------------------

set(PROJECT_BUILD_TARGET_DIR ${PROJECT_BINARY_DIR} CACHE INTERNAL "PROJECT_BUILD_TARGET_DIR")
set(PROJECT_ARCHIVE_TARGET_DIR "${PROJECT_BUILD_TARGET_DIR}/${PROJECT_ARCHIVE_DIR_NAME}" CACHE INTERNAL "PROJECT_ARCHIVE_TARGET_DIR")
set(PROJECT_DEPENDENCY_TARGET_DIR "${PROJECT_BUILD_TARGET_DIR}/${PROJECT_DEPENDENCY_DIR_NAME}" CACHE INTERNAL "PROJECT_DEPENDENCY_TARGET_DIR")
set(PROJECT_DOCUMENT_TARGET_DIR "${PROJECT_BUILD_TARGET_DIR}/${PROJECT_DOCUMENT_DIR_NAME}" CACHE INTERNAL "PROJECT_DOCUMENT_TARGET_DIR")
set(PROJECT_LIBRARY_TARGET_DIR "${PROJECT_BUILD_TARGET_DIR}/${PROJECT_LIBRARY_DIR_NAME}" CACHE INTERNAL "PROJECT_LIBRARY_TARGET_DIR")
set(PROJECT_PACKAGE_TARGET_DIR "${PROJECT_BUILD_TARGET_DIR}/${PROJECT_PACKAGE_DIR_NAME}" CACHE INTERNAL "PROJECT_PACKAGE_TARGET_DIR")
set(PROJECT_RUNTIME_TARGET_DIR "${PROJECT_BUILD_TARGET_DIR}/${PROJECT_RUNTIME_DIR_NAME}" CACHE INTERNAL "PROJECT_RUNTIME_TARGET_DIR")
set(PROJECT_TEST_TARGET_DIR "${PROJECT_BUILD_TARGET_DIR}/${PROJECT_RUNTIME_DIR_NAME}/${PROJECT_TEST_DIR_NAME}" CACHE INTERNAL "PROJECT_TEST_TARGET_DIR")

# ------------------------------------------------------------------------------
# Set variables related to installation directories.
# ------------------------------------------------------------------------------

set(PROJECT_BASE_INSTALL_DIR "/${PROJECT_PACKAGE_INSTALL_BASE_DIR}" CACHE INTERNAL "PROJECT_BASE_INSTALL_DIR")
set(PROJECT_ROOT_INSTALL_DIR "${PROJECT_BASE_INSTALL_DIR}/${PROJECT_NAME}" CACHE INTERNAL "PROJECT_ROOT_INSTALL_DIR")
set(PROJECT_INSTALL_SYMLINK "${PROJECT_ROOT_INSTALL_DIR}/default")

set(PROJECT_INSTALL_DIR
    "${PROJECT_PACKAGE_INSTALL_BASE_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-${PROJECT_VERSION}"
    CACHE PATH "Installation directory for the version ${PROJECT_VERSION} of the project ${PROJECT_NAME}")
set(PROJECT_RUNTIME_INSTALL_DIR
    "${PROJECT_INSTALL_DIR}/${PROJECT_RUNTIME_DIR_BASENAME}"
    CACHE PATH "Installation directory for executable files of the project ${PROJECT_NAME}")
set(PROJECT_DOCUMENT_INSTALL_DIR
    "${PROJECT_INSTALL_DIR}/${PROJECT_DOCUMENT_DIR_BASENAME}"
    CACHE PATH "Installation directory for documentation files of the project ${PROJECT_NAME}")
set(PROJECT_INSTALL_INCLUDE_DIR
    ${PROJECT_INSTALL_DIR}
    CACHE PATH "Installation directory for header files of the project ${PROJECT_NAME}")
set(PROJECT_INSTALL_TEST_DIR
    ${PROJECT_INSTALL_DIR}
    CACHE PATH "Installation directory for test files of the project ${PROJECT_NAME}")

set(LIB_SUFFIX "64")
get_property(LIB64 GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS)

if(LIB64)
  set(LIB_SUFFIX "64")
endif()

set(PROJECT_PACKAGE_INSTALL_LIB_DIR
    "${PROJECT_INSTALL_DIR}/${PROJECT_LIBRARY_DIR_BASENAME}${LIB_SUFFIX}"
    CACHE PATH "Installation directory for library files of the project ${PROJECT_NAME}")

# ------------------------------------------------------------------------------
# Set variables related to "CMake".
# ------------------------------------------------------------------------------

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_ARCHIVE_TARGET_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_LIBRARY_TARGET_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_RUNTIME_TARGET_DIR})
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_CMAKE_MODULES_SOURCE_DIR})
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_RUNTIME_TARGET_DIR})
set(CMAKE_COLOR_MAKEFILE TRUE)

if(NOT CMAKE_THREAD_PREFER_PTHREAD)
  set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
endif()

if(NOT CMAKE_BUILD_TYPE)
  # Specified the default build type.
  set(CMAKE_BUILD_TYPE "Debug"
      CACHE STRING
      "Specifies the build type (configuration). Possible values are empty, Debug, Release, RelWithDebInfo and MinSizeRelease."
      FORCE)
endif()
