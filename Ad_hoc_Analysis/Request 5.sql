/*5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost*/

SELECT MC.product_code,P.product,MC.manufacturing_cost
FROM fact_manufacturing_cost mc JOIN dim_product P
ON MC.product_code=P.product_code
WHERE manufacturing_cost
IN(
	SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost
    UNION
    SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost
	)
ORDER BY manufacturing_cost DESC;

SELECT MC.product_code, P.product, MC.manufacturing_cost
FROM fact_manufacturing_cost MC 
JOIN dim_product P ON MC.product_code = P.product_code
WHERE MC.manufacturing_cost IN (
    SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost WHERE cost_year BETWEEN 2018 AND 2021
    UNION
    SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost WHERE cost_year BETWEEN 2018 AND 2021
)
AND MC.cost_year BETWEEN 2018 AND 2021
ORDER BY MC.manufacturing_cost DESC;