#!/usr/bin/sh
gcovr -j12 --delete --print-summary --html-details --html-title CodeCoverage --html build/coverage.html build/
gcovr -j12 --delete --print-summary --gcov-executable "llvm-cov-15 gcov" --html-details --html-title CodeCoverage --html build/coverage.html build/