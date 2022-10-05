create database GardenCenter

use GardenCenter
create table Categories(
	categoryID int not null IDENTITY(1,1) PRIMARY KEY,
	categoryName varchar(50) not null,
	categoryDescrip varchar(100) null
);

create table Departments(
	deptID int not null IDENTITY(1,1) PRIMARY KEY,
	deptName varchar(50) not null
);

create table Products(
	productID int not null IDENTITY(1,1) PRIMARY KEY,
	categoryID int not null FOREIGN KEY REFERENCES Categories(categoryID),
	productName varchar(50) not null,
	productStock int not null,
	buyPrice money not null,
	sellPrice money not null
);

create table Employees(
	empID int not null IDENTITY(1,1) PRIMARY KEY,
	depID int not null,
	firstName varchar(50) not null,
	lastName varchar(50) not null,
	hireDate DATE not null,
	phoneNum bigint not null,
	salary money not null,
	managerID int null FOREIGN KEY REFERENCES Employees(empID)
);

create table Orders(
	orderID int not null IDENTITY(1,1) PRIMARY KEY,
	empID int not null FOREIGN KEY REFERENCES Employees(empID),
	orderDate DATE not null

);

create table OrderItems(
	orderID int not null FOREIGN KEY REFERENCES Orders(orderID),
	productID int not null FOREIGN KEY REFERENCES Products(productID),
	CONSTRAINT oiPK PRIMARY KEY (orderID, productID),
	itemQuantity int not null,
	itemCost money not null
);

insert into Categories values('Plants','Plants grown in a garden.')
insert into Categories values('Produce','Produce grown on-site.')
insert into Categories values('Supplies','Supplies used in a garden.')
insert into Categories values('Furniture','Furniture suited for outdoors.')

select *
from Categories

insert into Departments values('CEO')
insert into Departments values('Custom Service')
insert into Departments values ('Accounting')
insert into Departments values('Gardeners')

select *
from Departments

insert into Products values(1,'Tulip',25,0.50,1.00)
insert into Products values(1,'Rose',25,0.50,1.00)
insert into Products values(2,'Apple',30,0.60,1.20)
insert into Products values(2,'Orange',30,0.60,1.20)
insert into Products values(3,'Shovel',20,5.00,10.00)
insert into Products values(3,'Hoe',20,5.00,10.00)
insert into Products values(4,'Patio Chair',15,10.00,20.00)
insert into Products values(4,'Patio Table',15,25.00,50.00)

select *
from Products

insert into Employees values(1,'John','Decker','2010-12-01',9737640800,55000,null)
insert into Employees values(2,'Bob','Smith','2011-05-15',9732352465,22000,1)
insert into Employees values(3,'Rachel','Downes','2011-05-18',2014653800,30000,1)
insert into Employees values(4,'Melissa','Mackey','2011-05-23',9734699614,18000,1)
insert into Employees values(2,'Sean','Cobbler','2012-03-30',9732224567,20000,2)
insert into Employees values(4,'Jimbo','Wickens','2014-07-09',9732224567,15000,4)
insert into Employees values(3,'Victor','Fontaine','2014-01-8',2017053463,25000,3)
insert into Employees values(2,'Barbara','Perry','2016-09-05',9738682047,15000,2)

select *
from Employees

insert into Orders values(2,'2018-11-01')
insert into Orders values(5,'2018-11-16')
insert into Orders values(8,'2018-11-16')

select *
from Orders

insert into OrderItems values(1,1,4,(SELECT sellPrice FROM Products WHERE productID = 1))
insert into OrderItems values(1,2,6,(SELECT sellPrice FROM Products WHERE productID = 2))
insert into OrderItems values(1,3,5,(SELECT sellPrice FROM Products WHERE productID = 3))
insert into OrderItems values(1,4,5,(SELECT sellPrice FROM Products WHERE productID = 4))
insert into OrderItems values(2,5,2,(SELECT sellPrice FROM Products WHERE productID = 5))
insert into OrderItems values(2,6,1,(SELECT sellPrice FROM Products WHERE productID = 6))

select *
from OrderItems


select *
from Categories
select *
from Products
select *
from Departments
select *
from Employees
select *
from OrderItems
SELECT o.orderID, o.empID, o.orderDate, SUM(oi.itemCost * oi.itemQuantity) AS orderTotal
FROM Orders o LEFT JOIN OrderItems oi ON o.orderID = oi.orderID
GROUP BY o.orderID, o.empID, o.orderDate