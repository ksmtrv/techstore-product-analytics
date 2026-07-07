/*
==================================================
TechStore Product Analytics

Автор: <Смотрова Кристина>

Описание:
SQL-запросы для анализа интернет-магазина TechStore.

==================================================
*/

--------------------------------------------------
-- Общее количество пользователей
--------------------------------------------------

SELECT COUNT(*) AS total_users
FROM users;

--------------------------------------------------
-- Количество заказов
--------------------------------------------------

SELECT COUNT(*) AS total_orders
FROM orders;

--------------------------------------------------
-- Общая выручка
--------------------------------------------------

SELECT
    SUM(total_amount) AS revenue
FROM orders
WHERE status IN ('paid', 'delivered');

--------------------------------------------------
-- Средний чек
--------------------------------------------------

SELECT
    ROUND(AVG(total_amount),2) AS average_order
FROM orders
WHERE status IN ('paid','delivered');

--------------------------------------------------
-- Максимальный чек
--------------------------------------------------

SELECT
    MAX(total_amount)
FROM orders;

--------------------------------------------------
-- Минимальный чек
--------------------------------------------------

SELECT
    MIN(total_amount)
FROM orders;


--------------------------------------------------
SELECT

DATE_TRUNC('month',registration_date) AS month,

COUNT(*) AS users

FROM users

GROUP BY month

ORDER BY month;
--------------------------------------------------
SELECT

city,

COUNT(*) AS users

FROM users

GROUP BY city

ORDER BY users DESC

LIMIT 15;
--------------------------------------------------
SELECT

gender,

COUNT(*)

FROM users

GROUP BY gender;
--------------------------------------------------
SELECT

ROUND(
AVG(EXTRACT(YEAR FROM AGE(birth_date)))
)

FROM users;
--------------------------------------------------
SELECT

name,

brand,

price

FROM products

ORDER BY price DESC

LIMIT 20;
--------------------------------------------------
SELECT

name,

price

FROM products

ORDER BY price

LIMIT 20;
--------------------------------------------------
SELECT

ROUND(AVG(price),2)

FROM products;
--------------------------------------------------
SELECT

brand,

COUNT(*)

FROM products

GROUP BY brand

ORDER BY COUNT(*) DESC;
--------------------------------------------------
SELECT

c.name,

COUNT(*)

FROM products p

JOIN categories c

ON c.id=p.category_id

GROUP BY c.name

ORDER BY COUNT(*) DESC;
--------------------------------------------------
SELECT

status,

COUNT(*)

FROM orders

GROUP BY status;
--------------------------------------------------
SELECT

payment_method,

COUNT(*)

FROM orders

GROUP BY payment_method;
--------------------------------------------------
SELECT

DATE_TRUNC('month',order_date),

SUM(total_amount)

FROM orders

WHERE status IN ('paid','delivered')

GROUP BY 1

ORDER BY 1;
--------------------------------------------------
SELECT

DATE_TRUNC('month',order_date),

ROUND(AVG(total_amount),2)

FROM orders

GROUP BY 1

ORDER BY 1;
--------------------------------------------------
SELECT

p.name,

SUM(oi.quantity) AS total

FROM order_items oi

JOIN products p

ON p.id=oi.product_id

GROUP BY p.name

ORDER BY total DESC

LIMIT 20;
--------------------------------------------------
SELECT

brand,

SUM(quantity)

FROM order_items oi

JOIN products p

ON p.id=oi.product_id

GROUP BY brand

ORDER BY SUM(quantity) DESC;
--------------------------------------------------
SELECT

c.name,

SUM(quantity)

FROM order_items oi

JOIN products p

ON oi.product_id=p.id

JOIN categories c

ON p.category_id=c.id

GROUP BY c.name

ORDER BY SUM(quantity) DESC;
--------------------------------------------------