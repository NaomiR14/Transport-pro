-- Index for Users table
CREATE INDEX idx_users_username ON Users (Username);
CREATE INDEX idx_users_email ON Users (Email);
CREATE INDEX idx_users_usertypeid ON Users (UserTypeId);

-- Index for Products table
CREATE INDEX idx_products_productname ON Products (ProductName);
CREATE INDEX idx_products_producttypeid ON Products (ProductTypeId);

-- Index for Vehicles table
CREATE INDEX idx_vehicles_vehicletypeid ON Vehicles (VehicleTypeId);
CREATE INDEX idx_vehicles_licenseplate ON Vehicles (LicensePlate);

-- Index for Operators table
CREATE INDEX idx_operators_name ON Operators (Name);

-- Index for Routes table
CREATE INDEX idx_routes_startlocation ON Routes (StartLocation);
CREATE INDEX idx_routes_endlocation ON Routes (EndLocation);

-- Index for Orders table
CREATE INDEX idx_orders_userid ON Orders (UserId);
CREATE INDEX idx_orders_productid ON Orders (ProductId);
CREATE INDEX idx_orders_vehicleid ON Orders (VehicleId);
CREATE INDEX idx_orders_operatorid ON Orders (OperatorId);
CREATE INDEX idx_orders_routeid ON Orders (RouteId);

-- Index for Expenses table
CREATE INDEX idx_expenses_expensetypeid ON Expenses (ExpenseTypeId);
CREATE INDEX idx_expenses_orderid ON Expenses (OrderId);

-- Index for Incidents table
CREATE INDEX idx_incidents_incidenttypeid ON Incidents (IncidentTypeId);
CREATE INDEX idx_incidents_orderid ON Incidents (OrderId);

-- Index for Resources table
CREATE INDEX idx_resources_resourcetypeid ON Resources (ResourceTypeId);
CREATE INDEX idx_resources_name ON Resources (Name);

-- Create an index on the email column for fast lookups
CREATE UNIQUE INDEX idx_customers_email ON customers (email);

-- Create an index on the last_name column for searches by last name
CREATE INDEX idx_customers_last_name ON customers (last_name);

-- Create a composite index on city and state for filtering by location
CREATE INDEX idx_customers_city_state ON customers (city, state);

-- Create an index on the phone_number column for fast lookups
CREATE INDEX idx_customers_phone_number ON customers (phone_number);
