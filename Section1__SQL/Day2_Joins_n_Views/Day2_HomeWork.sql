-- Q1
-- Show all product names along with their brand name. Sort by brand name, then by product name alphabetically.
select B.brand_name,P.product_name
from [production].[brands]  B
inner join 
[production].[products]  P
on B.brand_id = P.brand_id
order by 
B.brand_name ASC,
P.product_name ASC;


-- Q2
-- List all products with their category name and list price. Sort by category name, then by price from cheapest to most expensive.
select P.product_name,C.category_name,P.list_price
from [production].[products] P
inner join
[production].[categories] C
on C.category_id=P.category_id
order by 
category_name ASC,
list_price ASC;


-- Q3
-- Show all orders with the customer's full name and order date. Sort by order date from newest to oldest.
select (C.first_name || ' ' ||  C.last_name) as Customer_name, O.order_date
from [sales].[orders] O
inner join
[sales].[customers] C
on C.customer_id= O.customer_id
order by O.order_date DESC;


-- Q4
-- Display each order item with the product name, quantity, unit price, and a computed column called "Line Total" (quantity × list_price). Sort by order ID.


-- Q5
-- Show each order along with the store name where it was placed and the order date. Sort by store name.

-- Q6
-- Show each order with: order ID, customer full name, store name, and the staff member's full name who handled it.

-- Q7
-- List all products from the brand "Trek" along with their category name and price. Sort by price descending. (Use JOIN — do NOT filter by brand_id directly.)

-- Q8
-- Find all customers from the state of "NY" who have placed at least one order. Show customer full name, city, and order date. (Use JOIN — do not use a subquery.)


-- Q9
-- Show all completed orders (order_status = 4) from the store "Rowlett Bikes". Display order ID, customer full name, and order date.


-- Q10
-- List ALL customers and any orders they have placed. Include customers who have never placed an order (show NULL for order columns). Sort by customer ID.


-- Q11
-- Find all customers who have NEVER placed an order. Show their full name and email.

-- Q12
-- List all products and their stock quantity at every store. Include products that have NO stock record at all. Show product name, store ID, and quantity.


-- Q13
-- Find all products that have NEVER been ordered (no record in order_items). Show product name and list price.


-- Q14
-- List each staff member along with the full name of their manager. Staff with no manager (top-level) should still appear — show NULL for manager name.


-- Q15
-- Create a view called vw_bike_catalog that shows product_name, brand_name, category_name, model_year, and list_price. Then query it to show only products priced over $2,000, sorted by price descending.


-- Q16
-- BONUS: Create a view called vw_customer_orders showing: customer full name, order_id, order_date, store_name, and order_status. Then query it to show only orders where the customer city is "New York", sorted by order_date.