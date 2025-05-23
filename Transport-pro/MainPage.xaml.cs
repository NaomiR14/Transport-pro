using Microsoft.Maui.Controls;
using NLog;
using System.Data;
using Transport_pro.Model;
using Transport_pro.Services;

namespace Transport_pro;

public partial class MainPage : FlyoutPage
{
    private static Logger Logger = LogManager.GetCurrentClassLogger();
    private readonly DatabaseManager dbManager;
    private List<Order> _ordersList { get; set; } = new();

    public MainPage()
    {
        InitializeComponent();

        Logger.Info("Append to start a new Database connection");
        
        var dbManager = new DatabaseManager("Host=localhost:5432;Username=postgres;Password=postgres;Database=transporpro_project");

        //dbManager.ExecuteCommandAsync("INSERT INTO testtable (id, testfield) VALUES (1, 'testing')").Wait();

        var result2 = dbManager.ExecuteFunctionAsync2("select * from orders_getall()").Result;

        // Log the result2 DataTable using Logger.Debug
        foreach (System.Data.DataRow row in result2.Rows)
        {
            var rowValues = string.Join(", ", row.ItemArray.Select(item => item.ToString()));
            Logger.Debug($"Row: {rowValues}");
        }

        var ordersList = Placeholder(result2);

    }

    private async void OnDashboardClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new Pages.DashboardPage());
    }

    private async void LoadData()
    {
        //Do not use this method. second method already returns a datable which is easier to handle
        var result = dbManager.ExecuteFunctionAsync("select * from orders_getall()").Result;
        dbManager.ProcessResult(result);

        BindingContext = this; // Bind the ViewModel to the UI
    }

    
    private List<Order> Placeholder(DataTable result)
    {
        foreach (DataRow row in result.Rows)
        {
            var order = new Order
            {
                OrderId = row.Field<int>("orderid"),
                FirstName = row.Field<string>("firstname"),
                LastName = row.Field<string>("lastname"),
                ProductName = row.Field<string>("productname"),
                LicensePlate = row.Field<string>("licenseplate"),
                VehicleType = row.Field<string>("vehicletype"),
                OperatorName = row.Field<string>("operatorname"),
                StartLocation = row.Field<string>("startlocation"),
                EndLocation = row.Field<string>("endlocation"),
                Quantity = row.Field<int>("quantity"),
                OrderDate = row.Field<DateTime>("orderdate")
            };
            _ordersList.Add(order);
        }
        BindingContext = this; // Bind the ViewModel to the UI
        return _ordersList;
    }

    private void DisplayData()
    {
        // Display the data in your UI
        // For example, you can bind it to a ListView or any other control
        // listView.ItemsSource = result.DefaultView;
    }
}
