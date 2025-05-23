-- Insert sample data
INSERT INTO orderstatustypes (status) values
('InTransit');
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled'),
('Returned');

-- Insert sample data into UserType
INSERT INTO UserType (TypeName) VALUES 
('Customer'),
('Admin'),
('Operator');

-- Insert sample data into ProductType
INSERT INTO ProductType (TypeName) VALUES 
('Electronics'),
('Furniture'),
('Clothing');

-- Insert sample data into VehicleType
INSERT INTO VehicleType (TypeName) VALUES 
('Truck'),
('Van'),
('Motorcycle');

-- Insert sample data into ExpenseType
INSERT INTO ExpenseType (TypeName) VALUES 
('Fuel'),
('Toll'),
('Operator Salary');

-- Insert sample data into IncidentType
INSERT INTO IncidentType (TypeName) VALUES 
('Accident'),
('Delay'),
('Mechanical Issue');

-- Insert sample data into ResourceType
INSERT INTO ResourceType (TypeName) VALUES 
('Tool'),
('Spare Part'),
('Consumable');

-- Insert sample data into Users
INSERT INTO Users (Username, PasswordHash, Email, UserTypeId) VALUES 
('john_doe', 'hashed_password_1', 'john@example.com', 1),
('jane_admin', 'hashed_password_2', 'jane@example.com', 2),
('mike_operator', 'hashed_password_3', 'mike@example.com', 3);

-- Insert sample data into Products
INSERT INTO Products (ProductName, ProductTypeId, Price, Stock) VALUES 
('Laptop', 1, 1200.00, 50),
('Sofa', 2, 500.00, 20),
('T-Shirt', 3, 20.00, 100);

-- Insert sample data into Vehicles
INSERT INTO Vehicles (VehicleTypeId, LicensePlate, Capacity, Status) VALUES 
(1, 'ABC-123', 1000, 'Available'),
(2, 'XYZ-789', 500, 'In Use'),
(3, 'MNO-456', 200, 'Available');

-- Insert sample data into Operators
INSERT INTO Operators (Name, HourlyRate) VALUES 
('Mike Johnson', 25.00),
('Sarah Lee', 30.00);

-- Insert sample data into Routes
INSERT INTO Routes (StartLocation, EndLocation, Distance, EstimatedTime) VALUES 
('New York', 'Los Angeles', 4500.00, '72 hours'),
('Chicago', 'Houston', 1500.00, '24 hours'),
('San Francisco', 'Seattle', 1300.00, '20 hours');

-- Insert sample data into Orders
INSERT INTO Orders (UserId, ProductId, VehicleId, OperatorId, RouteId, Quantity) VALUES 
(1, 1, 1, 1, 1, 2),
(1, 2, 2, 2, 2, 1),
(1, 3, 3, 1, 3, 5);

-- Insert sample data into Expenses
INSERT INTO Expenses (ExpenseTypeId, OrderId, Amount, ExpenseDate) VALUES 
(1, 1, 300.00, CURRENT_TIMESTAMP),
(2, 1, 50.00, CURRENT_TIMESTAMP),
(3, 2, 200.00, CURRENT_TIMESTAMP);

-- Insert sample data into Incidents
INSERT INTO Incidents (IncidentTypeId, OrderId, Description, IncidentDate) VALUES 
(1, 1, 'Minor accident on the way', CURRENT_TIMESTAMP),
(2, 2, 'Delayed due to traffic', CURRENT_TIMESTAMP);

-- Insert sample data into Resources
INSERT INTO Resources (ResourceTypeId, Name, Quantity) VALUES 
(1, 'Wrench', 10),
(2, 'Spare Tire', 5),
(3, 'Oil', 20);

INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, postal_code, country, date_of_birth)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'New York', 'NY', '10001', 'USA', '1985-05-15'),
    ('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Elm St', 'Los Angeles', 'CA', '90001', 'USA', '1990-08-22'),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '5551234567', '789 Oak St', 'Chicago', 'IL', '60601', 'USA', '1982-03-10'),
    ('Bob', 'Brown', 'bob.brown@example.com', '4449876543', '321 Pine St', 'Houston', 'TX', '77001', 'USA', '1978-12-05'),
    ('Emily', 'Davis', 'emily.davis@example.com', '3334567890', '654 Maple St', 'Phoenix', 'AZ', '85001', 'USA', '1995-07-19');
