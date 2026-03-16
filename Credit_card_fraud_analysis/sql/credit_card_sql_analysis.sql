
-- Total transactions in dataset
SELECT COUNT(*) AS total_transactions
FROM transactions;

-- Fraud vs non fraud transaction count
SELECT 
    is_fraud,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY is_fraud;

-- Percentage of fraudulent transactions
SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) 
        / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM transactions;

-- Total fraud transaction amount
SELECT 
    SUM(amt) AS total_fraud_amount
FROM transactions
WHERE is_fraud = 1;

-- Categories with highest fraud
SELECT 
    category,
    COUNT(*) AS fraud_count
FROM transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY fraud_count DESC
LIMIT 10;

-- Fraud rate per category
SELECT 
    category,
    COUNT(*) FILTER (WHERE is_fraud = 1) * 100.0 / COUNT(*) AS fraud_rate
FROM transactions
GROUP BY category
ORDER BY fraud_rate DESC;

-- Fraud by state
SELECT 
    state,
    COUNT(*) AS fraud_count
FROM transactions
WHERE is_fraud = 1
GROUP BY state
ORDER BY fraud_count DESC
LIMIT 10;

-- Fraud distribution by hour
SELECT 
    EXTRACT(HOUR FROM trans_date_trans_time) AS transaction_hour,
    COUNT(*) AS fraud_count
FROM transactions
WHERE is_fraud = 1
GROUP BY transaction_hour
ORDER BY fraud_count DESC;

-- Average transaction amount comparison
SELECT 
    is_fraud,
    AVG(amt) AS avg_transaction_amount
FROM transactions
GROUP BY is_fraud;

-- Average distance between customer and merchant
SELECT 
    is_fraud,
    AVG(
        SQRT(
            POWER(lat - merch_lat, 2) +
            POWER(long - merch_long, 2)
        )
    ) AS avg_distance
FROM transactions
GROUP BY is_fraud;

