## Exercise 01
# ETL proccess: Scripting

## Table of Contents
- [Description](#description)
- [Tools](#tools)
- [Installation](#installation)
  - [Python modules](#python-modules-installation)
  - [Database](#database-installation)
  - [Excel file](#excel-file-download)
- [Final configuration](#final-configuration)
- [Run](#run)

### Description
This script will open an excel file and save it into a postgresql database.


### Tools:
  - [Python 2.7](https://www.python.org/downloads/)
  - [Postgresql](https://www.postgresql.org/download/)
  - [Pip](https://pypi.python.org/pypi/pip)

### Installation
#### Python modules installation
1. Install Pip to handle python modules installation:
```bash
sudo apt install python-pip
```
2. Install python modules:
```bash
sudo pip install numpy
sudo pip install pandas
sudo pip install sqlalchemy
sudo pip install xlrd
sudo pip install psicopg2
```

#### Database installation
Create an empty database:
```bash
createdb my_db_name
```
 Make sure your user has the needed permissions to run this command.

#### Excel file download
Download the excel file and save it anywhere in your file system:
- [Medios.xls](https://drive.google.com/open?id=0B13cNeaiufwVdFFXdzM3VnZyV0E)


### Final configuration
1. Rename `medios_migration.example.ini` to `medios_migration.ini`.
2. Open `medios_migration.ini` file and enter your db credentials and excel file path:
```bash
[config]
db_user=my_db_user
db_pass=my_db_pass
db_name=my_db_name
db_host=localhost # default
db_port=5432 # default
medios_excel=path/to/Medios.xls
```

### Run
```bash
  python medios_migration.py medios_migration.ini
```

### Enjoy!
