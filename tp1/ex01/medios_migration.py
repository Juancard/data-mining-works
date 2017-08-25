# coding: utf-8

import numpy as np
import pandas as pd
from sqlalchemy import *
import ConfigParser
import sys
import os

def getParameters():
    out = []
    try:
        if os.path.isfile(sys.argv[1]):
            out.append(sys.argv[1])
        else:
            print "Error in '.ini' file: not a valid file path"
    except OSError, e:
        print e
        sys.exit()
    except IndexError:
        print """Uso:
        {0} /path/a/medios_migration.ini""".format(sys.argv[0])
        sys.exit()
    return out

def loadIni(iniFilePath):
    Config = ConfigParser.ConfigParser()
    Config.read(iniFilePath)
    iniData = {}
    sections = Config.sections()
    for option in Config.options(sections[0]):
        opValue = Config.get(sections[0], option)
        iniData[option] = opValue if opValue != -1 else False;
    return iniData

if __name__ == "__main__":
    iniFilePath = getParameters()[0]
    iniData = loadIni(iniFilePath)
    print iniData

    print "Loading medios excel at: ", iniData['medios_excel']
    medios = pd.read_excel(
        iniData['medios_excel'],
        encoding='utf-8'
    )
    medios = medios[
        [
            "ID del medio",
            "Medio",
            "Provincia",
            "Ciudad",
            "Tipo de medio",
            "Especialidad",
            "Dirección".decode('UTF-8')
        ]
    ]

    db_url = "postgresql://{}:{}@{}:{}/{}".format(
        iniData['db_user'],
        iniData['db_pass'],
        iniData['db_host'],
        iniData['db_port'],
        iniData['db_name']
    )
    print "Setting up connection to db at: ", db_url
    engine = create_engine(db_url)

    # Fills provincias table
    print "Filling 'provincias' table"
    with engine.connect() as con:
        con.execute('DROP TABLE IF EXISTS provincias CASCADE;')

    provincias = pd.DataFrame(data = medios["Provincia"].unique(), columns=["nombre"])
    provincias["id"] = provincias.index + 1
    provincias.to_sql("provincias", engine, if_exists="replace", index=False, index_label="id")

    # workaround to add primary key
    with engine.connect() as con:
        con.execute('ALTER TABLE provincias ADD PRIMARY KEY (id);')


    # FILLS ciudades TABLE in DB
    print "Filling 'ciudades' table"
    with engine.connect() as con:
        con.execute('DROP TABLE IF EXISTS ciudades CASCADE;')

    ciudadesUnique = medios[['Provincia', 'Ciudad']].reset_index(drop=True).drop_duplicates()
    ciudades = pd.merge(
        ciudadesUnique,
        provincias,
        how='inner',
        left_on="Provincia",
        right_on="nombre"
    )[["Ciudad", "id"]]
    ciudades.columns = ["nombre", "id_provincia"]
    ciudades["id"] = ciudades.index + 1
    ciudades.to_sql("ciudades", engine, if_exists="replace", index=False, index_label="id")

    # workaround to add primary key
    with engine.connect() as con:
        con.execute('ALTER TABLE ciudades ADD PRIMARY KEY (id);')
        con.execute('ALTER TABLE ciudades ADD FOREIGN KEY (id_provincia) REFERENCES provincias(id);')


    # Fills especialidades table
    print "Filling 'especialidades' table"
    with engine.connect() as con:
        con.execute('DROP TABLE IF EXISTS especialidades CASCADE;')

    especialidades = pd.DataFrame(data = medios["Especialidad"].unique(), columns=["descripcion"])
    especialidades["id"] = especialidades.index + 1
    especialidades.to_sql("especialidades", engine, if_exists="replace", index=False, index_label="id")

    # workaround to add primary key
    with engine.connect() as con:
        con.execute('ALTER TABLE especialidades ADD PRIMARY KEY (id);')


    # Fills tipos_medio table
    print "Filling 'tipos_medio' table"
    with engine.connect() as con:
        con.execute('DROP TABLE IF EXISTS tipos_medio CASCADE;')

    tipos_medio = pd.DataFrame(data = medios["Tipo de medio"].unique(), columns=["descripcion"])
    tipos_medio["id"] = tipos_medio.index + 1
    tipos_medio.to_sql("tipos_medio", engine, if_exists="replace", index=False, index_label="id")

    # workaround to add primary key
    with engine.connect() as con:
        con.execute('ALTER TABLE tipos_medio ADD PRIMARY KEY (id);')

    # Setting up medios values to send to db
    print "Setting up 'medios' table"

    # setting up especialidades
    id_especialidad = pd.merge(
        medios,
        especialidades,
        how='inner',
        left_on="Especialidad",
        right_on="descripcion"
    )[["ID del medio", "id"]]
    id_especialidad.set_index("ID del medio", drop=True, inplace=True)
    id_especialidad.columns.values[0] = "id_especialidad"

    # setting up tipo medio
    id_tipo_medio = pd.merge(
        medios,
        tipos_medio,
        how='inner',
        left_on="Tipo de medio",
        right_on="descripcion"
    )[["ID del medio", "id"]]
    id_tipo_medio.set_index("ID del medio", drop=True, inplace=True)
    id_tipo_medio.columns.values[0] = "id_tipo_medio"

    # setting up ciudades
    id_provincia = pd.merge(
        medios,
        provincias,
        how='inner',
        left_on="Provincia",
        right_on="nombre"
    )[["ID del medio", "id", "Ciudad"]]
    id_provincia.columns.values[1] = "id_provincia"

    id_ciudad = pd.merge(
        id_provincia,
        ciudades,
        how='inner',
        left_on=["id_provincia", "Ciudad"],
        right_on=["id_provincia", "nombre"]
    )[["ID del medio", "id_provincia", "id"]]

    id_ciudad.set_index("ID del medio", drop=True, inplace=True)
    id_ciudad.columns.values[len(id_ciudad.columns)-1] = "id_ciudad"


    # Setting up final medios table to send to db

    mediosTable = medios[["ID del medio", "Medio", "Dirección".decode('UTF-8')]]
    mediosTable.columns = ["id", "nombre", "direccion"]
    mediosTable.set_index("id", drop=True, inplace=True)

    toJoin = [id_especialidad, id_tipo_medio, id_ciudad]
    mediosTable = mediosTable.join(toJoin).reset_index()


    # send to db
    print "Filling 'medios' table"
    mediosTable.to_sql("medios", engine, if_exists="replace", index=False, index_label="id")

    # workaround to add primary key
    with engine.connect() as con:
        con.execute('ALTER TABLE medios ADD PRIMARY KEY (id);')
        con.execute('ALTER TABLE medios ADD FOREIGN KEY (id_especialidad) REFERENCES especialidades(id);')
        con.execute('ALTER TABLE medios ADD FOREIGN KEY (id_tipo_medio) REFERENCES tipos_medio(id);')
        con.execute('ALTER TABLE medios ADD FOREIGN KEY (id_ciudad) REFERENCES ciudades(id);')

    print "*" * 30
    print "*" * 10, "SUCCESS ", "*" * 10
    print "*" * 30
