#!/bin/bash

set -e

kompile --backend java --debug --main-module KS-TEST-MAIN --syntax-module KS-TEST-MAIN-SYNTAX ks-test.k --directory ks-kompiled
