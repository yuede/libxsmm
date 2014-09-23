#!/bin/bash

DIRSRC=knc
DIRINC=.
DIRSCR=.
SIZE=8

if [ "$1" != "" ] ; then
  SIZE=$1
fi


python $DIRSCR/generate_inc.py $SIZE $SIZE $SIZE > $DIRINC/xsmm_knc.h

rm $DIRSRC/*.cpp
rm $DIRSRC/*.c
rm $DIRSRC/*.o
rm $DIRSRC/*.a
for m in $(seq 1 $SIZE); do
  for n in $(seq 1 $SIZE); do
    for k in $(seq 1 $SIZE); do
      echo $m $n $k
      python $DIRSCR/generate_src.py $m $n $k >> $DIRSRC/xsmm_dnn_"$m"_"$n"_"$k".c
    done
  done
done

python $DIRSCR/generate_main.py $SIZE $SIZE $SIZE >> $DIRSRC/xsmm_knc.c
