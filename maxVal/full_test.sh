#!/bin/bash

out_path="outputs"

echo Starting Algorithm Test Scripts

rm -rf ./$out_path
mkdir -p $out_path

for i in 1 2 4 8 16 32 64 128 256 512 1024 2048 2560
do
    for j in {1..24}
    do
        make test NR_TASKLETS=$j NR_DPUS=$i > $out_path/out_nt"$j"_nd"$i".txt
    done
done

echo Testing Finished!