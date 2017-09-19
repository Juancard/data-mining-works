DROP TABLE IF EXISTS estudiantes_h, planes_estudio, condiciones, sedes, sexos, anos_ingreso, carreras;

CREATE TABLE sedes(
    id_sede int PRIMARY KEY ,
    nombre varchar(25)
);
CREATE TABLE condiciones (
    id_condicion int PRIMARY KEY,
    nombre varchar(50)
);
CREATE TABLE sexos (
    id_sexo int PRIMARY KEY,
    nombre varchar(25)
);
CREATE TABLE anos_ingreso (
    id_ano_ingreso int PRIMARY KEY,
    ano_ingreso int
);

CREATE TABLE carreras (
    id_carrera int PRIMARY KEY,
    denominacion varchar(50),
    ano_creaciona int
);

CREATE TABLE planes_estudio (
    id_plan int PRIMARY KEY,
    resolucion varchar(25),
    id_carrera int REFERENCES carreras,
    activos int,
    fecha_alta timestamp
);

CREATE TABLE estudiantes_h (
    id_plan int REFERENCES planes_estudio,
    id_sede int REFERENCES sedes,
    id_ano_ingreso int REFERENCES anos_ingreso,
    id_sexo int REFERENCES sexos,
    id_condicion int REFERENCES condiciones,
    cantidad_estudiantes int,
    PRIMARY KEY(id_plan, id_sede, id_ano_ingreso, id_sexo, id_condicion)
);
