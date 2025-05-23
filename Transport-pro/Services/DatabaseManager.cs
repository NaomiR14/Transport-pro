using Microsoft.Extensions.Logging;
using NLog;
using Npgsql;
using System.Data;

namespace Transport_pro.Services;

public class DatabaseManager
{
    private static readonly Logger Logger = LogManager.GetCurrentClassLogger();
    private readonly string _connectionString;
    private readonly NpgsqlDataSource _dataSource;

    public DatabaseManager(string connectionString)
    {
        _connectionString = connectionString;

        // Initialize the _connection field to avoid CS8618
        //_connection = NpgsqlDataSource.Create(_connectionString);

        var dataSourceBuilder = new NpgsqlDataSourceBuilder(_connectionString);

        _dataSource = dataSourceBuilder.Build();
    }

    public async Task ExecuteCommandAsync(string query)
    {
        try
        {
            await using var command = _dataSource.CreateCommand(query);
            command.CommandTimeout = 30; // Set a timeout to prevent indefinite execution
            await command.ExecuteNonQueryAsync().ConfigureAwait(false); //prevents blocking main thread
        }
        catch (Exception ex)
        {
            Logger.Error(ex, "Error executing command: {Query}", query);
            throw; // Re-throw the exception after logging
        }
    }

    public async Task<int> ExecuteStoredProcedureAsync(string procedureName, Dictionary<string, object> parameters)
    {
        using var connection = new NpgsqlConnection(_connectionString);
        await connection.OpenAsync();

        using var command = new NpgsqlCommand(procedureName, connection)
        {
            CommandType = CommandType.StoredProcedure
        };

        // Add parameters
        foreach (var param in parameters)
        {
            command.Parameters.AddWithValue(param.Key, param.Value);
        }

        return await command.ExecuteNonQueryAsync();
    }

    public async Task<NpgsqlDataReader> ExecuteFunctionAsync(string functionName)
    {
        try
        {
            // For functions
            using var cmd = _dataSource.CreateCommand(functionName);
            var reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false);

            return reader;
        }
        catch (NpgsqlException ex)
        {
            Logger.Error(ex, "Error executing command: {Query}", functionName);
            throw; // Re-throw the exception after logging
        }
        
    }
    public async Task<DataTable> ExecuteFunctionAsync2(string functionName)
    {
        try
        {
            // For functions
            using var cmd = _dataSource.CreateCommand(functionName);
            using var reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false);

            var dataTable = new DataTable();
            dataTable.Load(reader);
            return dataTable;
        }
        catch (NpgsqlException ex)
        {
            Logger.Error(ex, "Error executing command: {Query}", functionName);
            throw; // Re-throw the exception after logging
        }
    }

    public void ProcessResult(NpgsqlDataReader result)
    {
        while (result.Read())
        {
            var orderid = result.GetInt32(0);
            var firstName = result.GetString(1);
            var lastName = result.GetString(2);
            var productName = result.GetString(3);
            var licensePlate = result.GetString(4);
            var vehicleType = result.GetString(5);
            var operatorName = result.GetString(6);
            var startLocation = result.GetString(7);
            var endLocation = result.GetString(8);
            var quatity = result.GetInt32(9);
            var status = result.GetString(10);
            var orderDate = result.GetDateTime(11);

            // Display the student details
            Logger.Debug($"{orderid}\t{firstName}\t{lastName}\t{productName}\t{licensePlate}\t" +
                $"{vehicleType}\t{operatorName}\t{startLocation}\t{endLocation}\t{quatity}\t" +
                $"{status}\t{orderDate}");
        }
    }
}
