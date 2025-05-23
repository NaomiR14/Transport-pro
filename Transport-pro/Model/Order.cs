namespace Transport_pro.Model;

// Orders Table
public class Order
{
    public int OrderId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string ProductName { get; set; }
    public string LicensePlate { get; set; }
    public string VehicleType { get; set; }
    public string OperatorName { get; set; }
    public string StartLocation { get; set; }
    public string EndLocation { get; set; }
    public int Quantity { get; set; }
    public DateTime OrderDate { get; set; }
}
