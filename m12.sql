CREATE DATABASE IF NOT EXISTS ROS_DB;
USE ROS_DB;

-- =====================================================
-- ROOT TABLES
-- =====================================================

CREATE TABLE subscription (
    subscription_id INT PRIMARY KEY,
    subscription_name VARCHAR(50),
    user_limit INT,
    monthly_price DECIMAL(10,2)
);

CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50),
    country_code VARCHAR(10)
);

CREATE TABLE currency (
    currency_id INT PRIMARY KEY,
    currency_code VARCHAR(10),
    currency_name VARCHAR(50),
    symbol VARCHAR(10)
);

CREATE TABLE role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50)
);

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- =====================================================
-- REFERENCE TABLES
-- =====================================================

CREATE TABLE taxinfo (
    tax_id INT PRIMARY KEY,
    country_id INT,
    tax_name VARCHAR(50),
    tax_rate DECIMAL(5,2),

    CONSTRAINT fk_tax_country
    FOREIGN KEY (country_id)
    REFERENCES country(country_id)
);

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    country_id INT,
    subscription_id INT,
    status VARCHAR(20),
    activation_date DATE,
    inactivation_date DATE,

    CONSTRAINT fk_client_country
    FOREIGN KEY (country_id)
    REFERENCES country(country_id),

    CONSTRAINT fk_client_subscription
    FOREIGN KEY (subscription_id)
    REFERENCES subscription(subscription_id)
);

CREATE TABLE restaurant (
    restaurant_id INT PRIMARY KEY,
    client_id INT,
    country_id INT,
    currency_id INT,
    tax_id INT,
    restaurant_name VARCHAR(100),
    opening_date DATE,

    CONSTRAINT fk_rest_client
    FOREIGN KEY (client_id)
    REFERENCES client(client_id),

    CONSTRAINT fk_rest_country
    FOREIGN KEY (country_id)
    REFERENCES country(country_id),

    CONSTRAINT fk_rest_currency
    FOREIGN KEY (currency_id)
    REFERENCES currency(currency_id),

    CONSTRAINT fk_rest_tax
    FOREIGN KEY (tax_id)
    REFERENCES taxinfo(tax_id)
);

CREATE TABLE system_user (
    user_id INT PRIMARY KEY,
    restaurant_id INT,
    role_id INT,
    department_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    join_date DATE,

    CONSTRAINT fk_user_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id),

    CONSTRAINT fk_user_role
    FOREIGN KEY (role_id)
    REFERENCES role(role_id),

    CONSTRAINT fk_user_department
    FOREIGN KEY (department_id)
    REFERENCES department(department_id)
);

-- =====================================================
-- TRANSACTION TABLES
-- =====================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    restaurant_id INT,
    order_date DATE,
    order_time TIME,
    order_type VARCHAR(20),
    drinks_amount DECIMAL(10,2),
    food_amount DECIMAL(10,2),
    other_payment DECIMAL(10,2),
    service_charge DECIMAL(10,2),
    delivery_charge DECIMAL(10,2),
    order_amount DECIMAL(10,2),
    tax_amount DECIMAL(10,2),
    order_total DECIMAL(10,2),

    CONSTRAINT fk_order_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id)
);

CREATE TABLE sales (
    sales_id INT PRIMARY KEY,
    restaurant_id INT,
    sales_date DATE,
    drinks_total DECIMAL(10,2),
    food_total DECIMAL(10,2),
    other_total DECIMAL(10,2),
    service_total DECIMAL(10,2),
    delivery_total DECIMAL(10,2),
    tax_total DECIMAL(10,2),
    credit_card_tip DECIMAL(10,2),
    grand_total DECIMAL(10,2),

    CONSTRAINT fk_sales_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id)
);

CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    restaurant_id INT,
    expense_date DATE,
    bills DECIMAL(10,2),
    vendors DECIMAL(10,2),
    wage DECIMAL(10,2),
    advances DECIMAL(10,2),
    repairs DECIMAL(10,2),
    sundries DECIMAL(10,2),
    total_expense DECIMAL(10,2),

    CONSTRAINT fk_expenses_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id)
);

CREATE TABLE cashup (
    cashup_id INT PRIMARY KEY,
    restaurant_id INT,
    cashup_date DATE,
    bod DECIMAL(10,2),
    sales DECIMAL(10,2),
    expenses DECIMAL(10,2),
    delivery_charges DECIMAL(10,2),
    eod DECIMAL(10,2),

    CONSTRAINT fk_cashup_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id)
);

CREATE TABLE banking (
    banking_id INT PRIMARY KEY,
    restaurant_id INT,
    banking_date DATE,
    banking_total DECIMAL(10,2),
    banked_total DECIMAL(10,2),
    sealed_by INT,

    CONSTRAINT fk_banking_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id),

    CONSTRAINT fk_banking_user
    FOREIGN KEY (sealed_by)
    REFERENCES system_user(user_id)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    restaurant_id INT,
    delivery_date DATE,
    partner VARCHAR(50),
    partner_share DECIMAL(10,2),
    restaurant_share DECIMAL(10,2),
    api_amount DECIMAL(10,2),
    match_status BOOLEAN,

    CONSTRAINT fk_delivery_order
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    CONSTRAINT fk_delivery_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id)
);
