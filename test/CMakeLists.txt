foreach(test_src test_tester_1.f90
                 test_tester_2.f90
                 test_tester_3.f90
                 test_tester_4.f90
                 test_tester_5.f90
                 test_tester_6.f90)
    get_filename_component(test_name ${test_src} NAME_WE)
    add_executable(${test_name} ${test_name}.f90)
    target_link_libraries(${test_name} fortran_tester)
    add_test(NAME ${test_name} COMMAND ${test_name})
endforeach()

foreach(test_name test_tester_2
                  test_tester_4)
    set_tests_properties(${test_name} PROPERTIES WILL_FAIL TRUE)
endforeach()
