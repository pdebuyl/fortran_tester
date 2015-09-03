! This file is part of fortran_tester
! Copyright 2015 Pierre de Buyl
! License: BSD

module tester
  implicit none
  private
  public :: tester_t

  type tester_t
     integer :: n_errors
     integer :: n_tests
     real :: r_tol
     double precision :: d_tol
   contains
     procedure :: init
     procedure :: print
     generic, public :: assert_equal => assert_equal_i, assert_equal_l, assert_equal_i_1, assert_equal_d
     procedure, private :: assert_equal_i
     procedure, private :: assert_equal_l
     procedure, private :: assert_equal_i_1
     procedure, private :: assert_equal_d
     generic, public :: assert_positive => assert_positive_i, assert_positive_i_1, assert_positive_d
     procedure, private :: assert_positive_i
     procedure, private :: assert_positive_i_1
     procedure, private :: assert_positive_d
     generic, public :: assert_close => assert_close_d, assert_close_r, assert_close_d_1
     procedure, private :: assert_close_d
     procedure, private :: assert_close_r
     procedure, private :: assert_close_d_1
  end type tester_t

contains

  subroutine init(this, d_tol, r_tol)
    class(tester_t), intent(out) :: this
    double precision, intent(in), optional :: d_tol
    real, intent(in), optional :: r_tol

    this% n_errors = 0
    this% n_tests = 0

    if (present(d_tol)) then
       this% d_tol = d_tol
    else
       this% d_tol = 2.d0*epsilon(1.d0)
    end if

    if (present(r_tol)) then
       this% r_tol = r_tol
    else
       this% r_tol = 2.*epsilon(1.)
    end if

  end subroutine init

  subroutine print(this)
    class(tester_t), intent(in) :: this

    write(*,*) 'fortran_tester:', this% n_errors, ' error(s) for', this% n_tests, 'test(s)'

    if (this% n_errors == 0) write(*,*) 'fortran_tester: all tests succeeded'

  end subroutine print

  subroutine assert_equal_i(this, i1, i2, fail)
    class(tester_t), intent(inout) :: this
    integer, intent(in) :: i1, i2
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1
    if (i1 .ne. i2) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_equal_i

  subroutine assert_equal_d(this, d1, d2, fail)
    class(tester_t), intent(inout) :: this
    double precision, intent(in) :: d1, d2
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1
    if (d1 .ne. d2) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_equal_d

 subroutine assert_equal_l(this, l1, l2, fail)
    class(tester_t), intent(inout) :: this
    logical, intent(in) :: l1, l2
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1
    if (l1 .neqv. l2) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_equal_l

  subroutine assert_equal_i_1(this, i1, i2, fail)
    class(tester_t), intent(inout) :: this
    integer, intent(in), dimension(:) :: i1, i2
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1

    if ( size(i1) .ne. size(i2) ) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    else
       if ( maxval(abs(i1-i2)) > 0 ) then
          if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
             this% n_errors = this% n_errors + 1
          end if
       end if
    end if

  end subroutine assert_equal_i_1

  subroutine assert_positive_i(this, i, fail)
    class(tester_t), intent(inout) :: this
    integer, intent(in) :: i
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1
    if (i < 0) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_positive_i

  subroutine assert_positive_d(this, d, fail)
    class(tester_t), intent(inout) :: this
    double precision, intent(in) :: d
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1
    if (d < 0) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_positive_d

  subroutine assert_positive_i_1(this, i, fail)
    class(tester_t), intent(inout) :: this
    integer, intent(in), dimension(:) :: i
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1

    if ( minval(i) < 0 ) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_positive_i_1

  subroutine assert_close_d(this, d1, d2, fail)
    class(tester_t), intent(inout) :: this
    double precision, intent(in) :: d1, d2
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1

    if ( abs(d1-d2) > this% d_tol ) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_close_d

  subroutine assert_close_d_1(this, d1, d2, fail)
    class(tester_t), intent(inout) :: this
    double precision, intent(in), dimension(:) :: d1, d2
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1

    if ( size(d1) .ne. size(d2) ) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    else
       if ( maxval(abs(d1-d2)) > this% d_tol ) then
          if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
             this% n_errors = this% n_errors + 1
          end if
       end if
    end if

  end subroutine assert_close_d_1

  subroutine assert_close_r(this, r1, r2, fail)
    class(tester_t), intent(inout) :: this
    real, intent(in) :: r1, r2
    logical, intent(in), optional :: fail

    this% n_tests = this% n_tests + 1

    if ( abs(r1-r2) > this% r_tol ) then
       if (.not. present(fail) .or. (present(fail) .and. fail .eqv. .false.)) then
          this% n_errors = this% n_errors + 1
       end if
    end if

  end subroutine assert_close_r

end module tester
