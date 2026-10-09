# Bright Coffee Shop Sales Analysis

**BrightLearn Data Analytics | Case Study 01**
**Candidate:** DT Mbenga

---

## Overview

Bright Coffee Shop runs three stores in New York: Astoria, Hell's Kitchen and Lower Manhattan. The new CEO wants to understand sales performance to grow revenue.

This project analyses six months of transaction data (1 January to 30 June 2023, 149,116 sales) to answer four questions:

1. Which products and categories generate the most revenue and units?
2. When are the stores busiest (time of day, day of week, month)?
3. How do the three stores compare?
4. What should the business do next?

## Process

Data preparation followed the **CLEAN** framework (Conceptualize, Locate, Evaluate, Augment, Note).

| Stage | What was done | Tool |
|---|---|---|
| 1. Planning | Mind map of data flow, insights and calculations; project schedule | Miro, Gantt chart |
| 2. Load | Raw CSV uploaded (semicolon delimiter) to `bright_coffee.sales.coffee_sales_clean` | Databricks |
| 3. Inspection | Row count, data types, stores and opening hours, missing values, price, date/time and quantity checks | Databricks SQL |
| 4. Processing | Big code in 4 steps: date labels, 30-minute time slots, revenue = unit_price × quantity, grouped to 130,537 rows | Databricks SQL |
| 5. Result check | Totals re-calculated to prove no sale was lost: 149,116 sales, 214,470 units, $698,812.33 | Databricks SQL |
| 6. Analysis | Pivot tables, pivot charts and Store/Month slicers on 5 analysis tabs, plus a CEO dashboard | Excel |
| 7. Dashboards | Interactive CEO dashboards | Looker Studio, Databricks, Power BI, Lovable |
| 8. Presentation | Findings and recommendations for the CEO | PowerPoint |

**Data quality**
- No missing values; prices and quantities valid (quantities 1–8, prices $0.80–$45.00).
- The date column carried a hidden midnight time, and the time column a placeholder date (1899-12-31). Both were cleaned in SQL.
- Revenue is reported in **US dollars** (assumed: no currency field, and all stores are in New York).
- The data has **no cost information**, so profit could not be calculated.

## Summary of key findings

| Area | Finding |
|---|---|
| Revenue | **$698,812** from **149,116** sales; average sale **$4.69** |
| Trend | Revenue doubled from **$81.7k (Jan)** to **$166.5k (Jun)**; February was the only dip |
| Time of day | Mornings drive the business: peak **08:00–10:30** (top slot 10:30, $45.0k); sharp drop at 11:00 |
| Day of week | Sales evenly spread across the week |
| Stores | All three stores are close ($230k–$237k); Hell's Kitchen leads slightly |
| Products | Coffee and Tea make up **74% of units**; Barista Espresso is the top product type ($91.4k) |
| Slow sellers | Take-home retail items (packaged chocolate, loose tea, coffee beans) sell the least |

**Recommendations**
- Staff up for the 08:00–10:30 morning peak.
- Build afternoon promotions to lift sales after 11:00.
- Bundle slow retail items with top coffee drinks.
- Protect Coffee and Tea availability; they drive most of the units.

## Tools used

| Tool | Used for |
|---|---|
| Miro | Mind map planning |
| Databricks (SQL) | Storage, inspection and data processing |
| Microsoft Excel | Pivot tables, pivot charts, slicers and CEO dashboard |
| Looker Studio | Web dashboard |
| Databricks Dashboard | SQL dashboard (KPIs, store share, store × month, day × time heat map) |
| Power BI | Interactive dashboard (stores, day of week, bottom products, month-on-month) |
| Lovable | AI-built web dashboard |
| PowerPoint | CEO presentation |
| GitHub | Project repository |

## Repository structure

| Folder | Contents |
|---|---|
| `01_Project_Description` | Case study brief (PDF) and raw sales data (CSV) |
| `02_Planning` | Miro mind map (PDF) and Gantt chart |
| `03_Data_Processing` | `Bright_Coffee_Shop_SQL_Code_DT_Mbenga.sql` and `Bright_Coffee_Shop_Data_Processing_DT_Mbenga.xlsx` |
| `04_Presentation` | Looker Studio, Databricks, Power BI and Lovable dashboards, and the CEO presentation |

## What I learned

- Inspect before processing: the date/time and price issues were only found through inspection.
- Keep processing in one documented, repeatable query.
- Check totals after every step, so every tool shows the same numbers.
- Each tool has a strength: SQL to prepare, Excel to analyse, BI tools to present interactively.
