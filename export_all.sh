#!/bin/bash

OUT="/home/krish/bitcoin_tracker/plot_data.tsv"

sqlite3 /home/krish/bitcoin_tracker/bitcoin.db <<EOF
.headers off
.mode list
.separator "\t"
.output $OUT
SELECT id, price, low24, high24, avg_price, fetched_at 
FROM price_history;
EOF

echo "Exported all DB rows → $OUT"
