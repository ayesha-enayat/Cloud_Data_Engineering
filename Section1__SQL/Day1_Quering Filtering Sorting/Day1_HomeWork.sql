-- ============================================
-- SQL Server — Class 1 Homework
-- BikeStores Sample Database
-- Topics: Querying · Sorting · Filtering · Set Operators
-- ============================================

-- Q1: List all brand names from the brands table.
select brand_name
from [production].[brands];


-- Q2: Show the product name and list price of all products,
-- sorted from most expensive to cheapest.
select product_name,list_price 
from [production].[products]
order by list_price DESC;


-- Q3: Find all customers who live in the state of New York (NY).
select (first_name || ' ' || last_name) AS Customers ,state
from [sales].[customers]
where state = 'NY'

-- Q4: Show only the top 5 most expensive products in the store.
select top 5  product_name,list_price
from [production].[products]
order by list_price DESC;

-- Q5: List all products with a price between $200 and $500,
-- sorted by price ascending.
select product_name,list_price
from [production].[products]
where list_price between 200 and 500
order by list_price ASC;



-- Q6: Find all customers whose last name starts with the letter 'S'.
select (first_name || ' ' || last_name ) AS CUTOMERS
from [sales].[customers]
where last_name like 'S%';


-- Q7: List all products that belong to:
-- category 6 (Mountain Bikes) OR category 7 (Road Bikes).
select product_name, category_id
from [production].[products]
where category_id in(6,7);



-- Q8: Show all orders that have NOT been shipped yet
-- (shipped_date is missing).
Select order_id, order_status, shipped_date
from [sales].[orders]
where shipped_date IS NULL;

-- Q9: Display:
-- product name,
-- brand ID,
-- and a computed column showing 15% off the list price
-- labeled as 'Sale Price'.
-- Q9: Display product name, brand ID, and sale price after 15% discount.

select product_name,brand_id,list_price * 0.85 AS [Sale Price]
from [production].[products];


-- Q10: Get a unique list of all cities where BikeStores customers live,
-- sorted alphabetically.
select distinct  city
from [sales].[customers]
order by city ASC;



-- Q11: List all staff members who are currently active (active = 1),
-- showing their full name and email.
select (first_name || ' '|| last_name) AS Full_Name,email
from [sales].[staffs]
where active = 1;

-- Q12: Using UNION:
-- Get a combined list of all cities from both customers and stores
-- (no duplicates), sorted A–Z.
select city
from [sales].[customers]

union 

select city 
from [sales].[stores]
order by city ASC;



-- Q13: Using EXCEPT:
-- Find product IDs that exist in order_items
-- but are NOT in the products table.
select product_id
from [sales].[order_items]
except 
select product_id
from [production].[products]



-- Q14: List all products from the year 2016
-- with a price greater than $1,500,
-- sorted by price descending.
select product_id,product_name,list_price,model_year
from [production].[products]
where model_year = 2016 and list_price > 1500
order by list_price DESC;

-- Q15 (BONUS): Using UNION ALL:
-- Show Trek (brand_id = 9) products from 2016
-- and Surly (brand_id = 8) products from 2017.
-- Include product name, brand, year, and price.
-- Order by year then price descending.
-- Q15 (BONUS): Using UNION ALL
-- Show Trek products from 2016 and Surly products from 2017.

select product_name,'Trek' AS brand_name,model_year,list_price
from [production].[products]
where brand_id = 9 and model_year = 2016

union all

select product_name,'Surly' AS brand_name, model_year,list_price
from [production].[products]
where brand_id = 8 and model_year = 2017
order by model_year ASC, list_price DESC;