
#### **📄 database/schema.sql**
```sql
-- FleetFlow Database Schema
CREATE DATABASE IF NOT EXISTS fleetflow;
USE fleetflow;

-- Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('manager', 'dispatcher', 'safety_officer', 'financial_analyst') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Vehicles Table
CREATE TABLE vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type ENUM('Truck', 'Van', 'Bike') NOT NULL,
    capacity_kg DECIMAL(10,2) NOT NULL,
    odometer_km INT DEFAULT 0,
    status ENUM('Available', 'On Trip', 'In Shop', 'Out of Service') DEFAULT 'Available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Drivers Table
CREATE TABLE drivers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    license_category ENUM('Truck', 'Van', 'Bike') NOT NULL,
    license_expiry DATE NOT NULL,
    safety_score INT DEFAULT 100,
    status ENUM('Available', 'On Duty', 'Off Duty', 'Suspended') DEFAULT 'Available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trips Table
CREATE TABLE trips (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    driver_id INT NOT NULL,
    origin VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    cargo_weight_kg DECIMAL(10,2) NOT NULL,
    status ENUM('Draft', 'Dispatched', 'Completed', 'Cancelled') DEFAULT 'Draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id),
    FOREIGN KEY (driver_id) REFERENCES drivers(id)
);

-- Sample Data
INSERT INTO users (email, full_name, role) VALUES
('demo@fleetflow.com', 'Demo User', 'manager');

INSERT INTO vehicles (name, license_plate, vehicle_type, capacity_kg, odometer_km, status) VALUES
('Volvo Truck', 'TRK-001', 'Truck', 5000, 50000, 'Available'),
('Ford Van', 'VAN-005', 'Van', 800, 25000, 'On Trip'),
('Honda Bike', 'BIK-003', 'Bike', 100, 15000, 'In Shop');
