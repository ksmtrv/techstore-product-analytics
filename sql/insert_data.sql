-- Загрузка пользователей
COPY users
FROM '../data/users.csv'
DELIMITER ','
CSV HEADER;

-- Загрузка категорий
COPY categories
FROM '../data/categories.csv'
DELIMITER ','
CSV HEADER;

-- Загрузка товаров
COPY products
FROM '../data/products.csv'
DELIMITER ','
CSV HEADER;

-- Загрузка заказов
COPY orders
FROM '../data/orders.csv'
DELIMITER ','
CSV HEADER;

-- Загрузка позиций заказов
COPY order_items
FROM '../data/order_items.csv'
DELIMITER ','
CSV HEADER;

-- Загрузка пользовательских сессий
COPY sessions
FROM '../data/sessions.csv'
DELIMITER ','
CSV HEADER;