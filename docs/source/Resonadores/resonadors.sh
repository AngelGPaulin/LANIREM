#!/bin/bash

dir=$(ls -1 *.md)

for ss in $dir
do
  echo $ss
  dd=${ss%.*}
  python3 convert.py $dd
done



