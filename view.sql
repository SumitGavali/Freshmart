create view Sales_view as ( SELECT 
    o.order_id,
    o.user_id,
    o.order_number,
    o.order_dow,
    o.order_hour_of_day,
    o.days_since_prior_order,

    op.product_id,
    op.add_to_cart_order,
    op.reordered,

    p.product_name,
    a.aisle,
    d.department

FROM orders o
JOIN order_products_prior op ON o.order_id = op.order_id
JOIN products p ON op.product_id = p.product_id
JOIN aisles a ON p.aisle_id = a.aisle_id
JOIN departments d ON p.department_id = d.department_id
);