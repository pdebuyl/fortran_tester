! This file is part of fortran_tester
! Copyright 2015 2018 Pierre de Buyl
! License: BSD

program test_tester_1
  use tester
  implicit none

  integer, parameter :: rk = selected_real_kind(15)
  complex(kind=rk) :: a(5), b(5)
  type(tester_t) :: test

  call test% init()

  call test% assert_equal((1, 1), (2, 2), fail=.true.)

  call test% assert_equal((1234, -1234), (1234, -1234))

  call test% assert_close((1._rk, 0._rk), (1._rk, 0._rk))

  call test% assert_close((0._rk, 1._rk), (1.e-15_rk, 1._rk), fail=.true.)

  call test% assert_close((0._rk, 1._rk), (1.e-16_rk, 1_rk), fail=.true.)

  call test% assert_close((1., 0.), (1., 1.e-6), fail=.true.)

  a = 1
  b = 1

  call test% assert_close(a, b)

  b(1) = b(1) + complex(0._rk, epsilon(real(b(1))))

  call test% assert_close(a, b)

  b = b + (0._rk, 1e-5_rk)

  call test% assert_close(a, b, fail=.true.)

  call test% print()

end program test_tester_1
