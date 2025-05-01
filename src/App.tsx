import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { DashboardLayout } from './components/layout/DashboardLayout';
import { Dashboard } from './pages/Dashboard';
import { Orders } from './pages/Orders';
import { Vehicles } from './pages/Vehicles';
import { Operators } from './pages/Operators';
import { Expenses } from './pages/Expenses';
import { Incidents } from './pages/Incidents';

function App() {
  return (
    <Router>
      <DashboardLayout>
        <Routes>
          <Route path="/" element={<Navigate to="/dashboard" replace />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/orders" element={<Orders />} />
          <Route path="/vehicles" element={<Vehicles />} />
          <Route path="/operators" element={<Operators />} />
          <Route path="/expenses" element={<Expenses />} />
          <Route path="/incidents" element={<Incidents />} />
        </Routes>
      </DashboardLayout>
    </Router>
  );
}

export default App;