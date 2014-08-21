#!/bin/bash

export MONO_ROOT=${IROOT}/mono-3.6.0-install

export PATH="$MONO_ROOT/bin:$PATH"

export LD_LIBRARY_PATH="$MONO_ROOT/lib:$LD_LIBRARY_PATH"
