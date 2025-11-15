create database Project
use project

select* from retail_sales

Select COUNT(*) FROM Retail_Sales

--Data Cleaning
select*from Retail_Sales
where 
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id  is null
	or 
	gender is null
	or
	age is null
	or 
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null

delete Retail_Sales
where 
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id  is null
	or 
	gender is null
	or
	age is null
	or 
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null

-- Data Exploration

--How many sales we have
select count(*) as total_sales from Retail_Sales

--How many unique customers we have
select COUNT(distinct customer_id) as total_customer from Retail_Sales

--Category
select  distinct category from Retail_Sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select*from Retail_Sales where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

--method 1
select*from Retail_Sales
where
	category='Clothing'
and	
	quantiy>3 
and 
	sale_date >='2022-11-01' and sale_date<='2022-11-30'

--method 2
select*from Retail_Sales
where
	category='Clothing'
and	
	quantiy>3 
and 
	format(sale_date,'yyyy-MM')= '2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
	category,
	sum(total_sale)as total_sale,
	count(*) as total_orders
from 
	Retail_Sales
group by
	category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select
	avg(age) as Avg_age
from Retail_Sales
where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select transactions_id  from Retail_Sales
where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender, count(transactions_id) as total_transactions
from Retail_Sales
group by category,gender

 -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
 --Method 1( wrong logic bcz if avg_sale of year 2022 have 2 months > avg_sale of 2023 then output will be on 1st - 2022-month and 2nd - 2022-month)
 select top 2 * from
 (select 
	FORMAT(sale_date,'yyyy-MMMM')AS month_,
	round(avg(total_sale),2) as avg_sale
from Retail_Sales
group by FORMAT(sale_date,'yyyy-MMMM')) as sale
order by avg_sale desc

--METHOD 2 (CORRECT LOGIC)
SELECT 
       [year],
       [month],
       avg_sale
FROM 
(    
SELECT 
    YEAR(sale_date) AS [year],
    FORMAT(sale_date,'MMMM') AS [month],
    AVG(total_sale) AS avg_sale,
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM 
    retail_sales
GROUP BY 
    YEAR(sale_date),format(sale_date,'MMMM')
) AS t1
WHERE 
    rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select top 5
	customer_id ,
	sum(total_sale) as net_sale
from 
	Retail_Sales 
group by 
	customer_id 
order by
	sum(total_sale) desc

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select shift_,count(*) as number_of_orders from
(select *,
case
	when datepart(HOUR,sale_time)<=12 then 'Morning'
	when datepart(HOUR,sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
end as shift_
from Retail_Sales) as sale
group by shift_




select*from Retail_Sales


SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'retail_sales';


SELECT DATEPART(HOUR, sale_time) AS HourOnly FROM Retail_Sales;
SELECT DATEPART(HH, sale_time) AS HourOnly FROM Retail_Sales;
--The DATEPART(HOUR, sale_time) query works because DATEPART is a highly efficient, SQL Server-specific function designed to
--extract asingle integer part of a date/time value. It is robust and rarely returns NULL unless the input sale_time itself is NULL.


SELECT FORMAT(sale_time, 'HH') AS HourOnly from Retail_Sales
--The SELECT FORMAT(sale_time, 'HH') AS HourOnly from Retail_Sales query likely returns NULL because the FORMAT function is more complex and 
--sensitive to specific conditions that might be present in your data or how SQL Server handles the TIME data type.






