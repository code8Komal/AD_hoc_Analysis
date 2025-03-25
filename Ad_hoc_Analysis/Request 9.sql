/*9. Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel
gross_sales_mln
percentage*/
WITH CTE1 AS(
	SELECT C.channel,sum(FS.sold_quantity*G.gross_price) AS total_sales
	FROM fact_sales_monthly FS JOIN dim_customer C ON FS.customer_code=C.customer_code
								JOIN fact_gross_price G ON FS.product_code=G.product_code
	WHERE FS.fiscal_year=2021
	GROUP BY C.channel
	ORDER BY total_sales Desc
    
)

SELECT channel,
	ROUND(total_sales/1000000,2) as gross_sales_million,
    ROUND(total_sales/(SUM(total_sales) OVER())*100,2) as percentage
from CTE1;

