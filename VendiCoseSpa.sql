-- MySQL code for the VendiCose SpA Restocking System with correct tables and data insertion

CREATE DATABASE IF NOT EXISTS VendiCoseSPA;
USE VendiCoseSPA;

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL,
    WarehouseAddress VARCHAR(255) NOT NULL
);

CREATE TABLE Stock (
    ProductID INT,
    WarehouseID INT,
    Quantity INT,
    PRIMARY KEY (ProductID, WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);


CREATE TABLE Restock (
    RestockID INT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    RestockThreshold INT,
    RequestedDate DATE,
    FulfilledDate DATE,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

CREATE TABLE Store (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    StoreAddress VARCHAR(255) NOT NULL
);

CREATE TABLE WarehouseStore (
    WarehouseID INT,
    StoreID INT,
    PRIMARY KEY (WarehouseID, StoreID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Contact VARCHAR(100)
);

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    StoreID INT,
    CustomerID INT,
    SalesDate DATE,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE SalesDetail (
    SalesDetailID INT PRIMARY KEY,
    SalesID INT,
    ProductID INT,
    Quantity INT,
    LineTotalPrice DECIMAL(10, 2),
    FOREIGN KEY (SalesID) REFERENCES Sales(SalesID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Data insertion
INSERT INTO Category VALUES 
	(1, 'Food'), 
    (2, 'Cosmetics'), 
    (3, 'Electronics');

INSERT INTO Product VALUES 
	(101, 'Apple', 1, 0.50),
    (102, 'Banana', 1, 0.30),
    (103, 'Cheese', 1, 3.00),
    (104, 'Bread', 1, 1.20),
	(105, 'Milk', 1, 1.00),
    (106, 'Shampoo', 2, 5.00),
    (107, 'Toothpaste', 2, 2.50),
    (108, 'Face Cream', 2, 15.00),
    (109, 'Perfume', 2, 50.00),
    (110, 'TV', 3, 300.00),
    (111, 'Laptop', 3, 1000.00),
    (112, 'Smartphone', 3, 800.00),
	(113, 'Tablet', 3, 600.00),
    (114, 'Headphones', 3, 120.00),
    (115, 'Smartwatch', 3, 200.00);

INSERT INTO Warehouse VALUES 
	(201, 'Warehouse A', '123 Main St'), 
    (202, 'Warehouse B', '456 Market St');

INSERT INTO Stock VALUES 
	(101, 201, 500), 
    (102, 201, 400), 
    (103, 201, 200), 
    (104, 201, 300),
    (105, 201, 250),
    (106, 202, 300), 
    (107, 202, 200), 
    (108, 202, 150),
    (109, 202, 100), 
    (110, 202, 50),
	(111, 202, 60),
    (112, 202, 70),
    (113, 202, 80),
    (114, 202, 90),
    (115, 202, 100);
        
INSERT INTO Restock VALUES 
	(301, 101, 201, 100, '2025-02-15', '2025-02-17', 500), 
    (302, 106, 202, 50, '2025-02-16', null, 300),
    (303, 112, 202, 20, '2025-01-20', '2025-02-01', 100);
    
INSERT INTO Store VALUES 
	(401, 'Store 1', '789 Elm St'), 
	(402, 'Store 2', '321 Oak St'), 
    (403, 'Store 3', '555 Pine St');

INSERT INTO WarehouseStore VALUES 
	(201, 401),
    (201, 402), 
    (202, 402),
    (202, 403);

INSERT INTO Customer VALUES 
	(501, 'John Doe', 'john@example.com'), 
    (502, 'Jane Smith', 'jane@example.com'), 
    (503, 'Alice Brown', 'alice@example.com'),
    (504, 'Charlie Davis', 'charlie@example.com'), 
    (505, 'Emily White', 'emily@example.com'), 
    (506, 'Frank Green', 'frank@example.com'),
	(507, 'Grace Black', 'grace@example.com'), 
    (508, 'Hannah Blue', 'hannah@example.com'),
    (509, 'Ian Red', 'ian@example.com'), 
    (510, 'Jack Purple', 'jack@example.com');

INSERT INTO Sales VALUES 
    (601, 401, 501, '2024-02-01', 25.00), 
    (602, 402, 502, '2024-02-02', 50.00), 
    (603, 403, 503, '2024-02-03', 75.00),
    (604, 401, 504, '2024-02-04', 35.00), 
    (605, 402, 505, '2024-02-05', 55.00), 
    (606, 403, 506, '2024-02-06', 120.00),
    (607, 401, 507, '2024-02-07', 80.00), 
    (608, 402, 508, '2024-02-08', 60.00), 
    (609, 403, 509, '2024-02-09', 150.00),
    (610, 401, 510, '2024-02-10', 45.00),
    (611, 402, 501, '2024-02-11', 95.00), 
    (612, 403, 502, '2024-02-12', 85.00),
    (613, 401, 503, '2024-02-13', 70.00), 
    (614, 402, 504, '2024-02-14', 65.00);

INSERT INTO SalesDetail VALUES 
    (701, 601, 101, 5, 10.00), 
    (702, 602, 106, 2, 25.00), 
    (703, 603, 110, 1, 300.00),
    (704, 604, 102, 6, 3.00), 
    (705, 605, 107, 4, 17.50), 
    (706, 606, 112, 1, 1600.00),
    (707, 607, 103, 3, 45.00), 
    (708, 608, 108, 2, 45.00), 
    (709, 609, 111, 1, 1000.00),
    (710, 610, 105, 2, 20.00), 
    (711, 611, 109, 2, 100.00), 
    (712, 612, 113, 1, 600.00),
    (713, 613, 104, 1, 14.40), 
    (714, 614, 115, 1, 600.00);
    
    
    
-- MySQL Query to manually update stock quantities after a sale
UPDATE Stock s
JOIN WarehouseStore ws ON s.WarehouseID = ws.WarehouseID
JOIN Sales sa ON ws.StoreID = sa.StoreID
JOIN SalesDetail sd ON sa.SalesID = sd.SalesID
SET s.Quantity = s.Quantity - sd.Quantity
WHERE sd.ProductID = s.ProductID AND sa.SalesID = 701;   #change 701 with SalesID

-- Query to check product quantities in a specific warehouse
SELECT ProductID, Quantity
FROM Stock
WHERE WarehouseID = 201 AND ProductID = 101;            #change 201 and 301 with WarehouseID and ProductID, respectively

-- Query to monitor restock thresholds
SELECT s.ProductID, s.WarehouseID, s.Quantity, r.RestockThreshold
FROM Stock s
JOIN Restock r ON s.ProductID = r.ProductID AND s.WarehouseID = r.WarehouseID
WHERE s.Quantity < r.RestockThreshold;