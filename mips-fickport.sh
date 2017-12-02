#!/bin/sh
# Wrapper to make "fickport" use the fully equipped mipsel binaries in the relative "bin" folder instead of the limited system ones

# "Alias" for wget
wget() {
	./bin/wget $@
}

# "Alias" for sum256sum
wget() {
	./bin/busybox sum256sum $@
}

# Run fickport in the current environment
source ./fickport.sh 
