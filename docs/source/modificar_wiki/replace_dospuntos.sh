#!/bin/bash

dir=$(ls -1 *:-*)

for ss in $dir
do
  echo $ss
  dd=$(echo $ss | sed 's/á/a/')
  dd=$(echo $dd | sed 's/ñ/n/')
  dd=$(echo $dd | sed 's/ó/o/')
  dd=$(echo $dd | sed 's/:-/_/')
  echo $dd
  mv $ss $dd
done

