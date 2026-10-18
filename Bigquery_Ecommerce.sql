-- TARGET / Brazilian E-commerce (Olist) analysis
-- BigQuery Standard SQL


-- 1.1 Data types of all columns in customers table

SELECT *
FROM `Target_Sql. customers`;

# = 2. Get the time range between which the orders were placed.

SELECT *
FROM `Target_Sql.geolocation`
LIMIT 5;


# Get the time range between which the orders were placed.

SELECT
min(order_purchase_timestamp) as start_time,
max(order_purchase_timestamp) as end_time
FROM `Target_Sql.orders`;


# Display the details Cities & States of customers who ordered during the given period.

SELECT
c.customer_city, c.customer_state
FROM `Target_Sql.orders` as o
JOIN `Target_Sql. customers` as c
ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR from o.order_purchase_timestamp) = 2018
AND EXTRACT(MONTH from o.order_purchase_timestamp) BETWEEN 1 AND 3;

# Is there a growing trend in the no. of orders placed over the past years?

SELECT
EXTRACT(month from order_purchase_timestamp) as month,
count(order_id) as order_num
FROM `Target_Sql.orders`
GROUP BY EXTRACT ( month from order_purchase_timestamp)
ORDER BY order_num desc

# During what time of the day, do the Brazilian customers mostly place their orders? (Dawn, Morning, Afternoon or Night)
# 0-6 hrs : Dawn
# 7-12 hrs : Mornings
# 13-18 hrs : Afternoon
# 19-23 hrs : Night

SELECT
EXTRACT(hour from order_purchase_timestamp) as time,
count(order_id) as order_num
FROM `Target_Sql.orders`
GROUP BY EXTRACT ( hour from order_purchase_timestamp)
ORDER BY order_num desc;

# with CTE

WITH cte AS (
    SELECT
        CASE
            WHEN EXTRACT(HOUR FROM O.order_purchase_timestamp) BETWEEN 0 AND 6 THEN 'Dawn'
            WHEN EXTRACT(HOUR FROM O.order_purchase_timestamp) BETWEEN 7 AND 12 THEN 'Mornings'
            WHEN EXTRACT(HOUR FROM O.order_purchase_timestamp) BETWEEN 13 AND 18 THEN 'Afternoon'
            ELSE 'Night'
        END AS time_of_the_day
    FROM `Target_Sql.orders` AS O
    JOIN `Target_Sql. customers` AS C
        ON O.customer_id = C.customer_id
)

SELECT
    time_of_the_day,
    COUNT(*) AS volume
FROM cte
GROUP BY time_of_the_day;

 3. Get month on month number of orders.

SELECT
EXTRACT( MONTH FROM order_purchase_timestamp ) as month,
EXTRACT( YEAR FROM order_purchase_timestamp ) as year,
COUNT(*) as num_orders
FROM `Target_Sql.orders`
GROUP BY year, month
ORDER BY year, month;

#2. Distribution of customers across the states of brazil

SELECT customer_state,
COUNT(DISTINCT customer_id) as customer_count
FROM `Target_Sql. customers`
GROUP BY customer_state
ORDER BY customer_count DESC


# Get the % increase in the cost of orders from year 2017 to 2018 (include months between Jan to Aug only).
# You can use the "payment_value" column in the payments table to get the cost of orders.


# STEP 1: Calculate total payments per year

With yearly_totals as (
SELECT
EXTRACT(YEAR from o.order_purchase_timestamp)as year,
SUM(p.payment_value) as total_payment
FROM `Target_Sql.payments` as p
JOIN `Target_Sql.orders` as o
ON p.order_id = o.order_id
WHERE EXTRACT(YEAR from o.order_purchase_timestamp) in (2017,2018)
and EXTRACT(MONTH from o.order_purchase_timestamp) between 1 and 8
GROUP BY EXTRACT(YEAR from o.order_purchase_timestamp)
),

# STEP 2: Use LEAD window function to compare each year's payments with the previous year
yearly_comparisons AS (
SELECT
year,
total_payment,
LEAD(total_payment) over (order by year desc) as prev_year_payment
from yearly_totals
)
# STEP 3: Calculate % increase
SELECT round(((total_payment - prev_year_payment) / prev_year_payment)*100,2)
FROM yearly_comparisons;


# Mean & SUM of price and freight value by customer state

SELECT
c.customer_state,
AVG(price) as avg_price,
SUM(price) as sum_price,
AVG(freight_value) as avg_freight,
SUM(freight_value) as sum_freight
FROM `Target_Sql.orders` as o
JOIN `Target_Sql.order_ietms` as oi
ON o.order_id = oi.order_id
JOIN `Target_Sql. customers` as c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state;



# Calculate days between purchasing, delivering, and estimated delivery.

SELECT order_id,
DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_purchase_timestamp), DAY) as days_to_delivery,
DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) as
diff_estimated_delivery
FROM `Target_Sql.orders`;

# Find out the top 5 states with the highest & lowest average freight value.

SELECT c.customer_state,
AVG(freight_value) as avg_freight_value
FROM `Target_Sql.orders` as o
JOIN `Target_Sql.order_ietms` as oi
ON o.order_id = oi.order_id
JOIN `Target_Sql. customers` as c
ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY avg_freight_value DESC
LIMIT 5;


# Find out the top 5 states with the highest & lowest average delivery time.

SELECT
c.customer_state,
AVG(EXTRACT( DATE from o.order_delivered_customer_date) - EXTRACT( DATE from o.order_purchase_timestamp)) as
avg_time_to_delivery
FROM `Target_Sql.orders` as o
JOIN `Target_Sql.order_ietms` as oi
ON o.order_id = oi.order_id
JOIN `Target_Sql. customers` as c
ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY avg_time_to_delivery DESC
LIMIT 5;

# Find the month on month no. of orders placed using different payment types.

SELECT
payment_type,
EXTRACT( YEAR FROM order_purchase_timestamp) as year,
EXTRACT( MONTH FROM order_purchase_timestamp) as month,
COUNT(DISTINCT o.order_id) as order_count
FROM `Target_Sql.orders` as o
INNER JOIN `Target_Sql.payments` as p
ON o.order_id = p.order_id
GROUP BY payment_type, year, month
ORDER BY payment_type, year, month;



# Count of orders based on the number of payment installments.

SELECT payment_installments,
COUNT( DISTINCT order_id ) as num_orders
FROM `Target_Sql.payments`
GROUP BY payment_installments;


