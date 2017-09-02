## Exercise 02
# ETL proccess using Pentaho: Cursadas

## Table of Contents
- [Description](#description)
- [Tools](#tools)
- [Installation](#installation)
  - [Prepare Kettle](#prepare-kettle)
  - [Database Configuration](#database-configuration)
  - [Txt file](#txt-file-download)
  - [Set Kettle variables](#set-kettle-variables)
- [Run](#run)

### Description
The aim is to load data from a database, transform it and send it to another database using a Pentaho tool called Kettle.

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
1. Download the source database:
  - [01-02-cursadas1_2003.backup](https://drive.google.com/open?id=0B13cNeaiufwValRKcnlqU1F6X00).
2. Create an empty database to load this data into:
```bash
  createdb source_db
```
3. Run the following command in Linux shell:
```bash
  psql -d source_db -a -f  [/path/to]/01-02-cursadas1_2003.backup
```
Make sure [/path/to] is the path where you downloaded the source database.
4. Create another empty postgresql database to be the destination database:
```bash
createdb destination_db
```
 Make sure your user has the needed permissions to run this command.

5. Finally go to Kettle and enter the db credentials for both databases. That is, go to `View` tab, then double clik on `Database Connections`.

#### Txt file download
This ETL process involve reading from both database and a `.txt` file.
Download the txt file and save it anywhere in your file system:
- [01-02-planes.txt](https://drive.google.com/file/d/0B13cNeaiufwVWERXOXFReVJMVWM/view?usp=sharing)


#### Set Kettle variables
1. Open `config.properties.example` file and fill the appropiate key with the txt file path:
```bash
txt_carreras=/your/path/to/01-02-planes.txt
```
Make sure [/your/path/to] is the place where you downloaded the `.txt` file.

2. Rename the file `config.properties.example` to `config.properties`.

### Run
Go to Kettle again and press `F9`, or go to `Action -> Run`

### Enjoy!
