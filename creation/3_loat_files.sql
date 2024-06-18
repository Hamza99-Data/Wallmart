
COPY sales
FROM 'E:\Wallmart\WalmartSalesData.csv.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');