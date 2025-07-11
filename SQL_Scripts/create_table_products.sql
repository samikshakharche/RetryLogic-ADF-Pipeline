CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(100),
    category NVARCHAR(50),
    price DECIMAL(10,2),
    is_active BIT
);

INSERT INTO Products VALUES
(1, 'Pen', 'Stationery', 10.50, 1),
(2, 'Notebook', 'Stationery', 25.00, 1),
(3, 'Marker', 'Stationery', 15.00, 0);
