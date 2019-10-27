# The target of the library fortran_tester is exported
# as fortran_tester::fortran_tester to a package config file
# for this library
#
# usage:
#     find_package(fortran_tester)/add_subdirectory(...)
#     ...
#     target_link_libraries(<target> fortran_tester::fortran_tester)
#
# the config file is generatet in the build and install directories
#
# to build the documentation build the target doc (doxygen is needed)
#
# to diable the tests disable the BUILT_TESTING option
# to enable the thests when building as a subproject enable
# the options fortran_tester_BUILD_TESTING and BUILT_TESTING
# afterwards the tests can be run with ctest

cmake_minimum_required(VERSION 3.1...3.15)

project(fortran_tester LANGUAGES Fortran)

SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_Fortran_MODULE_DIRECTORY "${PROJECT_BINARY_DIR}/modules")

# set export variables needed in subdirectories
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}-targets")
set(NAMESPACE "${PROJECT_NAME}::")

add_subdirectory(src)

# testing and documentation
if(${PROJECT_SOURCE_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
    set(main_project TRUE)
    option(BUILD_TESTING "Build the testing tree." ON)
else()
    set(main_project FALSE)

    # if this is not the main project but BUILD_TESTIG is set to TRUE
    # the tests for this project can be enabled by also setting
    # BUILD_TESTING_${PROJECT_NAME} to TRUE
    include(CMakeDependentOption)
    cmake_dependent_option(BUILD_TESTING_${PROJECT_NAME}
        "Build the testing tree for project ${PROJECT_NAME}." OFF
        "BUILD_TESTING;NOT main_project" OFF
    )
endif()

# testing
if((main_project OR BUILD_TESTING_${PROJECT_NAME}) AND BUILD_TESTING)
    enable_testing()
    add_subdirectory(test)
endif()

# documentation
if(main_project)
    set(doc doc)
else()
    set(doc ${NAMESPACE}doc)
endif()

find_package(Doxygen QUIET)
if(Doxygen_FOUND)
    add_custom_target(${doc}
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/doc"
        COMMAND ${DOXYGEN_EXECUTABLE} "${CMAKE_CURRENT_SOURCE_DIR}/doc/doxygen_conf"
        DEPENDS ${DOXYGEN_EXECUTABLE} "${CMAKE_CURRENT_SOURCE_DIR}/doc/doxygen_conf"
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )
endif()

# generate package config files
include(GNUInstallDirs)
set(project_config "${PROJECT_NAME}-config.cmake")
set(project_config_version "${PROJECT_NAME}-config-version.cmake")
set(cmake_files_dir "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles")
set(default_config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(config_build_dir "${CMAKE_CURRENT_BINARY_DIR}/${default_config_install_dir}")
set(${PROJECT_NAME}_INSTALL_CMAKEDIR ${default_config_install_dir} CACHE PATH "Path into which the cmake files for project ${PROJECT_NAME} will be installed.")

# export targets for install
install(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    DESTINATION
        ${${PROJECT_NAME}_INSTALL_CMAKEDIR}
    COMPONENT
        ${PROJECT_NAME}_Development
)

# export targets into build
export(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    FILE
        "${config_build_dir}/${TARGETS_EXPORT_NAME}.cmake"
)

# create package config
# Variables needed by PackageConfig.cmake.in: PROJECT_NAME, TARGETS_EXPORT_NAME

include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/PackageConfig.cmake.in "${cmake_files_dir}/${project_config}"
    INSTALL_DESTINATION ${${PROJECT_NAME}_INSTALL_CMAKEDIR}
)

configure_package_config_file(cmake/PackageConfig.cmake.in "${config_build_dir}/${project_config}"
    INSTALL_DESTINATION ${config_build_dir}
    INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}
)

# write_basic_package_version_file(
#     "${config_build_dir}/${project_config_version}"
#     VERSION ${PROJECT_VERSION}
#     COMPATIBILITY SameMajorVersion
# )

install(
    FILES
        "${cmake_files_dir}/${project_config}"
        # "${config_build_dir}/${project_config_version}"
    DESTINATION
        ${${PROJECT_NAME}_INSTALL_CMAKEDIR}
    COMPONENT
        ${PROJECT_NAME}_Development
)