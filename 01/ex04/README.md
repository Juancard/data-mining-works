## Exercise 04
# ETL proccess: Via Pentaho tool

## Table of Contents
- [Description](#description)
- [Tools](#tools)
- [Installation](#installation)
  - [Prepare Kettle](#prepare-kettle)
  - [Database Configuration](#database-configuration)
  - [Excel file](#excel-file-download)
  - [Set Kettle variables](#set-configuration-variables)
- [Run](#run)

### Description
This script does the same job as in exercise 01, that is, takes an excel file and save its data in a database.

This time though, the described ETL process will be handled by a Pentaho tool called Spoon or Kettle.


### Tools:
  - [Pentaho Kettle](http://community.pentaho.com/projects/data-integration/)
  - [Postgresql](https://www.postgresql.org/download/)

### Installation

#### Prepare Kettle

1. Open Kettle tool by running:
```bash
.[/path/to/]/data-integration/spoon.sh
```
You can download it from the official page (link is up here, under 'Tools' section).
2. Open job file (with `.kjb`) found in this repo

#### Database configuration
1. Create an empty postgresql database:
```bash
createdb my_db_name
```
 Make sure your user has the needed permissions to run this command.
2. Then go to Kettle and enter your db credentials, that is, go to `View` tab, then double clik on `Database Connections`.

#### Excel file download
Download the excel file and save it anywhere in your file system:
- [Medios.xls](https://drive.google.com/open?id=0B13cNeaiufwVdFFXdzM3VnZyV0E)


#### Set configuration variables
1. Open `config.properties` file and fill the appropiate key with the excel file path:
```bash
medios_filepath=[/your/path/to]/Medios.xls
```
2. Rename `config.properties.example` file to `config.properties`

### Run
Go to Kettle again and press `F9`, or go to `Action -> Run`

### Enjoy!
