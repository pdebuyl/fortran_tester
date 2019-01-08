# The target of the library fortran_tester is exported
# as fortran_tester::fortran_tester to a package config file
# for fortran_tester
#
# the config file is generatet in the build and install directories

cmake_minimum_required(VERSION 3.11)

project(fortran_tester Fortran)

#-===============================================================
# Setup the build tree match installation with standard locations
#-===============================================================

# Follow the generic GNU installation hierarchy
# This is a standard CMake module
include(GNUInstallDirs)

# Setup a relative directory structure in the build tree that will match the install tree
# This makes packages relocatable, assuming you use relative paths and mind your RPATH
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_INSTALL_BINDIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_INSTALL_LIBDIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_INSTALL_LIBDIR})
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
# /${CMAKE_Fortran_COMPILER_ID}-${CMAKE_Fortran_COMPILER_VERSION})

# Since we are mirroring the install tree in the build tree don't
# re-write RPATHs during installation, build with the final rpath.
# set(CMAKE_BUILD_WITH_INSTALL_RPATH ON)

set(LIB ${PROJECT_NAME})
add_library(${LIB} src/tester.f90)
add_library(${PROJECT_NAME}::${LIB} ALIAS ${LIB})

target_include_directories(${LIB}
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_Fortran_MODULE_DIRECTORY}>
)

# installation and export of targets
include(GNUInstallDirs)

set(TARGETS_EXPORT_NAME ${PROJECT_NAME}-targets)

install(DIRECTORY "${CMAKE_CURRENT_BUILD_DIR}/${CMAKE_Fortran_MODULE_DIRECTORY}"
        DESTINATION ${CMAKE_Fortran_MODULE_DIRECTORY}
    )

install(TARGETS ${LIB} EXPORT ${TARGETS_EXPORT_NAME}
                       INCLUDES DESTIOATION ${CMAKE_Fortran_MODULE_DIRECTORY}
                       LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
                       ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
                       RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    )

set(namespace "${PROJECT_NAME}::")
set(project_config "${PROJECT_NAME}-config.cmake")
set(cmake_files_dir "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles")
set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(config_build_dir "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/cmake/${PROJECT_NAME}")

# export targets
install(EXPORT "${TARGETS_EXPORT_NAME}"
    NAMESPACE
        "${namespace}"
    DESTINATION
        "${config_install_dir}"
    )

# export targets into build
export(EXPORT "${TARGETS_EXPORT_NAME}"
    NAMESPACE
        "${namespace}"
    FILE
        "${config_build_dir}/${TARGETS_EXPORT_NAME}.cmake"
    )

#create package config
include(CMakePackageConfigHelpers)
configure_package_config_file("cmake/${project_config}.in" "${cmake_files_dir}/${project_config}"
    INSTALL_DESTINATION "${config_install_dir}"
    )
install(FILES "${cmake_files_dir}/${project_config}"
        DESTINATION "${config_install_dir}"
    )

configure_package_config_file("cmake/${project_config}.in" "${config_build_dir}/${project_config}"
    INSTALL_DESTINATION "${config_build_dir}"
    INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
    )

# testing
option(BUILD_TESTING "Build the testing tree." OFF)
include(CTest)
if(${BUILD_TESTING})
    foreach(test_name test_tester_1
                      test_tester_2
                      test_tester_3
                      test_tester_4
                      test_tester_5
                      test_tester_6)
        add_executable(${test_name} test/${test_name}.f90)
        target_link_libraries(${test_name} fortran_tester)
        add_test(NAME ${test_name} COMMAND ${test_name})
    endforeach(test_name)

    foreach(test_name test_tester_2
                      test_tester_4)
        set_tests_properties(${test_name} PROPERTIES WILL_FAIL TRUE)
    endforeach(test_name)
endif(${BUILD_TESTING})
