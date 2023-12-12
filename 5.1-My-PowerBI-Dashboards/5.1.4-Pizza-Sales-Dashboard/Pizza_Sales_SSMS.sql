
SELECT * from Pizza_DB.dbo.pizza_sales;

--A. QUERIES FOR KPIs

--1. Total Revenue: Sum of the total price of all pizza orders
SELECT SUM(total_price) AS Total_Revenue FROM Pizza_DB.dbo.pizza_sales

--2. Average Order Value: The average amount spent per order, 
--calculated by dividing the total revenue by the total number of orders
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM Pizza_DB.dbo.pizza_sales

--3. Total Pizza Sold: Sum of the quantitites of all pizza sold
SELECT SUM(quantity) AS Total_pizza_sold FROM Pizza_DB.dbo.pizza_sales

--4. Total Orders: Total number of orders placed
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM Pizza_DB.dbo.pizza_sales

--5. Average Pizzas per order: Total number of pizzas sold/Total number of orders
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM Pizza_DB.dbo.pizza_sales

--B. DAILY TREND FOR TOTAL ORDERS
--Creating a bar chart that displays the daily trend of total orders over specific time period.
--This chart will help us identify peak hours or period of high order intensity
--Note: DW in DATENAME() is for day of week
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM Pizza_DB.dbo.pizza_sales
GROUP BY DATENAME(DW, order_date)

--C. MONTHLY TREND FOR ORDERS
--Creating a line chart that illustrates the hourly trend of total orders throughout day.
--This chart will allow us to identify peak hours or periods of high order activity
select DATENAME(MONTH, order_date) as Month_Name, COUNT(DISTINCT order_id) as Total_Orders
from Pizza_DB.dbo.pizza_sales
GROUP BY DATENAME(MONTH, order_date)

--D. PERCENTAGE OF SALES BY PIZZA CATEGORY
--Create a pie chart that shows the distribution of sales across different pizza categories.
--This provide insights in to the popularity of various pizza categories and their contribution to overall sales.
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from Pizza_DB.dbo.pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_category

--E. PERCENTAGE OF SALES BY PIZZA SIZE
--Create a pie chart that represents the percentage of sales attributed to different pizza sizes.
--This helps us in understanding customer preferences for pizza size and their impact on sales.
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from Pizza_DB.dbo.pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--F. TOTAL PIZZAS SOLD BY PIZZA CATEGORY
--Create a funnel chart that presents the total number of pizzas sold for each pizza category.
--This chart will allow us to compare the sales performance of different pizza category.
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM Pizza_DB.dbo.pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--G. TOP 5 BEST SELLERS OF TOTAL PIZZAS BY REVENUE
--Create a bar chart highlighting the top 5 best-selling pizzas based on the total number of pizzas sold.
--This chart will help us identify the most popular pizza options.
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC


--H. BOTTOM 5 WORST SELLERS OF TOTAL PIZZAS BY REVENUE
--Create a bar chart showcasing the bottom 5 worst-selling pizzas based on the total number of pizzas sold.
--This chart will enable us to identify underperforming or less popular pizza options.
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--I. TOP 5 PIZZAS BY QUANTITY
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--J. BOTTOM 5 PIZZAS BY QUANTITY
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--K. TOP 5 PIZZAS BY TOTAL ORDERS
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--L. BOTTOM 5 PIZZAS BY TOTAL ORDERS
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC







