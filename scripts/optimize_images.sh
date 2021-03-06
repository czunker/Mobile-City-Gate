#!/bin/bash

BASEDIR=$1

for file in $(find ${BASEDIR} -iname "*.jpg" -o -iname "*.jepg")
do
       jpegtran $file > ${file}_new
       mv ${file}_new $file
done
for file in $(find ${BASEDIR} -name "*.png")
do
       optipng -quiet $file
done
