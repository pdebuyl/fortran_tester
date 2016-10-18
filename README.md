# Fortran tester

`tester` is a Fortran module to test Fortran programs. It provides routines to
check equality or closeness between variables and counting the errors.

A minimal example:

```fortran
program test
  use tester
  implicit none

  type(tester_t) :: my_tester

  call my_tester% init()

  call my_tester% assert_equal(1, 2, fail=.true.)

  call my_tester% print()

end program test
```

If none of the tests fail, the `print` method displays the message
`fortran_tester: all tests succeeded`.
Else, the program will exit with a nonzero error code, making it suitable for
use as an automated test.

**Author:** Pierre de Buyl  
**License:** BSD

Contributors: Peter Colberg, Stefano Szaghi
