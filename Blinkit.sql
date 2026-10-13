create database blinkit;
use blinkit;

-- creating the table for blinkit
CREATE TABLE blinkit(
    order_id VARCHAR(20) PRIMARY KEY,
    order_timestamp DATETIME NOT NULL,
    order_date DATE NOT NULL,
    order_year SMALLINT NOT NULL,
    order_month TINYINT NOT NULL,
    order_month_name VARCHAR(15) NOT NULL,
    order_day_of_week VARCHAR(10) NOT NULL,
    order_hour TINYINT NOT NULL,
    user_id VARCHAR(20) NOT NULL,
    user_tier VARCHAR(20) NOT NULL,
    store_id VARCHAR(20) NOT NULL,
    store_city VARCHAR(50) NOT NULL,
    store_zone VARCHAR(20) NOT NULL,
    customer_pincode INT NOT NULL,
    delivery_slot VARCHAR(30) NOT NULL,
    platform VARCHAR(20) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    cancellation_return_reason VARCHAR(50) NULL,
    num_items_ordered SMALLINT NOT NULL,
    total_qty SMALLINT NOT NULL,
    item_names_sample VARCHAR(255) NOT NULL,
    mrp_total DECIMAL(12,2) NOT NULL,
    product_discount DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    promo_code VARCHAR(20) NULL,
    promo_discount DECIMAL(12,2) NOT NULL,
    delivery_fee DECIMAL(10,2) NOT NULL,
    tip DECIMAL(10,2) NOT NULL,
    cashback_earned DECIMAL(10,2) NOT NULL,
    grand_total DECIMAL(12,2) NOT NULL,
    delivery_time_mins SMALLINT NOT NULL,
    order_rating TINYINT NOT NULL,
    is_first_order TINYINT(1) NOT NULL,
    is_reorder TINYINT(1) NOT NULL,
    is_express_eligible TINYINT(1) NOT NULL,
    gstn_applied TINYINT(1) NOT NULL
);

set global local_infile=1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
drop table blinkit;
Truncate table blinkit;

select * from blinkit limit 100;

SELECT COUNT(*) AS total_rows
FROM blinkit;

-- loading blinkit 2022 data 
LOAD DATA LOCAL INFILE "C:/AccioJob/SQL/Blinkit/N/blinkit_orders_2022.csv"
INTO TABLE blinkit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- loading blinkit 2023 data
LOAD DATA LOCAL INFILE "C:/AccioJob/SQL/Blinkit/N/blinkit_orders_2023.csv"
INTO TABLE blinkit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- loading blinkit 2024 data
LOAD DATA LOCAL INFILE "C:/AccioJob/SQL/Blinkit/N/blinkit_orders_2024.csv"
INTO TABLE blinkit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- loading blinkit 2025 data part 1
LOAD DATA LOCAL INFILE "C:/AccioJob/SQL/Blinkit/N/blinkit_orders_2025_part1.csv"
INTO TABLE blinkit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- loading blinkit 2025 data part 2
 LOAD DATA LOCAL INFILE "C:/AccioJob/SQL/Blinkit/N/blinkit_orders_2025_part2.csv"
INTO TABLE blinkit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
 
 -- loading blinkit 2026 data
 LOAD DATA LOCAL INFILE "C:/AccioJob/SQL/Blinkit/N/blinkit_orders_2026.csv"
INTO TABLE blinkit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
 
select * from blinkit
where order_year=2025
limit 100;

select order_year, count(*) from blinkit group by order_year;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 1. Overall Business Performance
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT user_id) AS total_customers,
    SUM(grand_total) AS total_revenue,
    ROUND(AVG(grand_total), 2) AS avg_order_value,
    ROUND(AVG(total_qty), 2) AS avg_items_per_order
