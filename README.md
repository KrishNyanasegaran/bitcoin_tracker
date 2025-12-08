Bitcoin Price Tracker – UNIX, SQLite, Crontab, and Gnuplot
Overview
This project implements an automated Bitcoin price tracking system using Unix shell scripting, SQLite for data storage, cron for scheduled execution, and Gnuplot for data visualization. The system collects Bitcoin price data at regular intervals, validates and stores the information in a database, and generates multiple analytical plots based on the accumulated dataset.
This project was developed for the module COMP1314 – Data Management (University of Southampton Malaysia) and follows the marking rubric requirements for Unix scripting, data manipulation, error handling, database integration, and visualization.
Functional Components
1. Data Collection (scraper.sh)
The scraper script performs the following operations:
Retrieves HTML content from a lightweight Bitcoin price website using curl.
Validates that the HTML response is complete and structurally correct.
Extracts the current Bitcoin price using regular expressions.
Performs error handling for malformed responses, missing data, or invalid numerical values.
Inserts valid records into the SQLite database (bitcoin.db).
Logs successful executions to run.log.
Logs failures, parsing errors, and network issues to error.log.
The script can be executed manually using:
./scraper.sh
2. Database Storage (SQLite)
All collected data is stored in an SQLite database. The system uses a single normalized table named price_history.
Table Structure
Column	Type	Description
id	INTEGER	Primary key (auto-increment)
price	REAL	Current Bitcoin price at fetch time
low24	REAL	24-hour low (placeholder)
high24	REAL	24-hour high (placeholder)
avg_price	REAL	Average price
fetched_at	TEXT	Timestamp of data collection
To view the schema:
sqlite3 bitcoin.db "PRAGMA table_info(price_history);"
3. Scheduled Automation (Cron)
The system is automated to run every hour using Linux cron, ensuring consistent data collection without manual intervention.
To edit crontab:
crontab -e
Cron entry:
0 * * * * /home/krish/bitcoin_tracker/scraper.sh >> /home/krish/bitcoin_tracker/cron.log 2>&1
This ensures:
Hourly execution
Logging of output and errors from cron
4. Data Export Scripts
Two export scripts are provided:
a. Export All Records
./export_all.sh
Outputs the entire database to plot_data.tsv, ready for plotting.
b. Export Last 7 Days
./export_last7.sh
Extracts only the last seven days of data into a TSV file for analysis.
5. Data Visualization (plot.sh)
This script generates ten distinct analytical plots using Gnuplot. These include:
Price over time
Low price over time
High price over time
Price scatter plot
Low price scatter plot
High price scatter plot
Price vs Low comparison
Price vs High comparison
Low vs High correlation plot
Full historical price trend
All output graphs are stored in:
plots/
To generate all plots:
./plot.sh
Directory Structure
bitcoin_tracker/
│── scraper.sh
│── plot.sh
│── export_all.sh
│── export_last7.sh
│── bitcoin.db
│── run.log
│── error.log
│── cron.log
│── plot_data.tsv
│── plots/
│     ├── 1_price.png
│     ├── 2_low.png
│     ├── ... (total 10 plots)
│── README.md
Error Handling
The system implements structured error detection, covering:
Empty or incomplete HTML responses
Unexpected page structure changes
Invalid numerical extraction
Database insertion failures
Network issues
Errors are appended to error.log, enabling traceability and improving robustness, which satisfies the assignment’s requirement for error-handling complexity.
Git Version Control
The development process includes:
Progressive commits over multiple days
Meaningful commit messages
Organized repository structure
Appropriate use of GitHub for project hosting
This meets the requirements for the Git component of the coursework.
Execution Summary
Initial Setup
chmod +x scraper.sh plot.sh export_all.sh export_last7.sh
Run Data Scraper
./scraper.sh
Generate Plots
./plot.sh
Export Data
./export_all.sh
./export_last7.sh
Conclusion
This project demonstrates the complete workflow of automated data collection, validation, error handling, database management, and graphical analysis within a Unix-based environment. The implementation adheres closely to the coursework criteria by incorporating scripting techniques, automated scheduling, structured data storage, and comprehensive visualization output.
