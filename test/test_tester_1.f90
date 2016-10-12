! This file is part of fortran_tester
! Copyright 2015 Pierre de Buyl
! License: BSD

program test_mt
  use tester
  implicit none

  type(tester_t) :: test

  call test% init()

  call test% assert_equal(1, 2, fail=.true.)

  call test% assert_equal(-121, -11**2)

  call test% assert_equal([1, -10, 1899010], [1, -10, 1899010])

  call test% assert_equal(.true., 2 > 1)

  call test% assert_close(1.d0, (1.d0+1.d-16))

  call test% assert_close(1.d0, (1.d0+1.d-15), fail=.true.)

  call test% assert_close(1., (1.+1.e-7))

  call test% assert_close(1., (1.+1.e-6), fail=.true.)

  call test% assert_close([1.d0, 2.d0, 3.d0], [1.d0+1.d-15, 2.d0, 3.d0], fail=.true.)

  call test% assert_close([1.d0, 2.d0], [1.d0, 2.d0, 3.d0], fail=.true.)

  call test% assert_close([1.d0, 2.d0], [1.d0, 2.d0])

  call test% print()

end program test_mt
