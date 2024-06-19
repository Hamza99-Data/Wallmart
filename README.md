# Introduction
To identify opportunities to improve and optimized walmart sales strategies, it is important to explore sales data to understand top performing products and branches, sales trend over different time periods, customer behaciour and others.

## Quick access to files: 
Get all the queries, images, and data in this here via their respective folders in the following links:

* [Database and table creation, and excel file upload](/creation/)
* [Queies used to add new columns and updating it](/adding_columns/)
* [All queries used to answer business questions](/queries/)
* [Images from excel analysis](/Images/)
* [The dataset used in this project](/data/)

## Objectives 
This project seeks to explore walmart sales data to understand factors affecting low sales or non-performing product lines.

We seek to provide answers to the following business questions:
1. How many unique product lines are there?
2. what is the most selling product line?
3. what is the most common payment method?
3. what payment methods are preferred by each customer type?
4. what product line had the largest revenue?
5. which brach sold more product than average product sold?
6. determing the sales made in each time of the day per weekday
7. What is the gender distribution per branch?
8. Which time of the day do customers give most ratings per branch?

# Background
The dataset was obtain from [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting),  This dataset contains sales transactions from a three different branches of Walmart, and have 17 columns and 1000 rows.

# Method
1. **Creating database and uploading the data:** first, our walmart database is created, then a sales table is also created by setting **not null** for each field to ensure that there are no null values in the walmart database.
find all the quries used in this step [here](/creation/),
2. **Generating new columns:** this is to help add new columns from the existing ones that we will need in our analysis. the three new columns that were added are: **time_of_ day**- this column was ued to the part of the day day in which least or most sales are made. **day_name**-this column contains extracted days of the week on which transaction took place. and **month_name**-also contains the extracted month of the year on which the given transaction took place.
The code used in this step can be found [here](/adding_columns/),

# Tools used
* **SQL**: The main tool of my analysis, presenting me with all the tools to query and retrieve all the vital details form the database.

* **Excel** used to further analyzed results genrated from sql to create graphs and charts.

* **PostgreSQL**: The database management system, robust in handling the huge job postings data.

* **Visual Studio Code**: My favourite code editor for executing sql queries.

* **Git & GitHub**: To help me share this project and it's analysis, and also keep a track of all changes.

# Analysis
Exploratory data analysis is done to find solutions to the business questions. In the following paragraphs, we explore the queries that appropriately answers each businees questions.
 *  **How many unique product lines are there?**

We use the select distinct function to perform this activity. this query below was used to answer this question 

```sql
SELECT 
    COUNT(DISTINCT product_line) AS product_line_total
FROM
    sales
```    

and the resulting figure is 6, indicating that there are 6 different product lines.

*  **what is the most selling product line?**

its important to identify both best selling product line and the least performing ones in order to institute appropriate strategies to improve upon products that are not doing well in the market, and also ensure a sustained growth for the ones performing better.
we solved this problem with the query below:

```sql
SELECT 
  product_line,
  COUNT(product_line) AS best_selling_product_line
FROM
    sales
GROUP BY
    product_line
order by 
    most_selling_pl DESC;
```
the resulting table in **Table 1** below indicates that Fashion accessories leads as the best selling product line.

**Table 1**: Product lines and how thery are selling
| product line              |best lselling product line   |
| --- | --- |
|Fashion accessories          |178     |
|Food and beverages           |174     |
|Electronic accessories       | 170    |
|Sports and travel             |166     |
|Home and lifestyle           |160     |
|Health and beauty             |152     |


![Most selling product line](<Images/best selling product line.jpg>)
**Figure 1**: Bar chart showing how each product line is selling. this was generated with excel using the query result in Table 1 above.

* **what is the most common payment method?**
Customers are more likely to choose a merchant that offers a convenient payment method that suits their needs. By offering more payment options than competitors, businesses can differentiate themselves and attract more customers. Here we evaluate the performance of each payment method offered by walmart to understand which method customers tend to use the most and how to improve customers experience through such payment medium.

```sql
SELECT 
   payment_method,
   COUNT(payment_method) AS pay_medium
FROM
    sales
GROUP BY
    payment_method
ORDER BY
   pay_medium DESC;
```
Ewallet has a narrow lead as the most preferred payment method closely followed by cash payment according to results from above query which is contained in **Table 2** below.

