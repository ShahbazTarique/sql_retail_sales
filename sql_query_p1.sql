-- SQL Retail sales analysis - P1

--Create Table
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales(
transactions_id INT
,sale_date DATE
,sale_time TIME
,customer_id INT
,gender VARCHAR(15)
,age INT
,category VARCHAR(15)
,quantity INT
,price_per_unit FLOAT
,cogs FLOAT
,total_sale FLOAT
);

select * from retail_sales

--Data CLeaning
select * from retail_sales
where transactions_id IS NULL

select * from retail_sales
where sale_date IS NULL

select * from retail_sales
where sale_time IS NULL

select * from retail_sales
where customer_id IS NULL

select * from retail_sales
where gender IS NULL

--NULL value in age
select * from retail_sales
where age IS NULL


select * from retail_sales
where category IS NULL

--NULL value in quantity
select * from retail_sales
where quantity IS NULL

--NULL value in price_per_unit
select * from retail_sales
where price_per_unit IS NULL

--NULL value in cogs
select * from retail_sales
where cogs IS NULL


--NULL value in cogs
select * from retail_sales
where total_sale IS NULL

select * from retail_sales
where 
total_sale IS NULL
or
price_per_unit IS NULL
or
category IS NULL
or
quantity IS NULL
or
transactions_id IS NULL
or
sale_date IS NULL
or
sale_time IS NULL
or
customer_id IS NULL
or
gender IS NULL

--Data Exploration
--how many sales we have?- 1997
-- How many unique customers we have?- 155
--How many unique category we have?- 3
select count(DISTINCT category) as total_sales from retail_sales

--Data Analysis and business key problems and answers

--1.Write a sql query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM 
retail_sales
WHERE sale_date = '2022-11-05'

--2. Write a SQL query to retrieve all transactions 
--where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from
retail_sales
where category = 'Clothing'
and quantity >= 4
and sale_date between '2022-11-01' and '2022-11-30'


--3. Write a SQL query to calculate the total sales (total_sale) for each category?
select category
,SUM(total_sale)
,COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

--4. Write a SQL query to find the average ageof customers who purchased items from the beauty category?
select 
category
,ROUND(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty'
group by 1

--5. Write a sql query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000

--6. Write a sql query to find the total number of transactions(transaction_id) made by each gender in each category.
select
gender,
category,
count(*)
from retail_sales
group by 1,2
order by 2
select * from retail_sales

--7. write a sql query to calculate the average sale for each month. Find out best selling month in each year
with rn as (
select
EXTRACT (YEAR FROM sale_date) AS year,
EXTRACT (MONTH FROM sale_date) AS month,
avg(total_sale) as avg_sale,
RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY avg(total_sale) DESC) as rank
from retail_sales
group by 1,2)

select * from rn
where rank =1 

--8.Write a sql query to find the top 5 customers based on the highest total_sales
select 
customer_id,
SUM(total_sale)
from retail_sales
group by 1
order by 2 desc
LIMIT 5

--9. Write a sql query to find the number of unique customers who purchased items from each category.
select
count(DISTINCT customer_id) as customers,
category
from retail_sales
group by 2

--10. Write a sql query to create each shift and number of orders (Example Morning <= 12, Afternoon between 12 and 17, Evening>17)
with hourly_sales as (
select *,
CASE 
WHEN EXTRACT (HOUR FROM sale_time) <= 12 THEN 'Morning'
WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 and 17 THEN 'Afternoon' 
ELSE 'Evening'
END as shift
from retail_sales)

select
shift,
count(*)
from hourly_sales
group by 1

