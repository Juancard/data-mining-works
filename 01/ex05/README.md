## Exercise 05
# ETL proccess: Shedulling Pentaho

## Table of Contents
- [Description](#description)
- [Tools](#tools)
- [Installation](#installation)
  - [Prepare Kettle](#prepare-kettle)
  - [Database Configuration](#database-configuration)
  - [Excel file](#excel-file-download)
  - [Set Kettle variables](#set-kettle-variables)
  - [Set scheduller script](#set-scheduller-script)

### Description
This exercise extends the previous one by running the job in exercise 04 every day at 14:00 hs, but only if the Medios file is found on disk.


### Tools:
  - [Pentaho Kettle](http://community.pentaho.com/projects/data-integration/)
  - [Postgresql](https://www.postgresql.org/download/)
  - [Crontab](http://kvz.io/blog/2007/07/29/schedule-tasks-on-linux-using-crontab/)

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


#### Set Kettle variables
1. Open `config.properties.example` file and fill the appropiate keys with the excel file path and the path to the exercise 04 job file:
```bash
medios_filepath=/your/path/to/Medios.xls
ex04_job=[/your/path/to]/data-mining-works/01/ex04/pw1_ex4.kjb
```

2. Rename `config.properties.example` file to `config.properties`

#### Set scheduller script
1. Open the `.sh` file under this repo directory and set the variable `SPOON_DIR` to the path where Pentaho data integration was downloaded. In my case, this is in my user home directory.

2. Create a log file, this is where the errors will go when the OS run the `.sh` script.
```bash
  touch scheduller.log
```

3. Run the following command in shell:
```bash
  crontab -e
```

4. Add this line to the end of the file:
```bash
  0 14 * * * [/path/to]/data-mining-works/01/ex05/scheduller.sh >> [/path/to]/data-mining-works/01/ex05/scheduller.log 2>&1
```
Make sure [/path/to] is set to the value corresponding to the place where you saved this data mining repo.

### Enjoy!
