using Microsoft.Extensions.Logging;
using NLog;
using NLog.Extensions.Logging;

namespace Transport_pro
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var logger = NLog.LogManager.Setup().RegisterMauiLog()
            .LoadConfiguration(c => c.ForLogger().FilterMinLevel(NLog.LogLevel.Debug).WriteToMauiLog()) // Alternative use LoadConfigurationFromAssemblyResource()
            .GetCurrentClassLogger();

            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                });
            
            // Add NLog for Logging
            builder.Logging.ClearProviders();
            builder.Logging.AddNLog();


#if DEBUG
            builder.Logging.AddDebug();
#endif

            return builder.Build();
        }
    }
}
