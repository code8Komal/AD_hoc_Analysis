-- 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

SELECT market from dim_customer
WHERE customer="Atliq Exclusive" and region="APAC"
GROUP BY market
ORDER BY market;
