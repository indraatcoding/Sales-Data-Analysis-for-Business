create database SalesDataAnalysis;
show databases;
-- Create Tables--------------------------
use SalesDataAnalysis;
CREATE TABLE Customers(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(50),
City VARCHAR (50),
RagistrationDate date
);

CREATE TABLE Categories(
CategoryID INT PRIMARY KEY AUTO_INCREMENT,
CategoryName VARCHAR(50)
);

CREATE TABLE Products(
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductName VARCHAR(100),
CategoryID INT,
Price DECIMAL(10, 2),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

select * from customers;

CREATE TABLE Sales(
SalesID INT PRIMARY KEY AUTO_INCREMENT,
CustomerID INT,
ProductID INT,
SalesDate DATE,
Quantity INT,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (ProductID)  REFERENCES Products(ProductID)
);
ALTER TABLE Customers
RENAME COLUMN RagistrationDate to  RegistrationDate;

-- INSERT DATA---------------------

INSERT INTO Customers (FirstName, LastName, Email, City,  RegistrationDate)
VALUES
('John', 'Doe', 'john.doe@example.com', 'New York', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', 'Los Angeles', '2023-02-20'),
('Alice', 'Johnson', 'alice.johnson@example.com', 'Chicago', '2023-03-10'),
('Michael', 'Brown', 'michael.brown@example.com', 'Houston','2023-04-12'),
('Emily', 'Davis', 'emily.davis@example.com', 'Phoenix', '2023-05-22'),
('David', 'Miller', 'david.miller@example.com', 'Philadelphia','2023-06-30'),
('Sarah', 'Wilson', 'sarah.wilson@example.com', 'San Antonio', '2023-07-01'),
('Daniel', 'Moore', 'daniel.moore@example.com', 'San Diego','2023-08-05'),
('Sophia', 'Taylor', 'sophia.taylor@example.com', 'Dallas','2023-09-12'),
('William', 'Anderson', 'william.anderson@example.com', 'San Jose','2023-10-20');

INSERT INTO Categories (CategoryName)
VALUES 
('Electronics'),
('Clothing'),
('Furniture'),
('Books'),
('Toys'),
('Beauty Products'),
('Sports Equipment'),
('Kitchen Appliances');

INSERT INTO Products (ProductName, CategoryID, Price)
VALUES
('Smartphone', 1, 699.99),
('Laptop', 1, 999.99),
('Smartwatch', 1, 199.99),
('T-Shirt', 2, 19.99),
('Jeans', 2, 49.99),
('Sneakers', 2, 79.99),
('Sofa', 3, 299.99),
('Dining Table', 3, 499.99),
('Bookshelf', 3, 129.99),
('Fiction Novel', 4, 9.99),
('Science Textbook', 4, 29.99),
('Children Storybook', 4, 14.99),
('Action Figure', 5, 24.99),
('Doll', 5, 19.99),
('Building Blocks', 5, 34.99),
('Face Cream', 6, 14.99),
('Shampoo', 6, 7.99),
('Lipstick', 6, 9.99),
('Tennis Racket', 7, 89.99),
('Basketball', 7, 29.99),
('Football', 7, 19.99),
('Blender', 8, 49.99),
('Microwave', 8, 129.99),
('Toaster', 8, 39.99);

INSERT INTO Sales (CustomerID, ProductID, SalesDate, Quantity, TotalAmount) 
VALUES 
(1, 1, '2024-06-01', 1, 699.99),
(1, 3, '2024-06-02', 2, 39.98),
(2, 2, '2024-06-03', 1, 999.99),
(3, 5, '2024-06-04', 1, 299.99);


-- Analysis Queries------------------
-- 1. Total Sales Revenue
SELECT SUM(TotalAmount) AS TotalRevenue FROM Sales;

-- 2. Top-Selling Products
SELECT p.ProductName, SUM(s.Quantity) AS TotalSold
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductId
GROUP BY ProductName
ORDER BY TotalSold DESC
LIMIT 3;

-- 3. Customer Purchase History----------------------------
SELECT c.FirstName, c.LastName, p.ProductName, s.Quantity, s.TotalAmount, s.SalesDate
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
JOIN Products p ON s.ProductID = p.ProductID
WHERE c.CustomerID = 1; -- Replace with desired CustomerID

-- 4. Category-Wise Revenue------------------------------
SELECT cat.CategoryName, SUM(s.TotalAmount) AS Revenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY Revenue DESC;

-- 5. New Customers in a Month---------------------
SELECT COUNT(*) AS NewCustomers
FROM Customers
WHERE RegistrationDate BETWEEN '2023-01-15' AND '2023-09-12';

