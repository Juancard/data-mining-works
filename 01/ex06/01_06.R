# sudo apt-get install libpq-dev
# install.packages("RPostgreSQL")
require("RPostgreSQL")

# Change directory to this script folder
# install.packages("rstudioapi")
# WARNING: Will only work if executed in RStudio
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Configuration variables (db & stuff)
source('config.R')

# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")

# creates a connection to the postgres database
con <- dbConnect(drv, dbname = db_name,
                 host = db_host, port = db_port,
                 user = db_user, password = db_pass)
rm(db_pass) # removes the password
rm(user)
# check for the table before loading
dbExistsTable(con, "rendimiento_estudiantes")
# TRUE
