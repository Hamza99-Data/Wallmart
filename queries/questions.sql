
--Adding some important cokumns
--day_of_day colum

SELECT
    time,
    (CASE
        WHEN "time"  BETWEEN '00:00:00' AND '11:59:59' THEN 'morning'
        WHEN "time"  BETWEEN '12:00:00' AND '16:59:59' THEN 'afternoon'
        ELSE 'evening'
    END
    ) AS time_of_day
FROM
    sales

--adding data to time of day column
UPDATE sales
SET time_of_day = (
    CASE
        WHEN "time"  BETWEEN '00:00:00' AND '11:59:59' THEN 'morning'
        WHEN "time"  BETWEEN '12:00:00' AND '16:59:59' THEN 'afternoon'
        ELSE 'evening'
    END
);

SELECT 
   date,
  TO_CHAR(date, 'Day') AS day_name
FROM
    sales

SELECT 
    time,
    time_of_day,
    day_name,
    month_name
FROM
    sales

--adding data to day name column
UPDATE sales
SET day_name =(
    TO_CHAR(date, 'Day')
);


--Creating time of day column
ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(20);

--creating day name column
ALTER TABLE sales
ADD COLUMN day_name VARCHAR(20);

--creating month_name column
ALTER TABLE sales
ADD COLUMN month_name VARCHAR(20);

--adding data to month name column

UPDATE sales
SET month_name = (
    TO_CHAR(date, 'month')
);


---business questions
--How many unique cities are there?

SELECT 
  DISTINCT city
FROM
    sales

--in which city is ech brach?

SELECT 
  DISTINCT city,
  branch
FROM
    sales

--How many unique product lines are there

SELECT 
    COUNT(DISTINCT product_line) AS product_line_total
FROM
    sales



--what is the most common payment method?:
SELECT 
   payment_method,
   COUNT(*) AS MCPM
FROM
    sales
GROUP BY
    payment_method
ORDER BY
    MCPM DESC;

--what is the most selling product line?

SELECT 
  product_line,
  COUNT(*) AS most_selling_pl
FROM
    sales
GROUP BY
    product_line
order by 
    most_selling_pl DESC;


--What is the total revenue by month?

SELECT 
 SUM(total) AS total_revenue,
 month_name
FROM
    sales
GROUP BY 
    month_name
ORDER BY 
    total_revenue DESC;


--WHAT MONTH had the largest cogs?

SELECT 
 month_name,
 SUM(cogs) AS total_cogs
FROM
    sales
GROUP BY
    month_name
ORDER BY
    total_cogs DESC;


--what product line had the largest revenue?

SELECT 
 product_line,
 SUM(total) AS total_rev
FROM
    sales
GROUP BY
    product_line
ORDER BY
    total_rev DESC;

--which city has the largest revenue?

SELECT 
    city,
    branch,
    SUM(total) AS total_rev
FROM
    sales
GROUP BY
    city,
    branch
ORDER BY
    total_rev DESC;

--WHAT PRODUCT LINE HAD THE LARGES vAT?

SELECT
    product_line,
   AVG(tax) AS avg_tax
FROM
    sales
GROUP BY
    product_line
ORDER BY
    avg_tax DESC;



-- which branch sold more product than avg product sold/

SELECT
    branch,
    SUM(quantity) product_sold
FROM
    sales
GROUP BY
    branch
HAVING 
     SUM(quantity) >  AVG(quantity)
ORDER BY
    product_sold DESC;


-- what is the most product line by gender?

SELECT
     product_line,
     gender,
    COUNT(gender) AS gender_cnt
FROM
    sales
GROUP BY
    product_line,
    gender
ORDER BY
    gender_cnt DESC;

--what is the avg rating for each product line?

SELECT
    product_line,
    ROUND(AVG(rating)::NUMERIC, 2) AS avg_ratings
FROM
    sales
GROUP BY
    product_line    
ORDER BY
    avg_ratings DESC;

--

--Fetch each product line and add a coulumn to it showing 'good', 'bd', good if its greater than average sales.


SELECT
    DISTINCT product_line,
    AVG(total)
FROM
    sales
GROUP BY
    product_line      

  

