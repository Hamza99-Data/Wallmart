
--Creating time of day column
ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(20);

--creating day name column
ALTER TABLE sales
ADD COLUMN day_name VARCHAR(20);

--creating month_name column
ALTER TABLE sales
ADD COLUMN month_name VARCHAR(20);

--adding data to time of day column
UPDATE sales
SET time_of_day = (
    CASE
        WHEN "time"  BETWEEN '00:00:00' AND '11:59:59' THEN 'morning'
        WHEN "time"  BETWEEN '12:00:00' AND '16:59:59' THEN 'afternoon'
        ELSE 'evening'
    END
);

--adding data to day name column
UPDATE sales
SET day_name =(
    TO_CHAR(date, 'Day')
);

--adding data to month name column
UPDATE sales
SET month_name = (
    TO_CHAR(date, 'month')
);