-- Create the database
--CREATE DATABASE TransporPro_Project;

-- Switch to the new database
--\c TransporPro_Project;

-- Create the OrderStatustypes table
CREATE TABLE orderstatustypes (
    statusTypeId SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL UNIQUE
);

-- Create the UserType table
CREATE TABLE UserType (
    UserTypeId SERIAL PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL UNIQUE
);

-- Create the ProductType table
CREATE TABLE ProductType (
    ProductTypeId SERIAL PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL UNIQUE
);

-- Create the VehicleType table
CREATE TABLE VehicleType (
    VehicleTypeId SERIAL PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL UNIQUE
);

-- Create the ExpenseType table
CREATE TABLE ExpenseType (
    ExpenseTypeId SERIAL PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL UNIQUE
);

-- Create the IncidentType table
CREATE TABLE IncidentType (
    IncidentTypeId SERIAL PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL UNIQUE
);

-- Create the ResourceType table
CREATE TABLE ResourceType (
    ResourceTypeId SERIAL PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL UNIQUE
);

-- Create the Users table
CREATE TABLE Users (
    UserId SERIAL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    UserTypeId INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserTypeId) REFERENCES UserType(UserTypeId)
);

-- Create the Products table
CREATE TABLE Products (
    ProductId SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    ProductTypeId INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    FOREIGN KEY (ProductTypeId) REFERENCES ProductType(ProductTypeId)
);

-- Create the Vehicles table
CREATE TABLE Vehicles (
    VehicleId SERIAL PRIMARY KEY,
    VehicleTypeId INT NOT NULL,
    LicensePlate VARCHAR(20) NOT NULL UNIQUE,
    Capacity INT NOT NULL,
    Status VARCHAR(50) DEFAULT 'Available',
    FOREIGN KEY (VehicleTypeId) REFERENCES VehicleType(VehicleTypeId)
);

-- Create the Operators table
CREATE TABLE Operators (
    OperatorId SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    HourlyRate DECIMAL(10, 2) NOT NULL
);

-- Create the Routes table
CREATE TABLE Routes (
    RouteId SERIAL PRIMARY KEY,
    StartLocation VARCHAR(100) NOT NULL,
    EndLocation VARCHAR(100) NOT NULL,
    Distance DECIMAL(10, 2) NOT NULL,
    EstimatedTime VARCHAR(50)
);

drop table if exists orders  
-- Create the Orders table
CREATE TABLE Orders (
    OrderId SERIAL PRIMARY KEY,
    CustomerId INT NOT NULL,
    ProductId INT NOT NULL,
    VehicleId INT NOT NULL,
    OperatorId INT NOT NULL,
    RouteId INT NOT NULL,
    Quantity INT NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
    FOREIGN KEY (VehicleId) REFERENCES Vehicles(VehicleId),
    FOREIGN KEY (OperatorId) REFERENCES Operators(OperatorId),
    FOREIGN KEY (RouteId) REFERENCES Routes(RouteId)
);

-- Add the new column "status" to the "orders" table
ALTER TABLE orders
ADD COLUMN status INT;

-- Add a foreign key constraint to ensure "status" references valid "statustypeid" values
ALTER TABLE orders
ADD CONSTRAINT fk_status_orderstatustypes
FOREIGN KEY (status)
REFERENCES orderstatustypes (statustypeid)
ON DELETE SET NULL;

-- Create the Expenses table
CREATE TABLE Expenses (
    ExpenseId SERIAL PRIMARY KEY,
    ExpenseTypeId INT NOT NULL,
    OrderId INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    ExpenseDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ExpenseTypeId) REFERENCES ExpenseType(ExpenseTypeId),
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

-- Create the Incidents table
CREATE TABLE Incidents (
    IncidentId SERIAL PRIMARY KEY,
    IncidentTypeId INT NOT NULL,
    OrderId INT NOT NULL,
    Description TEXT NOT NULL,
    IncidentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IncidentTypeId) REFERENCES IncidentType(IncidentTypeId),
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

-- Create the Resources table
CREATE TABLE Resources (
    ResourceId SERIAL PRIMARY KEY,
    ResourceTypeId INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (ResourceTypeId) REFERENCES ResourceType(ResourceTypeId)
);

--Create Customer Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY, -- Unique identifier for each customer
    first_name VARCHAR(50) NOT NULL, -- Customer's first name
    last_name VARCHAR(50) NOT NULL, -- Customer's last name
    email VARCHAR(100) UNIQUE NOT NULL, -- Customer's email address
    phone_number VARCHAR(15), -- Customer's phone number
    address TEXT, -- Customer's address
    city VARCHAR(50), -- City of the customer
    state VARCHAR(50), -- State/region of the customer
    postal_code VARCHAR(20), -- Postal/ZIP code
    country VARCHAR(50), -- Country of the customer
    date_of_birth DATE, -- Customer's date of birth
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Record creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Record update timestamp
);