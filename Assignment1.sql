--Anjali Negi
--SQL Assignment 01
--Date: 28 Nov,2023

CREATE DATABASE TechShop;
USE [TechShop];

--TASK:2. Data Definition Language (DDL)
--1. Creating Customers table
CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY IDENTITY(1,1),
FirstName VARCHAR(20),
LastName VARCHAR(20),
Email VARCHAR(50),
Phone CHAR(10),
Address VARCHAR(100)
);

--Creating Products table
CREATE TABLE Products
(
ProductID INT PRIMARY KEY IDENTITY(1,1),
ProductName VARCHAR(100),
Description VARCHAR(200),
Price DECIMAL(10,2)
);

--Creating Orders table
DROP TABLE [dbo].[Inventory];
CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY(101,1),
CustomerID INT FOREIGN KEY (CustomerID) REFERENCES [dbo].[Customers]([CustomerID]),
OrderDate DATE,
TotalAmount DECIMAL(10,2)
);

--Creating OrderDetails table
CREATE TABLE OrderDetails
(
OrderDetailID INT PRIMARY KEY IDENTITY(201,1),
OrderID INT FOREIGN KEY (OrderID) REFERENCES [dbo].[Orders]([OrderID]),
ProductID INT FOREIGN KEY (ProductID) REFERENCES [dbo].[Products]([ProductID]),
Quantity INT 
);

--Creating Inventory table
CREATE TABLE Inventory
(
InventoryID INT PRIMARY KEY IDENTITY(301,1),
ProductID INT FOREIGN KEY (ProductID) REFERENCES [dbo].[Products]([ProductID]),
QuantityInStock INT,
LastStockUpdate DATETIME
);


--TASK 3: Data Manipulation Language (DML)
-- a) Insert atleast 10 records in the following tables
--Customers

INSERT INTO [dbo].[Customers] ([FirstName], [LastName], [Email], [Phone], [Address])
VALUES
('Jack', 'Smith', 'jack.simth@email.com', '1234567890', '123 Main St'),
('Jolly', 'Joe', 'jolly.joe@email.com', '9876543210', '456 Oak St'),
('Ria', 'Johnson', 'ria.j@email.com', '5551234567', '789 Pine St'),
('Amit', 'Chauhan', 'amit.c@email.com', '4447890123', '101 Cedar Ave'),
('Mahi', 'Bisht', 'mahhi.b@email.com', '2225557890', '202 Elm St'),
('Esha', 'Taylor', 'esha.t@email.com', '8883334444', '303 Maple Ave');


INSERT INTO [dbo].[Customers] ([FirstName], [LastName], [Email], [Phone], [Address])
VALUES
('Deepak', 'Singh', 'deepak.singh@email.com', '9876543210', '789 Oak St'),
('Grace', 'Maya', 'grace.maya@email.com', '4567890123', '101 Cedar St'),
('Ria', 'Negi', 'ria.negi@email.com', '8901234567', '222 Elm St'),
('Siya', 'Moore', 'siya.moore@email.com', '2345678901', '333 Birch St');


SELECT * FROM [dbo].[Orders];


--Products
INSERT INTO [dbo].[Products] ([ProductName], [Description], [Price])
VALUES
('Laptop', 'High-performance laptop with SSD', 999.99),
('Smartphone', 'Latest model with advanced features', 599.95),
('Camera', 'Professional DSLR camera with 4K capability', 1299.50),
('Headphones', 'Noise-canceling wireless headphones', 149.99),
('TV', '55-inch 4K Ultra HD Smart TV', 799.00),
('Tablet', 'Slim and lightweight tablet with long battery life', 349.75),
('Fitness Tracker', 'Waterproof fitness tracker with heart rate monitor', 79.99),
('Coffee Maker', 'Programmable coffee maker with built-in grinder', 89.50),
('Gaming Console', 'Next-gen gaming console with powerful graphics', 499.99),
('Smart Watch', 'Stylish smartwatch with health monitoring features', 199.50);

--Orders

INSERT INTO[dbo].[Orders] ([CustomerID], [OrderDate], [TotalAmount])
VALUES
(1, '2023-01-15', 150.00),
(2, '2023-02-20', 300.50),
(3, '2023-03-25', 450.75),
(4, '2023-04-10', 200.25),
(5, '2023-05-05', 120.99),
(6, '2023-06-15', 700.00),
(7, '2023-07-20', 250.50),
(8, '2023-08-10', 180.49),
(9, '2023-09-05', 420.80),
(10, '2023-10-12', 550.25);