**Table 2**: showing most common payment method

| payment method    |pay medium     |
| ---               | ---           |
|Ewallet               |345     |
|Cash                  | 344    |
|Credit card            |311     |

* **what payment methods are preferred by each customer type?** 
We found out that normal customers prefer to use Ewallet and cash the most as contained in Table 3.

```sql
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
```
**Table 3**: Payment methods associated with customer type.
|customer type     |payment method     |count of payment method     |
| --- | --- | --- |
|Normal               |Ewallet              |184     |
|Normal               |cash                |  176     |
|Member               |Credit card          |172     |
|Member               |cash                 |168     |
|Member               |Ewallet               |161     |
|Normal               |Credit card            |139     |

* **what product line had the largest revenue?** the query below was use to answer this question producing the results in **Table 4**. the table clearly indicates thAt Food and becerages generated the highest revenue for walmart within the data capture period.

```sql
SELECT 
 product_line,
 SUM(total) AS total_revenue
FROM
    sales
GROUP BY
    product_line
ORDER BY
    total_revenue DESC;
```
**Table 4**: Product lines and their respective revenue.

|product line               |total revenue     |
| --- | --- |
|Food and beverages          |56144.96     |
|Sports and travel            |55123.00     |
|Electronic accessories       |54337.64     |
|Fashion accessories           |54306.03     |
|Home and lifestyle             |53861.96     |
|Health and beauty               |49193.84     |


![Product line and their revenues](<Images/product lines and their respective revenue.jpg>)
**Figure 2:** indicates each product line and their respective revenues also generated with excel.

* **which brach sold more product than average product sold?** We perform this operation to determine which branch is doing better and which needs more attention and assistance to increase their sales. Branch 'A' within Yangon city had the highest number of sales above average. the details are contained in **Table 5**.

**Table 5**: :Branch and their sales performance.
|branch     |city     |product sold     |
| --- | --- | --- |
| A    |Yangon     |1859     |
| B    |Naypyitaw     |1831     |
| C    |Mandalay     |1820     |

sql query
```sql
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
```

* **determing the sales made in each time of the day per weekday** identifying this will give us an insight into what customers experience feels like in each time of the day according to our time of day column having morning, afternoon, and evening. we could make valuable insight as to when customers like to shop and why so.
This analysis shows that the afternoons provide a good atmosphere for customers at walmart to shop.

sql query
```sql
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
```


* **What is the gender distribution per branch?**
To determine the gender distribution per branch, we use the below sql query:

sql query

```sql
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
```
the results analyzed further in excel and presented in **Figure 3** indicates that Males in branch A leads the distribution.

![Gender distribution](<Images/Gender distribution per branch.jpg>)
**Figure 3:** Gender distribution per branch


* **Which time of the day do customers give most ratings per branch?**
The time at which customers prefer to rate transactions per branch was explore using the sql query below:

The results turns out that branch C has the highest ratings in the evening and branch B has the lowest ratings in the evening. the result is contained in **Figure 4**

sql query

```sql
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
```

![Trend of customers ratings over time of day](<Images/Trend of customers rating over time of day.jpg>)
**Figure 4:** shows whcih time of the day that customers give most ratings per branch.

# Knowledge Acquired
* **Business Insight**: I have gained a great deal of knowledge in applying sql queries to business data that have given me great understanding of deriving great solutions to pressing business issues. 

* **New sql insight**:: I updated my sql knowledge by learning  that by default, ROUND function does not accept a double precision value directly with a second argument specifying the number of decimal places. Hence, to pass the result of functions like the AVG function to the ROUND fucntion, you need to cast the result of AVG to numeric before applying the ROUND function.

# Conclusion
The following conclusions are drawn at the end of the analysis:

* There are six different product lines at the time of the analysis.
* With a lead of 178, Fashion accessories is the product line that is selling faster.
* Most customers uses the Eqalet as their preffered payment method closely followed by cash payment.
* though Fashion accessories is the best selling product line, Food and beverages has the largest revenue among the product lines with total revenue of $56144.96