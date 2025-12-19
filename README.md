# SQL Case Study: Danny's Diner Analysis

## Project Overview
Analysis of customer behavior and restaurant operations for Danny’s Diner using MySQL. This project transforms raw transactional data into business insights regarding spending, loyalty, and menu performance.

## Analytical Process
The analysis followed a structured workflow to ensure data accuracy and logical consistency:
- **Data Integration**: Joined transactional datasets (`sales`) with reference tables (`menu`, `members`) using primary/foreign key relationships.
- **Logic Implementation**: Developed complex calculations using `CASE WHEN` to handle dynamic business rules, such as loyalty point multipliers.
- **Data Ranking**: Utilized Window Functions (`DENSE_RANK`) to identify first-time purchases and favorite items without losing data on ties.
- **Optimization**: Used Common Table Expressions (CTEs) to break down multi-step queries into readable, modular blocks.

## Applied Skills
- **Joins**: Inner Joins for data merging.
- **Aggregations**: `SUM`, `COUNT`, `DISTINCT` for revenue and visit metrics.
- **Window Functions**: `DENSE_RANK`, `PARTITION BY`.
- **Logic Control**: `CASE WHEN`, `BETWEEN`, `DATE_ADD`.

## Repository Content
- `schema.sql`: Database definition and data insertion scripts.
- `analysis.sql`: SQL solutions for 10 core business questions.
- `README.md`: Project documentation.

## Key Findings
- **Retention**: Customer A is the top spender and most frequent visitor.
- **Product**: Ramen is the most popular menu item based on order volume.
- **Membership**: Loyalty programs show a significant increase in points generated during the first week of enrollment.