INSERT INTO [dbo].[Orders] ([CustomerID], [OrderDate], [TotalAmount])
VALUES (10, '2023-10-20', 650.25);

--OrderDetails
INSERT INTO OrderDetails ([OrderID], [ProductID], [Quantity])
VALUES
(101, 1, 2),
(102, 3, 1),
(103, 2, 3),
(104, 5, 2),
(105, 4, 1),
(106, 6, 4),
(107, 7, 1),
(108, 9, 3),
(109, 8, 2),
(110, 10, 1);

INSERT INTO OrderDetails ([OrderID], [ProductID], [Quantity])
VALUES (112, 1, 2)

--Inventory
INSERT INTO [dbo].[Inventory]([ProductID], [QuantityInStock],[LastStockUpdate])
VALUES
(1, 50, '2023-01-15T08:30:00'),
(2, 75, '2023-02-20T10:45:00'),
(3, 30, '2023-03-25T12:15:00'),
(4, 100, '2023-04-10T14:00:00'),
(5, 40, '2023-05-05T16:30:00'),
(6, 60, '2023-06-15T18:45:00'),
(7, 25, '2023-07-20T20:00:00'),
(8, 90, '2023-08-10T22:30:00'),
(9, 55, '2023-09-05T23:45:00'),
(10, 70, '2023-10-12T01:00:00');

SELECT * FROM [dbo].[Customers];
SELECT * FROM [dbo].[Products];
SELECT * FROM [dbo].[Orders];
SELECT * FROM [dbo].[OrderDetails];
SELECT * FROM [dbo].[Inventory];



--b) Write SQL Querry for following tasks


--1) retrieve names and email of all customers
SELECT [FirstName],[LastName],[Email] FROM [dbo].[Customers];


--2) list all orders with their dates and corresponding customer names
SELECT O.[OrderID], O.[OrderDate], C.[FirstName], C.[LastName] FROM [dbo].[Orders] AS O
INNER JOIN [dbo].[Customers] AS C ON O.[CustomerID]=C.[CustomerID];


--3) insert new customer record into Customer table  
INSERT INTO [dbo].[Customers] ([FirstName],[LastName],[Email],[Address])
VALUES ('Anjali','Negi','anja.negi@gmail.com','459 Main St');


--4) update the prices of all electronic gagets in products table increase by 10% 
UPDATE [dbo].[Products] SET [Price]=[Price]+[Price]*0.1;


--5) delete a specific order and its associates order details drom the "orders"and "OrderDetails" .Allow user to input the orfer idas parameter
DECLARE @INP INT;
SET @INP=102;
DELETE FROM OrderDetails WHERE OrderID=@INP;
DELETE FROM Orders WHERE OrderID=@INP;


--6) insert a new order into the orders table. Include customer ID, order date and any other
--necessary information
INSERT INTO [dbo].[Orders] ([CustomerID],[OrderDate],[TotalAmount])
VALUES (2, '2023-07-14',170.50);


--7) update the contact information (email and address) of a specific customer in "Customers" table
DECLARE @UPId INT;
SET @UPId=3;
UPDATE [dbo].[Customers]
SET [Email]='ria.johnson@gmail.com', [Address]='152 Main St'
WHERE [CustomerID]=@UPId;


--8) recalculate and update the total cost of each order in the "Orders" table based on the quantities and prices in "OrderDetails" table
UPDATE [dbo].[Orders] SET


--9) delete all records and their associated order details for a specific customer from "Order" and "OrderDetails" table
DECLARE @DELid INT;
SET @DELid=9;
DELETE FROM [dbo].[OrderDetails] WHERE [OrderID] IN (SELECT [OrderID] FROM [dbo].[Orders] WHERE [CustomerID]=@DELid);
DELETE FROM [dbo].[Orders] WHERE [CustomerID]=@DELid;


--10) insert a new electonic gaget product into the table "Products"
INSERT INTO [dbo].[Products] ([ProductName],[Description],[Price])
VALUES ('Laptop2','High-performance laptop with SSD 2',1100.00);


--11) Update status of a specific order in the orders table (e.g. from Pending to Shipped) 
ALTER TABLE [dbo].[Orders] ADD [Status] VARCHAR(20);
UPDATE [dbo].[Orders] SET [Status]='Pending' WHERE [Status] IS NULL;

DECLARE @UPOrId INT;
SET @UPOrId=108;
DECLARE @UpSt VARCHAR(20);
SET @UpSt='Shipped';
UPDATE [dbo].[Orders] SET [Status]=@UpSt WHERE OrderID=@UPOrId;


