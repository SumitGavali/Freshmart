CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department VARCHAR(50)
);

CREATE TABLE aisles (
    aisle_id INT PRIMARY KEY,
    aisle VARCHAR(100)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    aisle_id INT,
    department_id INT,
    FOREIGN KEY (aisle_id) REFERENCES aisles(aisle_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    eval_set VARCHAR(10),
    order_number INT,
    order_dow INT,
    order_hour_of_day INT,
    days_since_prior_order FLOAT
);
CREATE TABLE order_products_prior (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE order_products_train (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);





