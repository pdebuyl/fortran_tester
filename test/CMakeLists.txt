foreach(test_name test_tester_1
                  test_tester_2
                  test_tester_3
                  test_tester_4
                  test_tester_5
                  test_tester_6)
    add_executable(${test_name} ${test_name}.f90)
    target_link_libraries(${test_name} fortran_tester)
    add_test(NAME ${test_name} COMMAND ${test_name})
endforeach()

foreach(test_name test_tester_2
                  test_tester_4)
    set_tests_properties(${test_name} PROPERTIES WILL_FAIL TRUE)
endforeach()