FROM blinkit
WHERE order_status = "Delivered";

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 2. Year-over-year revenue and order growth 
WITH yearly AS (
    SELECT
        order_year,
        COUNT(*) AS total_orders,
        SUM(grand_total) AS revenue,
        AVG(grand_total) AS avg_order_value
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY order_year
)
SELECT
    order_year,
    total_orders,
    ROUND(revenue, 2) AS revenue,
    ROUND(avg_order_value, 2) AS avg_order_value,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY order_year))
        / NULLIF(LAG(revenue) OVER (ORDER BY order_year), 0) * 100,
        2
    ) AS revenue_growth_pct
FROM yearly
ORDER BY order_year;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 3. Monthly Revenue trend and Seasonal Performance
WITH monthly AS (
    SELECT
        order_year,
        order_month,
        order_month_name,
        COUNT(*) AS total_orders,
        SUM(grand_total) AS revenue
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY
        order_year,
        order_month,
        order_month_name
)
SELECT
    order_year,
    order_month,
    order_month_name,
    total_orders,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY order_year, order_month))
        / NULLIF(LAG(revenue) OVER (ORDER BY order_year, order_month), 0) * 100,
        2
    ) AS mom_growth_pct
FROM monthly
ORDER BY order_year, order_month;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 4. Top 10 stores by revenue
SELECT
    store_id,
    store_city,
    store_zone,
    COUNT(*) AS total_orders,
    ROUND(SUM(grand_total), 2) AS total_revenue,
    ROUND(AVG(grand_total), 2) AS avg_order_value
FROM blinkit
WHERE order_status = "Delivered"
GROUP BY
    store_id,
    store_city,
    store_zone
ORDER BY total_revenue DESC
LIMIT 10;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 5. Store performance Ranking within each City 
WITH store_performance AS (
    SELECT
        store_city,
        store_id,
        COUNT(*) AS total_orders,
        SUM(grand_total) AS revenue
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY store_city, store_id
)
SELECT
    store_city,
    store_id,
    total_orders,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        PARTITION BY store_city
        ORDER BY revenue DESC
    ) AS city_rank
FROM store_performance
ORDER BY store_city, city_rank;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 6. High-Value customers
WITH customer_spend AS (
    SELECT
        user_id,
        COUNT(*) AS total_orders,
        SUM(grand_total) AS total_spend
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY user_id
)
SELECT
    user_id,
    total_orders,
    ROUND(total_spend, 2) AS total_spend,
    CASE
        WHEN total_spend >= 50000 THEN "VIP"
        WHEN total_spend >= 25000 THEN "High Value"
        WHEN total_spend >= 10000 THEN "Medium Value"
        ELSE "Low Value"
    END AS customer_segment
FROM customer_spend
ORDER BY total_spend DESC;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 7. Customer Tier Performance
SELECT
    user_tier,
    COUNT(DISTINCT user_id) AS customers,
    COUNT(*) AS total_orders,
    ROUND(SUM(grand_total), 2) AS revenue,
    ROUND(AVG(grand_total), 2) AS avg_order_value,
    ROUND(
        COUNT(*) * 1.0 / COUNT(DISTINCT user_id),
        2
    ) AS orders_per_customer
FROM blinkit
WHERE order_status = "Delivered"
GROUP BY user_tier
ORDER BY revenue DESC;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 8. Reorder Rate by Customer Tier
SELECT
    user_tier,
    COUNT(*) AS total_orders,
    SUM(is_reorder) AS reorder_orders,
    ROUND(
        SUM(is_reorder) * 100.0 / COUNT(*),
        2
    ) AS reorder_rate_pct
FROM blinkit
GROUP BY user_tier
ORDER BY reorder_rate_pct DESC;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 9. First-time VS Repeat customers revenue
SELECT
    CASE
        WHEN is_first_order = 1 THEN "First Order"
        ELSE "Repeat Order"
    END AS customer_type,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT user_id) AS customers,
    ROUND(SUM(grand_total), 2) AS revenue,
    ROUND(AVG(grand_total), 2) AS avg_order_value
