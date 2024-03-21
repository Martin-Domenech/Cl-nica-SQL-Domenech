-- Creación de la Base de datos

CREATE DATABASE IF NOT EXISTS clinica;

-- Uso la base de datos

USE clinica;

-- Creación de tablas 

CREATE TABLE IF NOT EXISTS paciente (
	id_paciente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(20) NOT NULL,
    genero CHAR(1),
    fecha_nacimiento DATE NOT NULL,
    obra_social VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS servicio (
	id_servicio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre_servicio VARCHAR(50) NOT NULL,	-- Ejemplo: cardiología
    estado VARCHAR(20) DEFAULT 'Disponible'
);

CREATE TABLE IF NOT EXISTS admininstrativo (
	id_administrativo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_servicio INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
);

CREATE TABLE IF NOT EXISTS cama (
	id_cama INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_servicio INT NOT NULL,
    estado BOOLEAN,
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
);

CREATE TABLE IF NOT EXISTS medico (
	id_medico INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_servicio INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
);

CREATE TABLE IF NOT EXISTS historia_clinica (
	id_historia_clinica INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
    fecha DATE NOT NULL,
    estado_paciente TEXT NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente)
);

CREATE TABLE IF NOT EXISTS laboratorio (
    id_laboratorio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    fecha DATE NOT NULL,
    tipo_labo VARCHAR(200) NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES historia_clinica (id_paciente)
);

CREATE TABLE IF NOT EXISTS turno (
	id_turno INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
    fecha_turno VARCHAR(10) NOT NULL,
    hora_turno VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente)
);

CREATE TABLE IF NOT EXISTS quirofano (
    id_quirofano INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    estado BOOLEAN,
    id_medico INT  
);
