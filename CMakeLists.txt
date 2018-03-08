cmake_minimum_required(VERSION 2.6)

project(fortran_tester Fortran)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)
enable_testing()

include_directories(${CMAKE_Fortran_MODULE_DIRECTORY})

add_library(fortran_tester src/tester.f90)

foreach(test_name test_tester_01 test_tester_02
test_tester_03 test_tester_04 test_tester_05)
add_executable(${test_name} test/${test_name}.f90)
target_link_libraries(${test_name} fortran_tester)
add_test(NAME ${test_name} COMMAND ${test_name})
endforeach(test_name)

foreach(test_name test_fail_01 test_fail_02 test_fail_03 test_fail_04)
add_executable(${test_name} test/${test_name}.f90)
target_link_libraries(${test_name} fortran_tester)
add_test(NAME ${test_name} COMMAND ${test_name})
set_tests_properties(${test_name} PROPERTIES WILL_FAIL TRUE)
endforeach(test_name)

option(WITH_DOXYGEN OFF)

if(WITH_DOXYGEN)
find_package(Doxygen REQUIRED)
add_custom_target(doc
COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/doc"
COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/doc/doxygen_conf
DEPENDS ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/doc/doxygen_conf
WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
endif()
