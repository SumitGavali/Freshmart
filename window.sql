select * from sales_view
select sum(add_to_cart_order) , department 
from sales_view
group by department 

select sum(add_to_cart_order)over()
from sales_view

select order_id, aisle, department, sum(add_to_cart_order)over() total_sales, sum(add_to_cart_order)over(partition by department) total_sales_by_department
from sales_view