--12) calculate and update the number of orders placed by each customer in the customer table based on the data in the orders table
ALTER TABLE [dbo].[Customers] ADD [NumberOfOrders] INT;
UPDATE [dbo].[Customers]
SET [NumberOfOrders] = (SELECT COUNT(*) FROM Orders
WHERE Orders.CustomerID = Customers.CustomerID);



--TASK 04: JOINS

--1) retrieve a list of all orders along with customer information (e.g.customer name) for each order.

SELECT [OrderID],[OrderDate], [FirstName],[LastName] FROM [dbo].[Orders] AS O
INNER JOIN [dbo].[Customers] AS C ON O.[CustomerID] = C.[CustomerID]


--2)  find the total revenue generated by each electronic gadget product. Include the product name and the total revenue

SELECT P.[ProductID], P.[ProductName], SUM(OD.[Quantity] * P.[Price]) AS [TotalRevenue]
FROM [dbo].[Products] AS P
INNER JOIN [dbo].[OrderDetails] AS OD ON P.[ProductID] = OD.ProductID
INNER JOIN [dbo].[Orders] AS O ON OD.OrderID = O.OrderID
GROUP BY P.[ProductID], P.[ProductName];


--3) list all customers who have made at least one purchase. Include their names and contact information.

SELECT C.[FirstName],C.[LastName], OD.[Quantity] FROM [dbo].[Customers] AS C
INNER JOIN [dbo].[Orders] AS O ON O.[CustomerID] =C.[CustomerID]
INNER JOIN [dbo].[OrderDetails] AS OD ON OD.[OrderID]=O.[OrderID]
WHERE OD.[Quantity]>=1;


--4) most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.

SELECT C.[FirstName],C.[LastName], OD.[Quantity] FROM [dbo].[Customers] AS C
INNER JOIN [dbo].[Orders] AS O ON O.[CustomerID] =C.[CustomerID]
INNER JOIN [dbo].[OrderDetails] AS OD ON OD.[OrderID]=O.[OrderID]


--5) retrieve a list of electronic gadgets along with their corresponding categories (Descriptions)

SELECT [ProductName], [Description] FROM [dbo].[Products]

--6) calculate the average order value for each customer. Include the customer's name and their average order value.
SELECT C.[CustomerID], C.[FirstName],C.[LastName],AVG(OD.[Quantity] * P.[Price]) AS [AverageOrderValue]
FROM [dbo].[Customers]  AS C
INNER JOIN [dbo].[Orders] AS O ON C.[CustomerID] = O.[CustomerID]
INNER JOIN [dbo].[OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
INNER JOIN [dbo].[Products] AS P ON OD.[ProductID] = P.[ProductID]
GROUP BY C.[CustomerID],C.[FirstName], C.[LastName]
ORDER BY [AverageOrderValue] DESC;--7) find the order with the highest total revenue. Include the order ID,customer information, and the total revenue.
SELECT O.[OrderID],C.[CustomerID],C.[FirstName],C.[LastName],SUM(OD.[Quantity] * P.[Price]) AS [TotalRevenue]
FROM [dbo].[Orders] AS O
JOIN [dbo].[Customers] AS C ON O.[CustomerID] = C.[CustomerID]
JOIN [dbo].[OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
JOIN [dbo].[Products] AS P ON OD.[ProductID] = P.[ProductID]
GROUP BY O.[OrderID],C.[CustomerID], C.[FirstName], C.[LastName]
ORDER BY [TotalRevenue] DESC OFFSET 0 ROWSFETCH NEXT 1 ROWS ONLY;--8) list electronic gadgets and the number of times each product has been ordered.
SELECT P.[ProductID],P.[ProductName], OD.[Quantity] FROM [dbo].[Products] AS P
INNER JOIN [dbo].[Orders] AS O ON O.[CustomerID] =P.[ProductID]
INNER JOIN [dbo].[OrderDetails] AS OD ON OD.[OrderID]=O.[OrderID]--9) find customers who have purchased a specific electronic gadget product.DECLARE @PName VARCHAR(20);SET @PName='Laptop';SELECT C.[CustomerID], C.[FirstName], C.[LastName] FROM [dbo].[Customers] AS CINNER JOIN [dbo].[Orders] AS O ON O.[CustomerID] =C.[CustomerID]
INNER JOIN [dbo].[OrderDetails] AS OD ON OD.[OrderID]=O.[OrderID]
INNER JOIN [dbo].[Products] AS P ON P.[ProductID]=OD.[ProductID]
WHERE P.[ProductName]=@PName;


--10) calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.

DECLARE @StartDate DATE;
SET @StartDate='2023-01-01'; 
DECLARE @EndDate DATE;
SET @EndDate='2023-04-11';  

