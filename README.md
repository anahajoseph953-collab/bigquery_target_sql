# Brazilian E-Commerce Data Analysis Using BigQuery SQL

## Project Overview

This project analyzes Brazilian e-commerce data from the Olist dataset to understand customer distribution, order trends, payment behavior, shipping costs, and delivery performance.

Using Google BigQuery and Standard SQL, the project explores business questions and translates the results into actionable insights that can support data-driven decision-making.

## Business Objectives

- Analyze order volume and monthly seasonality.
- Understand customer distribution across Brazilian states.
- Identify popular ordering times and payment methods.
- Compare payment values between January–August 2017 and January–August 2018.
- Evaluate product prices and freight costs across states.
- Measure delivery times and compare actual delivery dates with estimated dates.
- Identify geographic differences in shipping and delivery performance.

## Tools and Technologies

- Google BigQuery
- SQL (BigQuery Standard SQL)
- Common Table Expressions (CTEs)
- Aggregate functions
- Date and time functions
- Conditional expressions
- Window functions
- Joins and subqueries

## Key Analysis Areas

### 1. Exploratory Data Analysis
- Inspected table structures and column data types.
- Identified the order purchase date range.
- Examined customer locations and geographic coverage.

### 2. Order Trends and Seasonality
- Calculated monthly order volumes by year.
- Investigated seasonal patterns and order growth.
- Classified orders by time of day.

### 3. Customer Geographic Analysis
- Counted customers across Brazilian states.
- Compared geographic customer distribution.
- Identified regions for further market analysis.

### 4. Payment and Economic Analysis
- Compared payment values across selected years.
- Analyzed product prices and freight costs by state.
- Investigated payment methods and installment patterns.

### 5. Delivery and Logistics Performance
- Calculated the number of days between purchase and delivery.
- Measured differences between actual and estimated delivery dates.
- Compared average freight costs and delivery times across states.

## Business Value

The analysis can help identify seasonal demand patterns, geographic differences in customer activity, commonly used payment methods, and potential logistics challenges.

These findings can support decisions related to marketing, fulfillment planning, shipping-cost evaluation, and customer experience.

## Repository Structure

- `data_exploration.sql` — Exploratory analysis and business questions.
- `README.md` — Project overview, methodology, and findings.

## Key Findings

*Add verified findings after executing the SQL queries.*

- **Order trends:** [Add the observed growth or decline and relevant months.]
- **Customer distribution:** [Add the leading states and customer counts.]
- **Payment behavior:** [Add the most frequently used payment methods.]
- **Payment value:** [Add the January–August year-over-year percentage change.]
- **Delivery performance:** [Add average delivery time and early/on-time/late delivery findings.]
- **Freight costs:** [Add the states with the highest and lowest average freight values.]

## Recommendations

Recommendations will be based on the calculated results and may include improving logistics in slower-delivery regions, evaluating high-freight-cost areas, planning around seasonal demand, and optimizing the checkout experience based on payment preferences.

## Conclusion

This project demonstrates the use of SQL for data exploration, data aggregation, time-based analysis, and business performance evaluation using a real-world e-commerce dataset.

This project demonstrates the application of SQL to real-world e-commerce analysis, including customer segmentation, order trends, payment behavior, and logistics performance.

The final deliverables will include SQL scripts, validated numerical findings, actionable business recommendations, and an interactive dashboard.
