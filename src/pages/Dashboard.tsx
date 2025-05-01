import React from 'react';
import { StatCard } from '../components/dashboard/StatCard';
import { Truck, Users, FileText, AlertTriangle, CheckCircle2 } from 'lucide-react';

export function Dashboard() {
  const stats = [
    {
      title: 'Órdenes Activas',
      value: '24',
      icon: FileText,
      trend: { value: 12, isPositive: true }
    },
    {
      title: 'Vehículos en Ruta',
      value: '18',
      icon: Truck,
      trend: { value: 8, isPositive: true }
    },
    {
      title: 'Operadores Activos',
      value: '15',
      icon: Users,
      trend: { value: 5, isPositive: true }
    },
    {
      title: 'Incidentes Pendientes',
      value: '3',
      icon: AlertTriangle,
      trend: { value: 2, isPositive: false }
    }
  ];

  const recentOrders = [
    { id: 1, number: 'OT-2024-001', client: 'Logística Express', status: 'in_transit' },
    { id: 2, number: 'OT-2024-002', client: 'Transportes México', status: 'pending' },
    { id: 3, number: 'OT-2024-003', client: 'Carga Segura SA', status: 'delivered' },
  ];

  const activeVehicles = [
    { id: 1, name: 'Kenworth T680', plate: 'ABC-123', status: 'active', location: 'CDMX - MTY' },
    { id: 2, name: 'Freightliner Cascadia', plate: 'XYZ-789', status: 'maintenance' },
    { id: 3, name: 'Volvo VNL', plate: 'DEF-456', status: 'active', location: 'GDL - CDMX' },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">¡Bienvenido al Sistema!</h1>
        <p className="mt-1 text-sm text-gray-600">
          Aquí está el resumen de las operaciones actuales.
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
            <h2 className="text-lg font-bold text-gray-900">Órdenes Recientes</h2>
            <a href="/orders" className="text-sm text-primary hover:underline">Ver todas</a>
          </div>
          <div className="space-y-4">
            {recentOrders.map((order) => (
              <div key={order.id} className="flex items-center justify-between p-4 rounded-lg bg-gray-50">
                <div>
                  <h3 className="font-medium text-gray-900">{order.number}</h3>
                  <p className="text-sm text-gray-600">{order.client}</p>
                </div>
                <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                  order.status === 'delivered' ? 'bg-green-100 text-green-700' :
                  order.status === 'in_transit' ? 'bg-blue-100 text-blue-700' :
                  'bg-yellow-100 text-yellow-700'
                }`}>
                  {order.status === 'delivered' ? 'Entregado' :
                   order.status === 'in_transit' ? 'En Tránsito' : 'Pendiente'}
                </span>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-lg font-bold text-gray-900">Vehículos Activos</h2>
            <a href="/vehicles" className="text-sm text-primary hover:underline">Ver todos</a>
          </div>
          <div className="space-y-4">
            {activeVehicles.map((vehicle) => (
              <div key={vehicle.id} className="flex items-center justify-between p-4 rounded-lg bg-gray-50">
                <div className="flex items-center gap-3">
                  {vehicle.status === 'active' ? (
                    <CheckCircle2 className="w-5 h-5 text-green-500" />
                  ) : (
                    <AlertTriangle className="w-5 h-5 text-amber-500" />
                  )}
                  <div>
                    <h3 className="font-medium text-gray-900">{vehicle.name}</h3>
                    <p className="text-sm text-gray-600">Placa: {vehicle.plate}</p>
                    {vehicle.location && (
                      <p className="text-xs text-gray-500">Ruta: {vehicle.location}</p>
                    )}
                  </div>
                </div>
                <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                  vehicle.status === 'active' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'
                }`}>
                  {vehicle.status === 'active' ? 'Activo' : 'Mantenimiento'}
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}