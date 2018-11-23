include ../common.mak

REPORT=report.txt

default: ${REPORT}


TESTS=$(wildcard ./*.ks)
TEST_OUTPUTS=${TESTS:=.out}
TEST_REFERENCE_OUTPUTS=${TESTS:=.ref}
TEST_RESULTS=${TESTS:=.result}

RUN=$(KRUN) --directory $(KS_OCAML_KOMPILED)

%.out: %
	@echo Running $<
	@$(RUN) $< > $@
	

%.result: %.out %.ref
	@echo Comparing
	diff $^; if [ $$? -eq 0 ] ; then echo passed > $@; else echo failed > $@; fi

$(REPORT): $(TEST_RESULTS)
	@echo $(TEST_RESULTS)

clean:
	@echo Cleaning
	rm -f *.out *.result


