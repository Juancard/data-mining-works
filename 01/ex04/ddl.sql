DROP TABLE IF EXISTS Medios, Especialidades, Tipos_medio, Ciudades, Provincias;

CREATE TABLE Provincias(
    id int PRIMARY KEY ,
    nombre varchar(25)
);
CREATE TABLE Ciudades (
    id int PRIMARY KEY,
    nombre varchar(50),
    id_provincia int REFERENCES Provincias,
    UNIQUE (id, nombre, id_provincia)
);
CREATE TABLE Especialidades (
    id int PRIMARY KEY,
    descripcion varchar(50)
);
CREATE TABLE Tipos_medio (
    id int PRIMARY KEY,
    descripcion varchar(50)
);

CREATE TABLE Medios (
    id int PRIMARY KEY,
    nombre varchar(100),
    id_especialidad int REFERENCES Especialidades,
    id_tipo_medio int REFERENCES Tipos_medio,
    direccion varchar(200),
    id_ciudad int REFERENCES Ciudades
);
