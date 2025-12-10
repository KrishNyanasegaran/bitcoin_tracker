#!/bin/bash

DATA="/home/krish/bitcoin_tracker/plot_data.tsv"
OUTDIR="/home/krish/bitcoin_tracker"

if [ ! -f "$DATA" ]; then
    echo "ERROR: Data file not found: $DATA"
    exit 1
fi

make_plot() {
    number=$1
    title=$2
    column=$3
    ylabel=$4
    filename="$OUTDIR/${number}_${title}.png"

    gnuplot <<EOF
set terminal png size 1200,600
set output "$filename"
set datafile separator "\t"
set title "$title"
set xlabel "Entry Number"
set ylabel "$ylabel"
set grid
plot "$DATA" using 1:$column with lines lw 2 linecolor rgb "blue" title "$ylabel"
EOF
}

make_plot 1 "price" 2 "Price (USD)"
make_plot 2 "low" 3 "24h Low"
make_plot 3 "high" 4 "24h High"
make_plot 4 "avg" 5 "Average Price"

gnuplot <<EOF
set terminal png size 1200,600
set output "$OUTDIR/5_price_vs_low.png"
set datafile separator "\t"
set title "Price vs Low24"
set xlabel "Low24"
set ylabel "Price"
set grid
plot "$DATA" using 3:2 with points pointtype 7 linecolor rgb "red" title "Price vs Low"
EOF

gnuplot <<EOF
set terminal png size 1200,600
set output "$OUTDIR/6_price_vs_high.png"
set datafile separator "\t"
set title "Price vs High24"
set xlabel "High24"
set ylabel "Price"
set grid
plot "$DATA" using 4:2 with points pointtype 7 linecolor rgb "green" title "Price vs High"
EOF

gnuplot <<EOF
set terminal png size 1200,600
set output "$OUTDIR/7_low_vs_high.png"
set datafile separator "\t"
set title "Low24 vs High24"
set xlabel "Low24"
set ylabel "High24"
set grid
plot "$DATA" using 3:4 with points pointtype 7 linecolor rgb "purple" title "Low vs High"
EOF

gnuplot <<EOF
set terminal png size 1200,600
set output "$OUTDIR/8_price_trend.png"
set datafile separator "\t"
set title "Price Trend"
set xlabel "Entry Number"
set ylabel "Price"
set grid
plot "$DATA" using 1:2 with lines lw 2 linecolor rgb "orange" title "Price Trend"
EOF

gnuplot <<EOF
set terminal png size 1200,600
set output "$OUTDIR/9_volatility.png"
set datafile separator "\t"
set title "Volatility (High-Low)"
set xlabel "Entry Number"
set ylabel "Volatility"
set grid
plot "$DATA" using 1:(\$4-\$3) with lines lw 2 linecolor rgb "dark-red" title "Volatility"
EOF

gnuplot <<EOF
set terminal png size 1200,600
set output "$OUTDIR/10_avg_vs_price.png"
set datafile separator "\t"
set title "Average Price vs Actual Price"
set xlabel "Average Price"
set ylabel "Actual Price"
set grid
plot "$DATA" using 5:2 with points pointtype 7 linecolor rgb "cyan" title "Avg vs Price"
EOF

echo "All plots generated."

