KOMPILE=kompile
KPROVE=kprove
KRUN=krun

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

KS_JAVA_KOMPILED=$(ROOT_DIR)/ks-kompiled-java
KS_JAVA_KOMPILED_TIMESTAMP=$(KS_JAVA_KOMPILED)/ks-test-kompiled/timestamp

KS_OCAML_KOMPILED=$(ROOT_DIR)/ks-kompiled-ocaml
KS_OCAML_KOMPILED_TIMESTAMP=$(KS_OCAML_KOMPILED)/ks-test-kompiled/timestamp



