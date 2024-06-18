CREATE TABLE sales (
    invoice_id VARCHAR(50) NOT NULL PRIMARY KEY,
    branch VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    customer_type VARCHAR(50) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    tax REAL NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_per DOUBLE PRECISION  NOT NULL,
    gross_income DECIMAL(12, 4) NOT NULL,
    rating REAL NOT NULL
);

