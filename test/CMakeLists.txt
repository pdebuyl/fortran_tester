
foreach(test_src test_tester_01.f90
                 test_tester_02.f90
		 test_tester_03.f90
		 test_tester_04.f90
		 test_tester_05.f90
		 test_fail_01.f90
		 test_fail_02.f90
		 test_fail_03.f90
		 test_fail_04.f90)
    get_filename_component(test_name ${test_src} NAME_WE)
    add_executable(${test_name} ${test_name}.f90)
    target_link_libraries(${test_name} fortran_tester)
    add_test(NAME ${test_name} COMMAND ${test_name})
endforeach()

foreach(test_name test_fail_01
		  test_fail_02
		  test_fail_03
		  test_fail_04)
    set_tests_properties(${test_name} PROPERTIES WILL_FAIL TRUE)
endforeach()
