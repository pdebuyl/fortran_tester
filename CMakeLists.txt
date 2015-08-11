cmake_minimum_required(VERSION 2.6)

project(fortran_tester Fortran)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)

include_directories(${CMAKE_Fortran_MODULE_DIRECTORY})

add_library(fortran_tester tester.f90)

add_executable(test_tester test_tester.f90)
target_link_libraries(test_tester fortran_tester)
