#!/bin/bash

echo "Run at $(date '+%F %T')" >> ~/bitcoin_tracker/run.log

url="https://crypto.com/eea/price/bitcoin"
html=$(curl -s "$url")

if [ -z "$html" ]; then
    echo "$(date '+%F %T') curl_failed_empty_html" >> ~/bitcoin_tracker/error.log
    exit 1
fi

if ! echo "$html" | grep -q "</html>"; then
    echo "$(date '+%F %T') website_structure_changed" >> ~/bitcoin_tracker/error.log
    exit 1
fi

price=$(echo "$html" | grep -oP '[0-9,]+\.[0-9]{2}' | head -n 1 | tr -d ',')

if [ -z "$price" ]; then
    echo "$(date '+%F %T') price_not_found" >> ~/bitcoin_tracker/error.log
    exit 1
fi

if ! echo "$price" | grep -qE '^[0-9]+(\.[0-9]+)?$'; then
    echo "$(date '+%F %T') invalid_price_value $price" >> ~/bitcoin_tracker/error.log
    exit 1
fi

# Use same value for low, high, avg, low24, high24, avg_price (since website only gives 1 number)
low=$price
high=$price
avg=$price
low24=$price
high24=$price
avg_price=$price
source_id=1

sqlite3 ~/bitcoin_tracker/bitcoin.db \
"INSERT INTO price_history(price, fetched_at, low, high, avg, source_id, low24, high24, avg_price)
 VALUES($price, datetime('now','localtime'), $low, $high, $avg, $source_id, $low24, $high24, $avg_price);"

echo "Stored: price=$price low=$low high=$high avg=$avg at $(date '+%F %T')"