FROM blinkit
WHERE order_status = "Delivered"
GROUP BY customer_type;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 10. Cancellation & Return Rate by Store
SELECT
    store_id,
    store_city,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN order_status <> "Delivered" THEN 1
            ELSE 0
        END
    ) AS failed_orders,
    ROUND(
        SUM(
            CASE
                WHEN order_status <> "Delivered" THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS failure_rate_pct
FROM blinkit
GROUP BY store_id, store_city
HAVING COUNT(*) >= 100
ORDER BY failure_rate_pct DESC;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 11. Analyze Reasons Behind Cancellations/Returns
SELECT
    cancellation_return_reason,
    COUNT(*) AS affected_orders,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_failed_orders
FROM blinkit
WHERE order_status <> "Delivered" and cancellation_return_reason <> "Not returned"
GROUP BY cancellation_return_reason
ORDER BY affected_orders DESC;


/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 12. Delivery Slot vs Customer Satisfaction
SELECT
    delivery_slot,
    COUNT(*) AS total_orders,
    ROUND(AVG(delivery_time_mins), 2) AS avg_delivery_time,
    ROUND(AVG(order_rating), 2) AS avg_rating
FROM blinkit
WHERE order_status = "Delivered"
GROUP BY delivery_slot
ORDER BY avg_delivery_time;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 13. Express Eligibility vs Actual Delivery Performance
SELECT
    is_express_eligible,
    COUNT(*) AS total_orders,
    ROUND(AVG(delivery_time_mins), 2) AS avg_delivery_time,
    ROUND(AVG(order_rating), 2) AS avg_rating,
    ROUND(AVG(grand_total), 2) AS avg_order_value
FROM blinkit
WHERE order_status = "Delivered"
GROUP BY is_express_eligible;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 14. Identify Stores with Poor Delivery Efficiency
WITH store_metrics AS (
    SELECT
        store_id,
        store_city,
        COUNT(*) AS total_orders,
        AVG(delivery_time_mins) AS avg_delivery_time,
        AVG(order_rating) AS avg_rating
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY store_id, store_city
),
ranked AS (
    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY total_orders
        ) AS volume_quartile,
        NTILE(4) OVER (
            ORDER BY avg_delivery_time
        ) AS delivery_quartile
    FROM store_metrics
)
SELECT
    store_id,
    store_city,
    total_orders,
    ROUND(avg_delivery_time, 2) AS avg_delivery_time,
    ROUND(avg_rating, 2) AS avg_rating
FROM ranked
WHERE volume_quartile = 4
  AND delivery_quartile = 4
ORDER BY avg_delivery_time DESC;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 15. Promotion Effectiveness
SELECT
    CASE
        WHEN promo_code = 'Not used' OR promo_code IS NULL
            THEN 'No Promotion'
        ELSE 'Promotion Used'
    END AS promo_status,

    COUNT(*) AS total_orders,
    ROUND(AVG(grand_total), 2) AS avg_order_value,
    ROUND(AVG(promo_discount), 2) AS avg_promo_discount,
    ROUND(AVG(total_qty), 2) AS avg_items,
    ROUND(SUM(grand_total), 2) AS total_revenue
FROM blinkit
WHERE order_status = "Delivered"
GROUP BY promo_status;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 16. Rank Promo Codes by Revenue Contribution
WITH promo_data AS (
    SELECT
        promo_code,
        COUNT(*) AS orders,
        SUM(grand_total) AS revenue,
        SUM(promo_discount) AS total_discount
    FROM blinkit
    WHERE order_status = "Delivered"
      AND promo_code <> "Not used"
      AND promo_code IS NOT NULL
    GROUP BY promo_code
)
SELECT
    promo_code,
    orders,
    ROUND(revenue, 2) AS revenue,
    ROUND(total_discount, 2) AS total_discount,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_contribution_pct,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM promo_data
ORDER BY revenue_rank;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 17. Customer Cohort / Retention Analysis
WITH customer_first_order AS (
    SELECT
        user_id,
        MIN(order_date) AS first_order_date
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY user_id
),
customer_orders AS (
    SELECT 
		DISTINCT b.user_id,
        DATE_FORMAT(f.first_order_date, '%Y-%m') AS cohort_month,
        TIMESTAMPDIFF(
            MONTH,
            f.first_order_date,
            b.order_date
        ) AS months_since_first_order
    FROM blinkit b
    JOIN customer_first_order f
        ON b.user_id = f.user_id
    WHERE b.order_status = "Delivered"
)
SELECT
    cohort_month,
    months_since_first_order,
    COUNT(DISTINCT user_id) AS active_customers
FROM customer_orders
GROUP BY
    cohort_month,
    months_since_first_order
ORDER BY
    cohort_month,
    months_since_first_order;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 18. Identify Customers at Risk of Churn
WITH customer_activity AS (
    SELECT
        user_id,
        COUNT(*) AS total_orders,
        MAX(order_date) AS last_order_date,
        SUM(grand_total) AS lifetime_value
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY user_id
),
overall AS (
    SELECT MAX(order_date) AS latest_date
    FROM blinkit
)
SELECT
    c.user_id,
    c.total_orders,
    c.last_order_date,
    DATEDIFF(o.latest_date, c.last_order_date) AS days_since_last_order,
    ROUND(c.lifetime_value, 2) AS lifetime_value
FROM customer_activity c
CROSS JOIN overall o
WHERE c.total_orders >= 5
  AND DATEDIFF(o.latest_date, c.last_order_date) >= 60
ORDER BY lifetime_value DESC;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 19. Revenue Concentration — Are We Too Dependent on a Few Customers?
WITH customer_revenue AS (
    SELECT
        user_id,
        SUM(grand_total) AS revenue
    FROM blinkit
    WHERE order_status = "Delivered"
    GROUP BY user_id
),
ranked AS (
    SELECT
        user_id,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
        ) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue
    FROM customer_revenue
)
SELECT
    user_id,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        cumulative_revenue * 100.0 / total_revenue,
        2
    ) AS cumulative_revenue_pct