SELECT SUM(OD.[Quantity] * P.[Price]) AS TotalRevenue
FROM [dbo].[OrderDetails] AS OD
INNER JOIN [dbo].[Orders] AS O ON OD.OrderID = O.OrderID
INNER JOIN [dbo].[Products] AS P ON OD.ProductID = P.ProductID
WHERE O.[OrderDate] BETWEEN @StartDate AND @EndDate;


--TASK 05: AGGREGATE FUNCTIONS

--1) find out which customers have not placed any orders

SELECT C.[FirstName],C.[LastName] FROM [dbo].[Customers] AS C
LEFT JOIN [dbo].[Orders] AS O ON O.[CustomerID]=C.CustomerID
WHERE O.[OrderID] IS NULL;


--2) find the total number of products available for sale. 

SELECT COUNT(*) AS [TotalProducts] FROM [dbo].[Products];


--3)  calculate the total revenue generated by TechShop. 
SELECT SUM(OD.Quantity * OD.Price) AS TotalRevenue
FROM [dbo].[Orders] AS O
INNER JOIN [dbo].[OrderDetails] AS OD ON O.[OrderID]=OD.[OrderID];


--4) calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.

DECLARE @PRNAME VARCHAR(20);
SET @PRNAME='Tablet';

SELECT AVG(OD.[Quantity]) AS AverageQuantity FROM [dbo].[OrderDetails] AS OD
INNER JOIN [dbo].[Products] AS P ON OD.[ProductID]=P.[ProductID]
WHERE P.[ProductName]=@PRNAME;



--5) calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter

DECLARE @CustomerID INT;
SET @CustomerID= 6;
SELECT SUM(OD.[Quantity] * P.[Price]) AS [TotalRevenue]
FROM [dbo].[OrderDetails] AS OD

INNER JOIN [dbo].[Orders] AS O ON OD.[OrderID] = O.[OrderID]
INNER JOIN [dbo].[Products] AS P ON OD.[ProductID] = P.[ProductID]
INNER JOIN [dbo].[Customers] AS C ON C.[CustomerId]=O.[CustomerId]
WHERE O.[CustomerID] = @CustomerID;



--6)  find the customers who have placed the most orders. List their names and the number of orders they've placed.

SELECT C.[CustomerID],C.[FirstName],C.[LastName],
COUNT(O.[OrderID]) AS NumberOfOrders FROM [dbo].[Customers] AS C
INNER JOIN [dbo].[Orders] AS O ON C.[CustomerID] = O.[CustomerID]
GROUP BY C.[CustomerID], C.[FirstName], C.[LastName]
ORDER BY [NumberOfOrders] DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;



--7) find the most popular product category, which is the one with the highest total quantity ordered across all orders.

SELECT P.[Description], SUM(OD.[Quantity]) AS TotalQuantityOrdered
FROM [dbo].[Products] AS P
INNER JOIN [dbo].[OrderDetails] AS OD ON P.[ProductID] = OD.[ProductID]
GROUP BY P.[Description]
ORDER BY [TotalQuantityOrdered] DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;


--8) find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending

SELECT C.[CustomerID],C.[FirstName],C.[LastName],SUM(OD.[Quantity] * P.[Price]) AS [TotalSpending]
FROM [dbo].[Customers] AS C
INNER JOIN [dbo].[Orders] AS O ON C.[CustomerID] = O.[CustomerID]
INNER JOIN [dbo].[OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
INNER JOIN [dbo].[Products] AS P ON OD.[ProductID] = P.[ProductID]
GROUP BY C.[CustomerID],C.[FirstName],C.[LastName]
ORDER BY [TotalSpending] DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;


--9) 
SELECT AVG(OrderRevenue) AS AverageOrderValue FROM
(SELECT O.OrderId, Sum(OD.Quantity * OD.Price) AS OrderRevenue FROM Orders O
JOIN OrderDetails OD ON O.OrderDate=OD.OrderDetailID
GROUP BY O.OrderID) AS OrderRevenue;

--10) find the total number of orders placed by each customer and list their names along with the order count.

SELECT C.[CustomerID], C.[FirstName], C.[LastName], COUNT(O.[OrderID]) AS [NoOfOrdersPlaced]
FROM [dbo].[Customers] AS C
INNER JOIN [dbo].[Orders] AS O ON C.[CustomerID] = O.[CustomerID]
GROUP BY C.[CustomerID], C.[FirstName],C.[LastName]
ORDER BY [NoOfOrdersPlaced] DESC;

