-- ============================================
-- TechStore Product Analytics
-- Database Schema
-- ============================================

-- Удаление таблиц
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ============================================
-- USERS
-- ============================================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    email VARCHAR(255) UNIQUE NOT NULL,

    gender VARCHAR(10),

    birth_date DATE,

    city VARCHAR(100),

    registration_date DATE NOT NULL
);

-- ============================================
-- CATEGORIES
-- ============================================

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,

    name VARCHAR(100) UNIQUE NOT NULL
);

-- ============================================
-- PRODUCTS
-- ============================================

CREATE TABLE products (

    id SERIAL PRIMARY KEY,

    name VARCHAR(255) NOT NULL,

    category_id INTEGER NOT NULL,

    brand VARCHAR(100) NOT NULL,

    price NUMERIC(10,2) NOT NULL CHECK(price > 0),

    FOREIGN KEY (category_id)
        REFERENCES categories(id)
);

-- ============================================
-- ORDERS
-- ============================================

CREATE TABLE orders (

    id SERIAL PRIMARY KEY,

    user_id INTEGER NOT NULL,

    order_date TIMESTAMP NOT NULL,

    status VARCHAR(20) NOT NULL
        CHECK(status IN ('created','paid','cancelled','delivered')),

    payment_method VARCHAR(30),

    total_amount NUMERIC(10,2)
        CHECK(total_amount >= 0),

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

-- ============================================
-- ORDER ITEMS
-- ============================================

CREATE TABLE order_items (

    id SERIAL PRIMARY KEY,

    order_id INTEGER NOT NULL,

    product_id INTEGER NOT NULL,

    quantity INTEGER NOT NULL
        CHECK(quantity > 0),

    unit_price NUMERIC(10,2) NOT NULL
        CHECK(unit_price > 0),

    FOREIGN KEY (order_id)
        REFERENCES orders(id),

    FOREIGN KEY (product_id)
        REFERENCES products(id)
);

-- ============================================
-- SESSIONS
-- ============================================

CREATE TABLE sessions (

    id SERIAL PRIMARY KEY,

    user_id INTEGER NOT NULL,

    session_date TIMESTAMP NOT NULL,

    device VARCHAR(20),

    traffic_source VARCHAR(50),

    duration INTEGER
        CHECK(duration >= 0),

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

-- ============================================
-- INDEXES
-- ============================================

CREATE INDEX idx_orders_user
ON orders(user_id);

CREATE INDEX idx_sessions_user
ON sessions(user_id);

CREATE INDEX idx_products_category
ON products(category_id);

CREATE INDEX idx_order_items_order
ON order_items(order_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);