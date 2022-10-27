#!/bin/bash

set -e

rm -f class_variants-latest.gem

gem build class_variants.gemspec -o class_variants-latest.gem

gem push --host https://rubygems.org/ ./class_variants-latest.gem