using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Transport_pro.Model;

// UserType Table
public class UserType
{
    public int UserTypeId { get; set; }
    public string TypeName { get; set; }

    // Navigation Property
    public ICollection<User> Users { get; set; }
}

// ProductType Table
public class ProductType
{
    public int ProductTypeId { get; set; }
    public string TypeName { get; set; }

    // Navigation Property
    public ICollection<Product> Products { get; set; }
}

// VehicleType Table
public class VehicleType
{
    public int VehicleTypeId { get; set; }
    public string TypeName { get; set; }

    // Navigation Property
    public ICollection<Vehicle> Vehicles { get; set; }
}

// ExpenseType Table
public class ExpenseType
{
    public int ExpenseTypeId { get; set; }
    public string TypeName { get; set; }

    // Navigation Property
    public ICollection<Expense> Expenses { get; set; }
}

// IncidentType Table
public class IncidentType
{
    public int IncidentTypeId { get; set; }
    public string TypeName { get; set; }

    // Navigation Property
    public ICollection<Incident> Incidents { get; set; }
}

// ResourceType Table
public class ResourceType
{
    public int ResourceTypeId { get; set; }
    public string TypeName { get; set; }

    // Navigation Property
    public ICollection<Resource> Resources { get; set; }
}

// Users Table
public class User
{
    public int UserId { get; set; }
    public string Username { get; set; }
    public string PasswordHash { get; set; }
    public string Email { get; set; }
    public int UserTypeId { get; set; }
    public DateTime CreatedAt { get; set; }

    // Navigation Property
    public UserType UserType { get; set; }
    public ICollection<Order> Orders { get; set; }
}

// Products Table
public class Product
{
    public int ProductId { get; set; }
    public string ProductName { get; set; }
    public int ProductTypeId { get; set; }
    public decimal Price { get; set; }
    public int Stock { get; set; }

    // Navigation Property
    public ProductType ProductType { get; set; }
    public ICollection<Order> Orders { get; set; }
}

// Vehicles Table
public class Vehicle
{
    public int VehicleId { get; set; }
    public int VehicleTypeId { get; set; }
    public string LicensePlate { get; set; }
    public int Capacity { get; set; }
    public string Status { get; set; }

    // Navigation Property
    public VehicleType VehicleType { get; set; }
    public ICollection<Order> Orders { get; set; }
}

// Operators Table
public class Operator
{
    public int OperatorId { get; set; }
    public string Name { get; set; }
    public decimal HourlyRate { get; set; }

    // Navigation Property
    public ICollection<Order> Orders { get; set; }
}

// Routes Table
public class Route
{
    public int RouteId { get; set; }
    public string StartLocation { get; set; }
    public string EndLocation { get; set; }
    public decimal Distance { get; set; }
    public string EstimatedTime { get; set; }

    // Navigation Property
    public ICollection<Order> Orders { get; set; }
}

// Expenses Table
public class Expense
{
    public int ExpenseId { get; set; }
    public int ExpenseTypeId { get; set; }
    public int OrderId { get; set; }
    public decimal Amount { get; set; }
    public DateTime ExpenseDate { get; set; }

    // Navigation Properties
    public ExpenseType ExpenseType { get; set; }
    public Order Order { get; set; }
}

// Incidents Table
public class Incident
{
    public int IncidentId { get; set; }
    public int IncidentTypeId { get; set; }
    public int OrderId { get; set; }
    public string Description { get; set; }
    public DateTime IncidentDate { get; set; }

    // Navigation Properties
    public IncidentType IncidentType { get; set; }
    public Order Order { get; set; }
}

// Resources Table
public class Resource
{
    public int ResourceId { get; set; }
    public int ResourceTypeId { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }

    // Navigation Property
    public ResourceType ResourceType { get; set; }
}
