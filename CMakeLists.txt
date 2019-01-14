# The target of the library fortran_tester is exported
# as fortran_tester::fortran_tester to a package config file
# for fortran_tester
#
# usage:
#     find_package(fortran_tester)
#     ...
#     target_link_libraries(<target> fortran_tester)
#
# the config file is generatet in the build and install directories

cmake_minimum_required(VERSION 3.10...3.13)

project(fortran_tester LANGUAGES Fortran)

set(CMAKE_Fortran_MODULE_DIRECTORY "modules")

set(TARGETS_EXPORT_NAME "${PROJECT_NAME}-targets")
set(NAMESPACE "${PROJECT_NAME}::")

add_subdirectory(src)

# testing
option(BUILD_TESTING "Build the testing tree." OFF)
if(BUILD_TESTING)
    include(CTest)
    add_subdirectory(test)
endif()


# generate package config files
include(GNUInstallDirs)
set(project_config "${PROJECT_NAME}-config.cmake")
set(cmake_files_dir "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles")
set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(config_build_dir "${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME}")

# export targets for install
install(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    DESTINATION
        ${config_install_dir}
    COMPONENT Development
)

# export targets into build
export(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    FILE
        "${config_build_dir}/${TARGETS_EXPORT_NAME}.cmake"
)

#create package config
include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/PackageConfig.cmake.in ${cmake_files_dir}/${project_config}
    INSTALL_DESTINATION ${config_install_dir}
)
install(FILES ${cmake_files_dir}/${project_config}
    DESTINATION ${config_install_dir}
)

configure_package_config_file(cmake/PackageConfig.cmake.in ${config_build_dir}/${project_config}
    INSTALL_DESTINATION ${config_build_dir}
    INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}
)
