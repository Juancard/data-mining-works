DROP TABLE IF EXISTS rendimiento_estudiantes;
CREATE TABLE rendimiento_estudiantes(
	legajo INT PRIMARY KEY,
	codigo_carrera INT,
	nombre_carrera VARCHAR(50),
	cantidad_cursadas INT,
	cantidad_aprobadas INT,
	promedio NUMERIC
);
