import React from 'react';
import { Menu, LogOut, Truck, MapPin, Fuel, Users, Settings, BarChart, Box } from 'lucide-react';

interface DashboardLayoutProps {
  children: React.ReactNode;
}

export function DashboardLayout({ children }: DashboardLayoutProps) {
  const [sidebarOpen, setSidebarOpen] = React.useState(true);

  const menuItems = [
    { icon: BarChart, label: 'Dashboard', href: '#dashboard' },
    { icon: Truck, label: 'Vehicles', href: '#vehicles' },
    { icon: Users, label: 'Drivers', href: '#drivers' },
    { icon: MapPin, label: 'Routes', href: '#routes' },
    { icon: Fuel, label: 'Fuel', href: '#fuel' },
    { icon: Box, label: 'Resources', href: '#resources' },
    { icon: Settings, label: 'Settings', href: '#settings' },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Mobile menu button */}
      <button
        onClick={() => setSidebarOpen(!sidebarOpen)}
        className="lg:hidden fixed top-4 left-4 z-50 p-2 rounded-lg bg-gray-800 text-white"
      >
        <Menu size={20} />
      </button>

      {/* Sidebar */}
      <aside
        className={`fixed top-0 left-0 z-40 w-64 h-screen transition-transform duration-300 ease-in-out ${
          sidebarOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        <div className="h-full px-3 py-4 overflow-y-auto bg-gray-800 custom-scrollbar">
          <div className="flex items-center gap-2 mb-8 px-2">
            <div className="p-1.5 rounded-lg bg-primary">
              <Truck className="w-6 h-6 text-white" />
            </div>
            <div>
              <h1 className="text-xl font-bold text-white">TransportPro</h1>
              <p className="text-xs text-gray-400">Fleet Management Solution</p>
            </div>
          </div>

          <nav className="space-y-1">
            {menuItems.map((item) => (
              <a
                key={item.label}
                href={item.href}
                className="nav-item flex items-center px-2 py-3 text-gray-300 rounded-lg hover:bg-primary/10 hover:text-primary-foreground group"
              >
                <item.icon className="w-5 h-5 mr-3" />
                <span className="font-medium">{item.label}</span>
              </a>
            ))}
          </nav>

          <div className="absolute bottom-0 left-0 w-full p-4">
            <div className="p-4 rounded-lg bg-gray-700/50 mb-4">
              <p className="text-sm text-gray-300 mb-1">Pro Plan</p>
              <div className="h-1.5 w-full bg-gray-600 rounded-full">
                <div className="h-1.5 w-3/4 bg-primary rounded-full"></div>
              </div>
              <p className="text-xs text-gray-400 mt-1">75% of monthly usage</p>
            </div>
            <button className="flex items-center w-full px-2 py-3 text-gray-300 rounded-lg hover:bg-red-500/10 hover:text-red-500 transition-colors">
              <LogOut className="w-5 h-5 mr-3" />
              <span className="font-medium">Logout</span>
            </button>
          </div>
        </div>
      </aside>

      {/* Main content */}
      <div className={`p-4 ${sidebarOpen ? 'lg:ml-64' : ''} transition-all duration-300`}>
        <div className="p-6 rounded-xl bg-white shadow-sm min-h-[calc(100vh-2rem)] animate-fade-in">
          {children}
        </div>
      </div>
    </div>
  );
}