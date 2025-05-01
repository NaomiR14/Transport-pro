/*
  # Transport Management System Schema

  1. New Tables
    - clientes (clients)
    - proveedores (providers)
    - conductores (drivers)
    - vehiculos (vehicles)
    - documentos (documents)
    - ordenes_transporte (transport orders)
    - pods (proof of delivery)
    - devoluciones (returns)
    - categorias_gasto (expense categories)
    - gastos (expenses)
    - liquidaciones (settlements)
    - facturas (invoices)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create enum types
CREATE TYPE estado_orden AS ENUM ('pendiente', 'en_transito', 'entregado', 'devuelto');
CREATE TYPE estado_liquidacion AS ENUM ('pendiente', 'aprobado', 'rechazado');
CREATE TYPE estado_factura AS ENUM ('pendiente', 'pagado', 'cancelado');
CREATE TYPE tipo_entidad AS ENUM ('vehiculo', 'conductor');

-- Create tables
CREATE TABLE IF NOT EXISTS clientes (
  cliente_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  nombre text NOT NULL,
  rfc text UNIQUE NOT NULL,
  direccion text,
  telefono text,
  email text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS proveedores (
  proveedor_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  nombre text NOT NULL,
  rfc text UNIQUE NOT NULL,
  tarifa_base decimal(10,2) NOT NULL DEFAULT 0,
  activo boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS conductores (
  conductor_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  nombre text NOT NULL,
  licencia text UNIQUE NOT NULL,
  telefono text,
  email text,
  activo boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS vehiculos (
  vehiculo_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  placa text UNIQUE NOT NULL,
  modelo text NOT NULL,
  tipo text NOT NULL,
  activo boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS documentos (
  documento_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  referencia_id uuid NOT NULL,
  tipo_entidad tipo_entidad NOT NULL,
  tipo_documento text NOT NULL,
  fecha_vencimiento date NOT NULL,
  url_documento text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS ordenes_transporte (
  orden_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  numero_interno text UNIQUE NOT NULL,
  folio_carta_porte text UNIQUE NOT NULL,
  cliente_id uuid REFERENCES clientes(cliente_id),
  conductor_id uuid REFERENCES conductores(conductor_id),
  vehiculo_id uuid REFERENCES vehiculos(vehiculo_id),
  proveedor_id uuid REFERENCES proveedores(proveedor_id),
  tipo_carga text NOT NULL,
  origen text NOT NULL,
  destino text NOT NULL,
  fecha_creacion timestamptz DEFAULT now(),
  fecha_entrega timestamptz,
  estado estado_orden DEFAULT 'pendiente',
  monto_total decimal(10,2) DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS pods (
  pod_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  orden_id uuid REFERENCES ordenes_transporte(orden_id),
  firma_digital text NOT NULL,
  url_fotos text[],
  notas text,
  fecha_registro timestamptz DEFAULT now(),
  geolocalizacion point,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS devoluciones (
  devolucion_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  orden_id uuid REFERENCES ordenes_transporte(orden_id),
  cantidad integer NOT NULL,
  motivo text NOT NULL,
  evidencias text[],
  fecha_registro timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS categorias_gasto (
  categoria_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  nombre text NOT NULL,
  descripcion text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS gastos (
  gasto_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  orden_id uuid REFERENCES ordenes_transporte(orden_id),
  categoria_id uuid REFERENCES categorias_gasto(categoria_id),
  monto decimal(10,2) NOT NULL,
  comprobante_url text,
  descripcion text,
  fecha_registro timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS liquidaciones (
  liquidacion_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  orden_id uuid REFERENCES ordenes_transporte(orden_id),
  deposito_inicial decimal(10,2) NOT NULL DEFAULT 0,
  gastos_comprobados decimal(10,2) NOT NULL DEFAULT 0,
  saldo_final decimal(10,2) NOT NULL DEFAULT 0,
  pago_operador decimal(10,2) NOT NULL DEFAULT 0,
  descuentos decimal(10,2) NOT NULL DEFAULT 0,
  estado estado_liquidacion DEFAULT 'pendiente',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS facturas (
  factura_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  orden_id uuid REFERENCES ordenes_transporte(orden_id),
  folio text UNIQUE NOT NULL,
  subtotal decimal(10,2) NOT NULL,
  iva decimal(10,2) NOT NULL,
  total decimal(10,2) NOT NULL,
  estado estado_factura DEFAULT 'pendiente',
  fecha_emision timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE proveedores ENABLE ROW LEVEL SECURITY;
ALTER TABLE conductores ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehiculos ENABLE ROW LEVEL SECURITY;
ALTER TABLE documentos ENABLE ROW LEVEL SECURITY;
ALTER TABLE ordenes_transporte ENABLE ROW LEVEL SECURITY;
ALTER TABLE pods ENABLE ROW LEVEL SECURITY;
ALTER TABLE devoluciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE categorias_gasto ENABLE ROW LEVEL SECURITY;
ALTER TABLE gastos ENABLE ROW LEVEL SECURITY;
ALTER TABLE liquidaciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE facturas ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Enable read access for authenticated users" ON clientes
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON proveedores
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON conductores
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON vehiculos
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON documentos
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON ordenes_transporte
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON pods
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON devoluciones
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON categorias_gasto
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON gastos
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON liquidaciones
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON facturas
  FOR SELECT TO authenticated USING (true);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_ordenes_cliente ON ordenes_transporte(cliente_id);
CREATE INDEX IF NOT EXISTS idx_ordenes_conductor ON ordenes_transporte(conductor_id);
CREATE INDEX IF NOT EXISTS idx_ordenes_vehiculo ON ordenes_transporte(vehiculo_id);
CREATE INDEX IF NOT EXISTS idx_ordenes_estado ON ordenes_transporte(estado);
CREATE INDEX IF NOT EXISTS idx_documentos_referencia ON documentos(referencia_id, tipo_entidad);
CREATE INDEX IF NOT EXISTS idx_gastos_orden ON gastos(orden_id);
CREATE INDEX IF NOT EXISTS idx_liquidaciones_orden ON liquidaciones(orden_id);
CREATE INDEX IF NOT EXISTS idx_facturas_orden ON facturas(orden_id);