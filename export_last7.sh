#!/bin/bash
sqlite3 /home/krish/bitcoin_tracker/bitcoin.db \
"SELECT fetched_at || '|' || price 
 FROM price_history 
 WHERE fetched_at >= datetime('now','-7 days')
 ORDER BY fetched_at ASC;" \
> /home/krish/bitcoin_tracker/data_7days.tsv

echo "Exported last 7 days to data_7days.tsv"

