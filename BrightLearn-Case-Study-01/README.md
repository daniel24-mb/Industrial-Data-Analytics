# Bright Coffee Shop Sales Analysis
**BrightLearn Data Analytics | Case Study 01**
**Candidate:** DT Mbenga

---

## About the case
Bright Coffee Shop has appointed a new CEO whose goal is to grow revenue and improve product performance.
As a Junior Data Analyst, my task was to analyse six months of sales data (January to June 2023,
149,116 sales records across 3 stores) and present insights and recommendations to the CEO.

**Business questions:**
1. Which products generate the most revenue?
2. What time of day do the stores perform best?
3. What are the sales trends across products and time?
4. What should the business do to improve sales?

---

## Approach
| Stage | Tool | What was done |
|---|---|---|
| Planning | Miro | Data flow and architecture diagram, key insights and calculations |
| Technical inspection | Databricks (SQL) | Checked structure, data types, stores, dates, opening hours, missing values and quantities |
| Data processing | Databricks (SQL) | Fixed data types and built one summary table (the "big code") |
| Analysis | Google Sheets, Looker Studio | Pivot tables and dashboard |
| Presentation | PowerPoint | Insights and recommendations for the CEO |

**Methods used:** the CLEAN framework to prepare the data, and the four-pillar framework
(Define, Dimensions, Visualise, Recommend) to analyse it.

---

## Data processing summary
- **Inspection findings:** no missing values; prices loaded correctly; the date carried a midnight time,
  and the time carried Excel's placeholder date (1899-12-31).
- **Fixes:** date cast to DATE, time reduced to HH:mm:ss, price cast to 2 decimals.
- **New columns:** day name, weekday/weekend, month, hour, 30-minute time bucket,
  time of day (Morning/Afternoon/Evening), and revenue (unit_price x transaction_qty).
- **Check:** all 149,116 sales and total revenue of $698,812.33 carried through to the summary table.

---

## Key findings
- Revenue peaks in the **morning (08:00 to 10:30)**, at about $45k per 30-minute slot.
- Revenue drops sharply after 10:30 and stays flat through the afternoon (about $20k per slot).
- The slowest period is 20:00 to 20:30.
- *(To be completed: top products, store comparison, monthly trend.)*

---

## What I learned
- Inspect the data before changing it: inspection revealed the delimiter and date and time issues.
- Keep the raw data untouched and do all cleaning in SQL, so every change is documented.
- Build a large query step by step, testing each part before adding the next.
- Use CASE to create business categories, and COUNT/SUM with GROUP BY to summarise data.
- Choose the right chart: line or bar charts for time, pie charts only for a few categories.

---

## Folder contents
| Folder | Contents |
|---|---|
| Project Description & Raw Data | Case study brief and original dataset |
| Project Planning | Miro diagram |
| Data Processing | SQL code and processed spreadsheet with pivot tables and charts |
| Project Presentation | CEO presentation |
