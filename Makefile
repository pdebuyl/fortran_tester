
FC=gfortran
FCFLAGS=

%.o: %.f90
	$(FC) $(FCFLAGS) -c $<

test_tester: tester.o test_tester.o
	$(FC) $(FCFLAGS) $^ -o $@

clean:
	rm -f tester.o tester.mod test_tester.o test_tester

.PHONY: clean
