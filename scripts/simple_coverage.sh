#!/bin/bash
# build with --coverage

mkdir build_coverage
cd build_coverage
cmake .. -DCMAKE_Fortran_FLAGS='--coverage'
make
make test
lcov -c -d . -o ft_coverage.info
genhtml ft_coverage.info --output-directory ft_coverage

