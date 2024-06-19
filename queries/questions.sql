


--How many unique product lines are there
SELECT 
    COUNT(DISTINCT product_line) AS product_line_total
FROM
    sales


--what is the most selling product line?
SELECT 
  product_line,
  COUNT(product_line) AS best_selling_product_line
FROM
    sales
GROUP BY
    product_line
order by 
    best_selling_product_line DESC;



--what is the most common payment method?:
SELECT 
   payment_method,
   COUNT(payment_method) AS pay_medium
FROM
    sales
GROUP BY
    payment_method
ORDER BY
   pay_medium DESC;


--what payment methods are preffered by each customer type?
SELECT 
 customer_type,
 payment_method,
 COUNT(payment_method) AS payment_medium_count
FROM
    sales
GROUP BY 
    customer_type,
    payment_method
ORDER BY 
    payment_medium_count DESC;


--what product line had the largest revenue?
SELECT 
 product_line,
 SUM(total) AS total_revenue
FROM
    sales
GROUP BY
    product_line
ORDER BY
    total_revenue DESC;


-- which branch sold more product than avg product sold/
SELECT
    branch,
    city,
    SUM(quantity) product_sold
FROM
    sales
GROUP BY
    branch,
    city
HAVING 
     SUM(quantity) >  AVG(quantity)
ORDER BY
    product_sold DESC;

--determing the sales made in each time of the day per weekday
SELECT 
    time_of_day,
    day_name,
    COUNT(time_of_day) AS sales_made
FROM
    sales
GROUP BY 
   time_of_day,
   day_name
ORDER BY 
    day_name ASC,
   sales_made DESC;


--What is the gender distribution per branch?**
SELECT 
    branch,
    gender,
    COUNT(gender) AS gender_distribution
FROM
    sales
GROUP BY 
    branch,
    gender
ORDER BY 
    gender_distribution DESC;


--*Which time of the day do customers give most ratings per branch
SELECT 
    time_of_day,
    branch,
    ROUND(AVG(rating)::NUMERIC, 2) ratings
FROM
    sales
GROUP BY 
   time_of_day,
   branch
ORDER BY 
   ratings DESC;

