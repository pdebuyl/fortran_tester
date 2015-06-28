# Fortran tester

`tester` is a Fortran module to test Fortran programs. It provides routines to
check equality or closeness between variables and counting the errors.

A minimal example:

```fortran
program test
  use module_test
  implicit none

  type(tester_t) :: tester

  call tester% init()

  call tester% assert_equal(1, 2, fail=.true.)

  call tester% print()

end program test_mt
```

**Author:** Pierre de Buyl  
**License:** BSD
