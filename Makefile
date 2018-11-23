include common.mak

default: kompile-all test-result.log

kompile-all: $(KS_JAVA_KOMPILED_TIMESTAMP) $(KS_OCAML_KOMPILED_TIMESTAMP)

$(KS_JAVA_KOMPILED_TIMESTAMP): ks.k ks-test.k
	${KOMPILE} --backend java --debug --main-module KS-TEST-MAIN --syntax-module KS-TEST-MAIN-SYNTAX ks-test.k --directory $(KS_JAVA_KOMPILED)

$(KS_OCAML_KOMPILED_TIMESTAMP): ks.k ks-test.k
	${KOMPILE} --backend ocaml --debug --main-module KS-TEST-MAIN --syntax-module KS-TEST-MAIN-SYNTAX ks-test.k --directory $(KS_OCAML_KOMPILED)


test-result.log: $(KS_JAVA_KOMPILED_TIMESTAMP) ks-spec.k
	${KPROVE} --directory $(KS_JAVA_KOMPILED) ks-spec.k > test-result.log

report.txt: $(KS_OCAML_KOMPILED_TIMESTAMP)
	$(MAKE) -C tests
	#cp ./tests/report.txt .

clean:
	$(MAKE) -C tests clean
	rm -rf $(KS_JAVA_KOMPILED) $(KS_OCAML_KOMPILED)
	rm -f report.txt
