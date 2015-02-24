#.rst:
# Doxygen
# -------
#
# Allows to run the documentation generator "Doxygen" as a custom target with
# the build system "CMake".
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

if(florianwolters_doxygen_included)
  return()
endif()

set(florianwolters_doxygen_included 1)

function(enable_doxygen)
  set(DOXYGEN_BASENAME "doxygen")
  set(PROJECT_DOXYGEN_TARGET_DIR
      "${PROJECT_DOCUMENT_TARGET_DIR}/${DOXYGEN_BASENAME}")
  add_doxygen_target("doxygen"
                     ${PROJECT_CMAKE_TEMPLATES_SOURCE_DIR}
                     ${PROJECT_BUILD_TARGET_DIR}
                     ${PROJECT_DOXYGEN_TARGET_DIR}
                     "${PROJECT_BUILD_TARGET_DIR}/${DOXYGEN_BASENAME}.log"
                     ${PROJECT_README_RESOURCE_FILE})

  # Install the "Doxygen" output directory containing all files.
  install(DIRECTORY ${PROJECT_DOXYGEN_TARGET_DIR}
          DESTINATION ${PROJECT_DOCUMENT_INSTALL_DIR})
endfunction()

function(add_doxygen_target
         target_name
         doxyfile_input_dir
         doxyfile_output_dir
         output_dir
         warning_output_file
         markdown_mainpage_file)
  set(DOXYFILE_BASENAME "Doxyfile")
  set(DOXYFILE_INPUT "${doxyfile_input_dir}/${DOXYFILE_BASENAME}.in")
  set(DOXYFILE_OUTPUT "${doxyfile_output_dir}/${DOXYFILE_BASENAME}")

  set(DOXYGEN_OUTPUT_DIR ${output_dir})
  set(DOXYGEN_HTML_OUTPUT_DIR "${DOXYGEN_OUTPUT_DIR}/html")
  set(DOXYGEN_HTML_INDEX_FILE "${DOXYGEN_HTML_OUTPUT_DIR}/index.html")
  set(DOXYGEN_WARNING_OUTPUT_FILE ${warning_output_file})
  set(DOXYGEN_MARKDOWN_MAINPAGE_FILE ${markdown_mainpage_file})

  configure_file(${DOXYFILE_INPUT} ${DOXYFILE_OUTPUT} @ONLY)
  file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIR})
  add_custom_command(OUTPUT ${DOXYGEN_HTML_INDEX_FILE}
                     COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYFILE_OUTPUT}
                     # The following should be ${DOXYFILE_OUTPUT} only but it will break the
                     # dependency. The optimal solution would be creating custom_command for
                     # ${DOXYFILE_OUTPUT} generation but I still have to figure out how...
                     MAIN_DEPENDENCY ${DOXYFILE_OUTPUT} ${DOXYFILE_INPUT}
                     COMMENT "Generating software reference documentation with the documentation generator \"Doxygen\""
                     VERBATIM)
  add_custom_target(${target_name} ALL DEPENDS ${DOXYGEN_HTML_INDEX_FILE})
endfunction()
