import React from 'react';
import { DashboardLayout } from './components/layout/DashboardLayout';
import { StatCard } from './components/dashboard/StatCard';
import { Truck, Users, MapPin, Fuel, AlertTriangle, CheckCircle2 } from 'lucide-react';

function App() {
  const stats = [
    {
      title: 'Active Vehicles',
      value: '24',
      icon: Truck,
      trend: { value: 12, isPositive: true }
    },
    {
      title: 'Active Drivers',
      value: '18',
      icon: Users,
      trend: { value: 8, isPositive: true }
    },
    {
      title: 'Routes Today',
      value: '32',
      icon: MapPin,
      trend: { value: 5, isPositive: false }
    },
    {
      title: 'Fuel Efficiency',
      value: '92%',
      icon: Fuel,
      trend: { value: 3, isPositive: true }
    }
  ];

  const recentRoutes = [
    { id: 1, name: 'NYC to Boston', driver: 'John Smith', status: 'in-progress' },
    { id: 2, name: 'Miami to Orlando', driver: 'Sarah Johnson', status: 'completed' },
    { id: 3, name: 'LA to San Francisco', driver: 'Mike Brown', status: 'planned' },
  ];

  const vehicleStatuses = [
    { id: 1, name: 'Truck #1234', status: 'active', fuel: '75%' },
    { id: 2, name: 'Van #5678', status: 'maintenance', fuel: '45%' },
    { id: 3, name: 'Truck #9012', status: 'active', fuel: '90%' },
  ];

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Welcome back, Alex!</h1>
          <p className="mt-1 text-sm text-gray-600">
            Here's what's happening with your fleet today.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {stats.map((stat) => (
            <StatCard key={stat.title} {...stat} />
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-lg font-bold text-gray-900">Recent Routes</h2>
              <a href="#routes" className="text-sm text-primary hover:underline">View all</a>
            </div>
            <div className="space-y-4">
              {recentRoutes.map((route) => (
                <div key={route.id} className="flex items-center justify-between p-4 rounded-lg bg-gray-50">
                  <div>
                    <h3 className="font-medium text-gray-900">{route.name}</h3>
                    <p className="text-sm text-gray-600">{route.driver}</p>
                  </div>
                  <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                    route.status === 'completed' ? 'bg-green-100 text-green-700' :
                    route.status === 'in-progress' ? 'bg-blue-100 text-blue-700' :
                    'bg-gray-100 text-gray-700'
                  }`}>
                    {route.status}
                  </span>
                </div>
              ))}
            </div>
          </div>

          <div className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-lg font-bold text-gray-900">Vehicle Status</h2>
              <a href="#vehicles" className="text-sm text-primary hover:underline">View all</a>
            </div>
            <div className="space-y-4">
              {vehicleStatuses.map((vehicle) => (
                <div key={vehicle.id} className="flex items-center justify-between p-4 rounded-lg bg-gray-50">
                  <div className="flex items-center gap-3">
                    {vehicle.status === 'active' ? (
                      <CheckCircle2 className="w-5 h-5 text-green-500" />
                    ) : (
                      <AlertTriangle className="w-5 h-5 text-amber-500" />
                    )}
                    <div>
                      <h3 className="font-medium text-gray-900">{vehicle.name}</h3>
                      <p className="text-sm text-gray-600">Fuel Level: {vehicle.fuel}</p>
                    </div>
                  </div>
                  <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                    vehicle.status === 'active' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'
                  }`}>
                    {vehicle.status}
                  </span>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
}

export default App;