export interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'manager' | 'driver';
  companyId: string;
}

export interface Vehicle {
  id: string;
  plateNumber: string;
  model: string;
  type: string;
  status: 'active' | 'maintenance' | 'inactive';
  lastMaintenance: Date;
  fuelLevel: number;
}

export interface Route {
  id: string;
  name: string;
  startLocation: string;
  endLocation: string;
  status: 'planned' | 'in-progress' | 'completed';
  assignedDriver?: string;
  assignedVehicle?: string;
  estimatedDuration: number;
  actualDuration?: number;
}