FROM ranked
ORDER BY revenue DESC;

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 20. Identify Operationally Concerning Stores
WITH store_metrics AS (
    SELECT
        store_id,
        store_city,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN order_status <> "Delivered"
                THEN 1 ELSE 0
            END
        ) AS failed_orders,
        AVG(
            CASE
                WHEN order_status = "Delivered"
                THEN delivery_time_mins
            END
        ) AS avg_delivery_time,
        AVG(
            CASE
                WHEN order_status = "Delivered"
                THEN order_rating
            END
        ) AS avg_rating
    FROM blinkit
    GROUP BY store_id, store_city
),
scored AS (
    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY total_orders
        ) AS volume_score,
        NTILE(4) OVER (
            ORDER BY
                failed_orders * 1.0 / NULLIF(total_orders, 0)
        ) AS failure_score,
        NTILE(4) OVER (
            ORDER BY avg_delivery_time
        ) AS delivery_score,
        NTILE(4) OVER (
            ORDER BY avg_rating DESC
        ) AS rating_score
    FROM store_metrics
)
SELECT
    store_id,
    store_city,
    total_orders,
    ROUND(
        failed_orders * 100.0 / NULLIF(total_orders, 0),
        2
    ) AS failure_rate_pct,
    ROUND(avg_delivery_time, 2) AS avg_delivery_time,
    ROUND(avg_rating, 2) AS avg_rating,
    volume_score,
    failure_score,
    delivery_score,
    rating_score,
    (
        volume_score +
        failure_score +
        delivery_score +
        rating_score
    ) AS operational_risk_score
FROM scored
WHERE total_orders >= 5000
ORDER BY operational_risk_score DESC; 	

/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- 21. Top stores based on ratings
select 
	store_id,
    store_city,
    AVG(
		CASE
			WHEN order_status = 'Delivered'
			THEN order_rating
		END
	) AS avg_rating
from blinkit
group by store_id, store_city
order by avg_rating desc;