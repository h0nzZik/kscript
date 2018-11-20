#!/bin/bash

set -e

kompile --backend java --debug --main-module KS-TEST-MAIN --syntax-module KS-SYNTAX ks-test.k --directory ks-kompiled
