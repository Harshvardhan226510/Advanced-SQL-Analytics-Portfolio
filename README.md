# Advanced SQL Analytics Portfolio: Corporate Layoffs Pipeline

A production-grade SQL optimization portfolio demonstrating structural database engineering. This repository features an end-to-end relational database pipeline that builds an automated data cleaning framework and executes multi-dimensional Exploratory Data Analysis (EDA) on global workforce layoff logs using advanced MySQL design patterns.

---

## 📁 Repository Configuration

```text
├── data-cleaning-pipeline.sql    # Multi-stage staging schema creation, deduplication, and data casting
├── exploratory-data-analysis.sql # Windows functions, multi-layer CTEs, rolling metrics, and time-series aggregation
└── README.md                     # Central repository architecture matrix
```
## 🛠️ Data Engineering & Cleaning Pipeline
The raw dataset contained extensive human-input noise, duplicated transaction loops, unformatted date formats, and empty metadata attributes. The data cleaning script builds a structured staging table and processes it via four structural layers:

- 1. Vectorized Deduplication: 
    Because the table lacked a primary unique row index identifier, true duplicates were isolated by assigning row keys grouped across all system variables via       an analytical partition:
- 2. Analytical String Standardization
    Whitespace Pruning: Used structural TRIM() functions to clear accidental padding artifacts from critical indices (company, country).
    Categorical Consolidation: Merged fragmented classifications (such as converting variations like CryptoCurrency and CryptoTrading down to a single clean         unified token "Crypto") using structural wildcard mask matching filters (LIKE "Crypto%").
- 3. Structural Datetime Type Allocation
    Raw dates stored as text objects were parsed using safe layout wrappers (str_to_date) to shift formatting markers into structured ISO-compliant targets           (%m/%d/%Y), followed by modifying table data constraints into true DATE objects via ALTER TABLE operations.
- 4. Self-Join Value Imputation
    Empty or null string fields were resolved by running an inner self-join on company and location configurations to match missing labels against existing           historical tokens in the database

## 📊 Exploratory Data Analysis (EDA) Matrices
- 📈 1. Rolling Time-Series Volume Aggregations
  Calculated cumulative monthly trends across global metrics using a self-contained temporal substring CTE paired with an unbounded rolling analytic window         operation
- 🏆 2. Annualized Multi-Layer Leaderboard Rankings
  Extracted annual performance patterns by chaining dual Common Table Expressions to isolate and rank the top five organizations experiencing the highest layoff    volumes each calendar year, stratified via DENSE_RANK() partitions
- Technical Core Features Utilized
  ```
  Window Functions Syntax: ROW_NUMBER(), DENSE_RANK(), SUM() OVER(PARTITION BY...)

  Data Definition & Control Operations: CREATE TABLE LIKE, INSERT INTO SELECT, ALTER TABLE MODIFY

  Relational Join Formats: Multi-conditional self-joins (JOIN ON AND)

  String & Formatting Operations: TRIM(), STR_TO_DATE(), SUBSTR(), LIKE
```
