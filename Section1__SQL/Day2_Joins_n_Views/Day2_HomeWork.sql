-- ============================================
-- SQL Server - JOINs Homework
-- BikeStores Sample Database
-- Topics: INNER JOIN, LEFT JOIN, CROSS JOIN, SELF JOIN, VIEWS
-- ============================================


-- Q1
-- Show all product names along with their brand name.
-- Sort by brand name, then by product name alphabetically.

SELECT
    B.brand_name,
    P.product_name
FROM [production].[brands] AS B
INNER JOIN [production].[products] AS P
    ON B.brand_id = P.brand_id
ORDER BY
    B.brand_name ASC,
    P.product_name ASC;


-- Q2
-- List all products with their category name and list price.
-- Sort by category name, then by price from cheapest to most expensive.

SELECT
    P.product_name,
    C.category_name,
    P.list_price
FROM [production].[products] AS P
INNER JOIN [production].[categories] AS C
    ON C.category_id = P.category_id
ORDER BY
    C.category_name ASC,
    P.list_price ASC;


-- Q3
-- Show all orders with the customer's full name and order date.
-- Sort by order date from newest to oldest.

SELECT
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    O.order_date
FROM [sales].[orders] AS O
INNER JOIN [sales].[customers] AS C
    ON C.customer_id = O.customer_id
ORDER BY
    O.order_date DESC;


-- Q4
-- Display each order item with product name, quantity, unit price,
-- and Line Total (quantity multiplied by list_price).
-- Sort by order ID.

SELECT
    OI.order_id,
    P.product_name,
    OI.quantity,
    OI.list_price,
    OI.quantity * OI.list_price AS [Line Total]
FROM [sales].[order_items] AS OI
INNER JOIN [production].[products] AS P
    ON P.product_id = OI.product_id
ORDER BY
    OI.order_id ASC;


-- Q5
-- Show each order with the store name and order date.
-- Sort by store name.

SELECT
    O.order_id,
    S.store_name,
    O.order_date
FROM [sales].[orders] AS O
INNER JOIN [sales].[stores] AS S
    ON S.store_id = O.store_id
ORDER BY
    S.store_name ASC;


-- Q6
-- Show each order with order ID, customer full name,
-- store name, and the staff member's full name.

SELECT
    O.order_id,
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    S.store_name,
    CONCAT(ST.first_name, ' ', ST.last_name) AS Staff_Name
FROM [sales].[orders] AS O
INNER JOIN [sales].[customers] AS C
    ON C.customer_id = O.customer_id
INNER JOIN [sales].[stores] AS S
    ON S.store_id = O.store_id
INNER JOIN [sales].[staffs] AS ST
    ON ST.staff_id = O.staff_id;


-- Q7
-- List all Trek products with category name and price.
-- Sort by price descending. Use JOIN, not brand_id directly.

SELECT
    P.product_name,
    B.brand_name,
    C.category_name,
    P.list_price
FROM [production].[products] AS P
INNER JOIN [production].[brands] AS B
    ON B.brand_id = P.brand_id
INNER JOIN [production].[categories] AS C
    ON C.category_id = P.category_id
WHERE
    B.brand_name = 'Trek'
ORDER BY
    P.list_price DESC;


-- Q8
-- Find customers from NY who have placed at least one order.
-- Show customer full name, city, and order date.
-- Use JOIN, not a subquery.

SELECT
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    C.city,
    O.order_date
FROM [sales].[customers] AS C
INNER JOIN [sales].[orders] AS O
    ON O.customer_id = C.customer_id
WHERE
    C.state = 'NY';


-- Q9
-- Show completed orders (order_status = 4) from Rowlett Bikes.
-- Display order ID, customer full name, and order date.

SELECT
    O.order_id,
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    O.order_date
FROM [sales].[orders] AS O
INNER JOIN [sales].[customers] AS C
    ON C.customer_id = O.customer_id
INNER JOIN [sales].[stores] AS S
    ON S.store_id = O.store_id
WHERE
    O.order_status = 4
    AND S.store_name = 'Rowlett Bikes';


-- Q10
-- List all customers and any orders they have placed.
-- Include customers who have never placed an order.
-- Order columns will be NULL when no order exists.
-- Sort by customer ID.

SELECT
    C.customer_id,
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    O.order_id,
    O.order_date
FROM [sales].[customers] AS C
LEFT JOIN [sales].[orders] AS O
    ON O.customer_id = C.customer_id
ORDER BY
    C.customer_id ASC;


-- Q11
-- Find customers who have never placed an order.
-- Show their full name and email.

SELECT
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    C.email
FROM [sales].[customers] AS C
LEFT JOIN [sales].[orders] AS O
    ON O.customer_id = C.customer_id
WHERE
    O.order_id IS NULL;


-- Q12
-- List all products and their stock quantity at every store.
-- Include product/store combinations with no stock record.
-- Show product name, store ID, and quantity.

SELECT
    P.product_name,
    S.store_id,
    ST.quantity
FROM [production].[products] AS P
CROSS JOIN [sales].[stores] AS S
LEFT JOIN [production].[stocks] AS ST
    ON ST.product_id = P.product_id
    AND ST.store_id = S.store_id
ORDER BY
    P.product_name ASC,
    S.store_id ASC;


-- Q13
-- Find products that have never been ordered.
-- Show product name and list price.

SELECT
    P.product_name,
    P.list_price
FROM [production].[products] AS P
LEFT JOIN [sales].[order_items] AS OI
    ON OI.product_id = P.product_id
WHERE
    OI.product_id IS NULL;


-- Q14
-- List each staff member with their manager's full name.
-- Staff with no manager must still appear with a NULL manager name.

SELECT
    CONCAT(ST.first_name, ' ', ST.last_name) AS Staff_Name,
    CONCAT(M.first_name, ' ', M.last_name) AS Manager_Name
FROM [sales].[staffs] AS ST
LEFT JOIN [sales].[staffs] AS M
    ON ST.manager_id = M.staff_id;


-- Q15
-- Create or update vw_bike_catalog.
-- Show product_name, brand_name, category_name, model_year,
-- and list_price. Then show products priced over $2,000,
-- sorted by price descending.

GO

CREATE OR ALTER VIEW [dbo].[vw_bike_catalog]
AS
SELECT
    P.product_name,
    B.brand_name,
    C.category_name,
    P.model_year,
    P.list_price
FROM [production].[products] AS P
INNER JOIN [production].[brands] AS B
    ON B.brand_id = P.brand_id
INNER JOIN [production].[categories] AS C
    ON C.category_id = P.category_id;

GO

SELECT
    product_name,
    brand_name,
    category_name,
    model_year,
    list_price
FROM [dbo].[vw_bike_catalog]
WHERE
    list_price > 2000
ORDER BY
    list_price DESC;


-- Q16
-- BONUS: Create or update vw_customer_orders.
-- Show customer full name, order_id, order_date, store_name,
-- and order_status. Then show orders for customers in New York,
-- sorted by order_date.

GO

CREATE OR ALTER VIEW [dbo].[vw_customer_orders]
AS
SELECT
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    C.city,
    O.order_id,
    O.order_date,
    S.store_name,
    O.order_status
FROM [sales].[customers] AS C
INNER JOIN [sales].[orders] AS O
    ON O.customer_id = C.customer_id
INNER JOIN [sales].[stores] AS S
    ON S.store_id = O.store_id;

GO

SELECT
    Customer_Name,
    city,
    order_id,
    order_date,
    store_name,
    order_status
FROM [dbo].[vw_customer_orders]
WHERE
    city = 'New York'
ORDER BY
    order_date ASC;



