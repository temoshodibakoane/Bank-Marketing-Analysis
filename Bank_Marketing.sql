SELECT *
FROM dbo.bank_additional_full;

SELECT y, COUNT(*) AS total
FROM dbo.bank_additional_full
GROUP BY y;

SELECT 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_clients
FROM dbo.bank_additional_full
GROUP BY 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END;

SELECT DISTINCT y FROM dbo.bank_additional_full;

ALTER TABLE dbo.bank_additional_full
ALTER COLUMN y VARCHAR(10);

-- 1️⃣ Add a new column for text values
ALTER TABLE bank_additional_full
ADD y_text VARCHAR(10);

-- 2️⃣ Convert existing bit values (1/0) or keep text as-is
UPDATE dbo.bank_additional_full
SET y = CASE 
                WHEN y IN ('1', 'yes', 'y') THEN 'yes'
                ELSE 'no'
             END;

-- 3️⃣ Drop the old column
ALTER TABLE bank_additional_full
DROP COLUMN y;

-- 4️⃣ Rename the new column
EXEC sp_rename 'bank_additional_full.y_text', 'y', 'COLUMN';

SELECT 
    job, 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(ROUND(
        (SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS DECIMAL(5,2)) AS subscription_rate
FROM dbo.bank_additional_full
GROUP BY job
ORDER BY subscription_rate DESC;

SELECT education, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS subscription_rate
FROM dbo.bank_additional_full
GROUP BY education
ORDER BY subscription_rate DESC;

SELECT month, 
       COUNT(*) AS total_calls,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS successful_calls,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM dbo.bank_additional_full
GROUP BY month
ORDER BY success_rate DESC;

SELECT 
    ROUND(AVG(duration), 2) AS avg_duration,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS total_yes,
    SUM(CASE WHEN y = 'no' THEN 1 ELSE 0 END) AS total_no
FROM dbo.bank_additional_full;

SELECT job, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS subscription_rate
FROM dbo.bank_additional_full
GROUP BY job;
















