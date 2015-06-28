program test_mt
  use module_test
  implicit none

  type(tester_t) :: tester

  call tester% init()

  call tester% assert_equal(1, 2, fail=.true.)

  call tester% assert_equal(-121, -11**2)

  call tester% assert_equal(.true., 2 > 1)

  call tester% assert_close(1.d0, (1.d0+1.d-16))

  call tester% assert_close(1.d0, (1.d0+1.d-15), fail=.true.)

  call tester% assert_close(1., (1.+1.e-7))

  call tester% assert_close(1., (1.+1.e-6), fail=.true.)

  call tester% assert_close([1.d0, 2.d0, 3.d0], [1.d0+1.d-15, 2.d0, 3.d0], fail=.true.)

  call tester% assert_close([1.d0, 2.d0], [1.d0, 2.d0, 3.d0], fail=.true.)

  call tester% assert_close([1.d0, 2.d0], [1.d0, 2.d0])

  call tester% print()

end program test_mt
