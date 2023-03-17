#Sales per employee last name
select
	LastName,
    sum(orderdetails.Quantity*orderdetails.UnitPrice) as Total
from employees join orders
on employees.EmployeeID = orders.EmployeeID
join orderdetails
on orders.OrderID = orderdetails.OrderID
group by LastName
order by Total DESC;

#Sales per category
SELECT
	CategoryName,
    sum(orderdetails.Quantity*orderdetails.UnitPrice) as Total
FROM 
	categories join products
    on categories.CategoryID = products.CategoryID
    join orderdetails
    on products.ProductID = orderdetails.ProductID
group by CategoryName
order by Total desc;

#Sales per category in May
SELECT
	CategoryName,
    sum(orderdetails.Quantity*orderdetails.UnitPrice) as Total
FROM 
	categories join products
    on categories.CategoryID = products.CategoryID
    join orderdetails
    on products.ProductID = orderdetails.ProductID
    join orders
    on orderdetails.OrderID = orders.orderID
    where month(OrderDate) = 5
group by CategoryName
order by Total desc;

#CREATING A STORED PRECEDURE

DELIMITER &&

CREATE PROCEDURE CategorySaleByMonthAdam(
month_nr int
)

begin

SELECT
	CategoryName,
    sum(orderdetails.Quantity*orderdetails.UnitPrice) as Total
FROM 
	categories join products
    on categories.CategoryID = products.CategoryID
    join orderdetails
    on products.ProductID = orderdetails.ProductID
    join orders
    on orderdetails.OrderID = orders.orderID
    where month(OrderDate) = month_nr
group by CategoryName
order by Total desc;

end &&
DELIMITER ;

#CALLING THE STORED PROCEDURE
call CategorySaleByMonthAdam;
