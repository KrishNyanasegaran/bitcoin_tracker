#!/bin/bash

cd ~/bitcoin_tracker

./plot.sh price
./plot.sh low
./plot.sh high
./plot.sh price_points
./plot.sh low_points
./plot.sh high_points
./plot.sh price_vs_low
./plot.sh price_vs_high
./plot.sh low_vs_high
./plot.sh history

echo "All 10 plots generated."
