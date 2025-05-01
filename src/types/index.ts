export interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'manager' | 'operator';
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
  documents: Document[];
}

export interface TransportOrder {
  id: string;
  internalNumber: string;
  cartaPorteFolio: string;
  clientId: string;
  status: 'pending' | 'in_transit' | 'delivered' | 'returned';
  cargoType: string;
  destination: string;
  deliveryDate: Date;
  operatorId: string;
  vehicleId: string;
  proofOfDelivery?: ProofOfDelivery;
  expenses: Expense[];
  createdAt: Date;
  updatedAt: Date;
}

export interface ProofOfDelivery {
  id: string;
  orderId: string;
  signature: string;
  photos: string[];
  geolocation: {
    latitude: number;
    longitude: number;
  };
  notes: string;
  incidents: Incident[];
  deliveredAt: Date;
}

export interface Expense {
  id: string;
  orderId: string;
  category: 'fuel' | 'tolls' | 'lodging' | 'food' | 'maintenance' | 'fines' | 'other';
  amount: number;
  description: string;
  receiptPhoto?: string;
  createdAt: Date;
}

export interface Incident {
  id: string;
  orderId: string;
  type: string;
  description: string;
  photos: string[];
  createdAt: Date;
}

export interface Document {
  id: string;
  type: string;
  number: string;
  expirationDate: Date;
  file: string;
  entityId: string;
  entityType: 'vehicle' | 'operator';
}