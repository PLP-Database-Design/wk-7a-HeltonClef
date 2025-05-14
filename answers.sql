Question 1


-- Create a new table to store the products for each order
CREATE TABLE ProductDetail_1NF (
  OrderID INT,
  CustomerName VARCHAR(255),
  Product VARCHAR(255)
);

-- Insert the products for each order into the new table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 
  OrderID,
  CustomerName,
  TRIM(value) AS Product
FROM 
  ProductDetail,
  STRING_SPLIT(Products, ',') AS Product;

-- Alternatively, if your database system doesn't support STRING_SPLIT,
-- you can use a different approach, such as using a numbers table or a recursive CTE.

-- Drop the original table (if desired)
-- DROP TABLE ProductDetail;


Question 2: 



-- Create the Orders table
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(255)
);

-- Create the OrderItems table
CREATE TABLE OrderItems (
  OrderID INT,
  Product VARCHAR(255),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT 
  OrderID,
  CustomerName
FROM 
  OrderDetails;

-- Insert data into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT 
  OrderID,
  Product,
  Quantity
FROM 
  OrderDetails;

-- Drop the original table (if desired)
-- DROP TABLE OrderDetails;
