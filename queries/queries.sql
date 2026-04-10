use ecommerce_db;
select * from customers; 
select * from orders; 
select * from order_items ; 
-- 1.Total number of orders
select count(order_id) from orders;

--  2. Total revenue (sum of price)
select sum(price) from order_items;	

-- 3. Total amount spent by each custome
CREATE VIEW customer_order_details AS
select customers.customer_id , orders.order_id , order_items.price  from customers
inner join orders on customers.customer_id = orders.customer_id   
inner join order_items on 	orders.order_id = order_items.order_id ; 
select * from customer_order_details; 
select customer_id ,sum(price) as total_spend from customer_order_details
group by customer_id ;

-- 4 Top 5 customers by total spending 
select customer_id ,sum(price) as total_spend from customer_order_details
group by customer_id  order by total_spend desc limit 5 ;

-- 5 Total revenue generated from each city
CREATE VIEW city_order_details AS
select customers.customer_id ,customers.customer_city , orders.order_id , order_items.price  from customers
inner join orders on customers.customer_id = orders.customer_id   
inner join order_items on 	orders.order_id = order_items.order_id ; 
select * from  city_order_details ; 
select customer_city ,sum(price) as total_spend from city_order_details
group by customer_city ;

--  6 Most sold product (highest number of sales) 
select product_id, count(price) from order_items group by product_id order by count(price) desc ; 

-- 7 Latest 5 orders (based on order date)
select * from orders order by order_purchase_timestamp desc  limit 5 ; 

--  8 Average order value
SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT orders.order_id, SUM(order_items.price) AS order_total
    FROM orders
    INNER JOIN order_items 
    ON orders.order_id = order_items.order_id
    GROUP BY orders.order_id
) AS order_summary;
-- 9 Customer with the highest number of orders 
select customer_id , count(order_id) from orders group by customer_id order by count(order_id) desc limit 5 ;

-- São Paulo state me kitni unique cities hain?
select * from customers where customer_state = 'sao paulo'