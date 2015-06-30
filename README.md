# Fortran tester

`tester` is a Fortran module to test Fortran programs. It provides routines to
check equality or closeness between variables and counting the errors.

A minimal example:

```fortran
program test
  use tester
  implicit none

  type(tester_t) :: tester

  call tester% init()

  call tester% assert_equal(1, 2, fail=.true.)

  call tester% print()

end program test_mt
```

If none of the tests fail, the `print` method displays the message
`fortran_tester: all tests succeeded`. This message can be used to check for the
success of the tests with the CMake test property
[`PASS_REGULAR_EXPRESSION`](http://www.cmake.org/cmake/help/v3.3/prop_test/PASS_REGULAR_EXPRESSION.html).

**Author:** Pierre de Buyl  
**License:** BSD
