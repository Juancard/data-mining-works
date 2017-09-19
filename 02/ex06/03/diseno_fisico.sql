DROP TABLE IF EXISTS ventas_h, fechas_d, productos_d, clientes_d;

CREATE TABLE fechas_d(
    id_fecha int PRIMARY KEY,
    ano int,
    mes int,
    dia int
);
CREATE TABLE productos_d (
    codigo_producto int PRIMARY KEY,
    descripcion VARCHAR(50),
    categoria VARCHAR(15),
    marca VARCHAR(25),
    especificaciones VARCHAR(50),
    precio_unitario int
);
CREATE TABLE clientes_d (
    codigo_cliente int PRIMARY KEY,
    razon_social varchar(50),
    cuit varchar(15),
    saldo_cuenta int,
    condicion varchar(25)
);
CREATE TABLE ventas_h (
	codigo_cliente int REFERENCES clientes_d,
	codigo_producto int REFERENCES productos_d,
	id_fecha int REFERENCES fechas_d,
	cant_vendida int,
	total_monto int
);
