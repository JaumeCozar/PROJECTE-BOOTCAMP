DROP DATABASE IF EXISTS db_kitchen;
CREATE SCHEMA IF NOT EXISTS db_kitchen;

USE db_kitchen;

-- Tabla de sectores
CREATE TABLE sectors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla de empresas
CREATE TABLE companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    ubi VARCHAR(150),
    NIF VARCHAR(15),
    tel VARCHAR(20),
    email VARCHAR(255),
    date DATE,
    sector_id INT,
    FOREIGN KEY (sector_id) REFERENCES sectors(id)
);

-- Tabla de cocinas
CREATE TABLE kitchens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    ubi VARCHAR(150),
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);

-- Tabla de usuarios
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('operario', 'comercial', 'admin') NOT NULL,
    kitchen_id INT,
    FOREIGN KEY (kitchen_id) REFERENCES kitchens(id) ON DELETE CASCADE
);

-- Tipos de comida
CREATE TABLE food_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    default_cost_per_kg DECIMAL(10,2) DEFAULT 0.00
);

-- Costes personalizados por cocina
CREATE TABLE custom_food_costs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kitchen_id INT,
    food_type_id INT,
    custom_cost_per_kg DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (kitchen_id) REFERENCES kitchens(id) ON DELETE CASCADE,
    FOREIGN KEY (food_type_id) REFERENCES food_types(id) ON DELETE CASCADE,
    UNIQUE (kitchen_id, food_type_id)
);


CREATE TABLE reasons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL UNIQUE -- The description of the reason
);
-- Registros de desperdicio (sin ON DELETE CASCADE)
CREATE TABLE waste_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    kitchen_id INT,
    food_type_id INT,
    quantity_kg DECIMAL(6,2) NOT NULL,
    reason_id INT, -- New column to link to the reasons table
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (kitchen_id) REFERENCES kitchens(id),
    FOREIGN KEY (food_type_id) REFERENCES food_types(id),
    FOREIGN KEY (reason_id) REFERENCES reasons(id) -- Foreign key constraint to the reasons table
);

-- Alertas
CREATE TABLE alerts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kitchen_id INT,
    user_role ENUM('operario', 'comercial', 'admin'),
    message TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    seen BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (kitchen_id) REFERENCES kitchens(id) ON DELETE CASCADE
);
