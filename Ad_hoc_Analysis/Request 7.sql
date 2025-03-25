/* 7 Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount*/

SELECT CONCAT(MONTHNAME(FS.date), ' (', YEAR(FS.date), ')') AS 'Month', FS.fiscal_year,
       ROUND(SUM(G.gross_price*FS.sold_quantity), 2) AS Gross_sales_Amount
FROM fact_sales_monthly FS JOIN dim_customer C ON FS.customer_code = C.customer_code
						   JOIN fact_gross_price G ON FS.product_code = G.product_code
WHERE C.customer = 'Atliq Exclusive'
GROUP BY  Month, FS.fiscal_year 
ORDER BY FS.fiscal_year ;

WITH cte1 AS (
    SELECT customer,
		monthname(s.date) AS A ,
		year(s.date) AS B, 
		s.fiscal_year,
		(s.sold_quantity * g.gross_price)  AS C
 FROM fact_sales_monthly s 
 JOIN fact_gross_price g ON s.product_code = g.product_code
 JOIN dim_customer c ON s.customer_code=c.customer_code
 WHERE customer="Atliq exclusive"
)
SELECT 
	A AS Month,
    B as Year,
    round(sum(C),2) as Gross_sales_amt
from cte1
GROUP BY Month,YEAR
ORDER BY Year


with cte1 as (
	select 
		monthname(s.date) as A,
        year(s.date) as B,
        s.fiscal_year,
        (g.gross_price*s.sold_quantity) as C
	from fact_sales_monthly s 
    join fact_gross_price g on s.product_code = g.product_code
    join dim_customer c on s.customer_code = c.customer_code
    where c.customer = 'Atliq Exclusive')

select 
	A as month,
    B as Year,
    round(sum(C),2) as Gross_sales_amt
from cte1
group by month, Year 
order by year;