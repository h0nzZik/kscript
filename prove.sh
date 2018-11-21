#!/bin/bash

set -e

#DEBUG=--debug
kprove $DEBUG --directory ks-kompiled ks-spec.k
