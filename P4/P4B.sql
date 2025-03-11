USE P4C;

-- Insert sample data into Customers table
INSERT INTO Customers (Name, Contact, Email, PurchaseHistory, LoyaltyPoints)
VALUES 
('John Doe', '123-456-7890', 'john.doe@example.com', 'Laptop, Smartphone', 100),
('Jane Smith', '987-654-3210', 'jane.smith@example.com', 'Headphones, Tablet', 50),
('Alice Johnson', '555-555-5555', 'alice.johnson@example.com', 'Smartwatch, Camera', 75),
('Bob Brown', '111-222-3333', 'bob.brown@example.com', 'Printer, Monitor', 200),
('Charlie Davis', '444-444-4444', 'charlie.davis@example.com', 'Keyboard, Mouse', 30),
('Eve White', '777-777-7777', 'eve.white@example.com', 'Laptop, Printer', 150),
('Frank Wilson', '888-888-8888', 'frank.wilson@example.com', 'Tablet, Smartwatch', 80),
('Grace Lee', '999-999-9999', 'grace.lee@example.com', 'Camera, Headphones', 90),
('Henry Moore', '666-666-6666', 'henry.moore@example.com', 'Monitor, Keyboard', 120),
('Ivy Taylor', '222-333-4444', 'ivy.taylor@example.com', 'Mouse, Smartphone', 60);

-- Insert sample data into Suppliers table
INSERT INTO Suppliers (Name, Contact, Address, ProductSupplied)
VALUES 
('Tech Supplier Inc.', '111-111-1111', '123 Tech St, Tech City', 'Laptops, Smartphones'),
('Mobile Devices Co.', '222-222-2222', '456 Mobile Ave, Mobile City', 'Smartphones, Tablets'),
('Wearables Ltd.', '333-333-3333', '789 Wearable Blvd, Wearable City', 'Smartwatches'),
('Accessories Inc.', '444-444-4444', '321 Accessory Rd, Accessory City', 'Headphones, Keyboards, Mice'),
('Peripherals Co.', '555-555-5555', '654 Peripheral Ln, Peripheral City', 'Printers, Monitors'),
('Electronics Ltd.', '666-666-6666', '987 Electronics Dr, Electronics City', 'Cameras'),
('Computer Parts Inc.', '777-777-7777', '159 Computer St, Computer City', 'Keyboards, Mice'),
('Display Solutions', '888-888-8888', '753 Display Ave, Display City', 'Monitors'),
('Global Gadgets', '999-999-9999', '456 Global Rd, Global City', 'Smartphones, Tablets'),
('Tech World', '000-000-0000', '789 Tech Blvd, Tech City', 'Laptops, Printers');

-- Insert sample data into Products table
INSERT INTO Products (Name, Category, Price, StockLevel, SupplierID)
VALUES 
('Laptop', 'Computers', 1200.00, 50, 1),
('Smartphone', 'Mobile Devices', 800.00, 100, 2),
('Tablet', 'Mobile Devices', 600.00, 75, 2),
('Smartwatch', 'Wearables', 250.00, 200, 3),
('Headphones', 'Accessories', 150.00, 300, 4),
('Printer', 'Peripherals', 300.00, 40, 5),
('Monitor', 'Displays', 400.00, 60, 6),
('Keyboard', 'Accessories', 50.00, 500, 7),
('Mouse', 'Accessories', 30.00, 600, 7),
('Camera', 'Electronics', 700.00, 30, 8);

-- Insert sample data into Employees table
INSERT INTO Employees (Name, Role, Contact, Salary)
VALUES 
('Alice Johnson', 'Manager', '555-555-5555', 5000.00),
('Bob Brown', 'Sales Representative', '111-222-3333', 3000.00),
('Charlie Davis', 'Inventory Manager', '444-444-4444', 3500.00),
('Eve White', 'Sales Representative', '777-777-7777', 3000.00),
('Frank Wilson', 'Sales Representative', '888-888-8888', 3000.00),
('Grace Lee', 'Inventory Manager', '999-999-9999', 3500.00),
('Henry Moore', 'Sales Representative', '666-666-6666', 3000.00),
('Ivy Taylor', 'Sales Representative', '222-333-4444', 3000.00),
('John Doe', 'Manager', '123-456-7890', 5000.00),
('Jane Smith', 'Sales Representative', '987-654-3210', 3000.00);

-- Insert sample data into Inventory table
INSERT INTO Inventory (ProductID, StockLevel)
VALUES 
(1, 50),
(2, 100),
(3, 75),
(4, 200),
(5, 300),
(6, 40),
(7, 60),
(8, 500),
(9, 600),
(10, 30);

-- Insert sample data into Sales table
INSERT INTO Sales (CustomerID, TotalAmount, InvoiceNumber)
VALUES 
(1, 1200.00, 'INV001'),
(2, 800.00, 'INV002'),
(3, 600.00, 'INV003'),
(4, 250.00, 'INV004'),
(5, 150.00, 'INV005'),
(6, 300.00, 'INV006'),
(7, 400.00, 'INV007'),
(8, 50.00, 'INV008'),
(9, 30.00, 'INV009'),
(10, 700.00, 'INV010');

-- Insert sample data into SalesDetails table
INSERT INTO SalesDetails (SaleID, ProductID, Quantity, Subtotal)
VALUES 
(1, 1, 1, 1200.00),
(2, 2, 1, 800.00),
(3, 3, 1, 600.00),
(4, 4, 1, 250.00),
(5, 5, 1, 150.00),
(6, 6, 1, 300.00),
(7, 7, 1, 400.00),
(8, 8, 1, 50.00),
(9, 9, 1, 30.00),
(10, 10, 1, 700.00);

-- Insert sample data into SalesEmployee table
INSERT INTO SalesEmployee (SaleID, EmployeeID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert sample data into PurchaseOrders table
INSERT INTO PurchaseOrders (SupplierID, ExpectedDelivery)
VALUES 
(1, '2023-11-01'),
(2, '2023-11-02'),
(3, '2023-11-03'),
(4, '2023-11-04'),
(5, '2023-11-05'),
(6, '2023-11-06'),
(7, '2023-11-07'),
(8, '2023-11-08'),
(1, '2023-11-09'),
(2, '2023-11-10');

-- Insert sample data into PurchaseOrderDetails table
INSERT INTO PurchaseOrderDetails (OrderID, ProductID, QuantityOrdered, PricePerUnit)
VALUES 
(1, 1, 10, 1100.00),
(2, 2, 20, 750.00),
(3, 3, 15, 550.00),
(4, 4, 50, 200.00),
(5, 5, 100, 130.00),
(6, 6, 10, 280.00),
(7, 7, 20, 380.00),
(8, 8, 100, 45.00),
(9, 9, 200, 25.00),
(10, 10, 10, 650.00);