#!/usr/bin/sh
mkdir -p build/conan && cd conan
conan install ../.. --build=missing