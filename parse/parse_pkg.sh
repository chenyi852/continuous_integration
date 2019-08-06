#!/bin/bash

file=README

### - bootstrap                      L4 system boot loader / Boot-image generator
### svn up bootstrp
grep ^- $file | awk '{print $2}' | xargs svn up