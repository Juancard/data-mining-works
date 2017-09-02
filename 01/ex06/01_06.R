# sudo apt-get install libpq-dev
# install.packages("RPostgreSQL")
require("RPostgreSQL")

# Change directory to this script folder
# install.packages("rstudioapi")
# WARNING: Will only work if executed in RStudio
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Configuration variables (db & stuff)
source('config.R')
db_table <- "rendimiento_estudiantes"

# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")

# creates a connection to the postgres database
con <- dbConnect(drv, dbname = db_name,
                 host = db_host, port = db_port,
                 user = db_user, password = db_pass)
rm(db_pass) # removes the password
rm(db_user)
# check for the table before loading
tableExists <- dbExistsTable(con, db_table)
if (!(tableExists)){
  stop("Table "+ db_table + " does not exists in database")
} else {
  # query the data from postgreSQL 
  rendimientos <- dbGetQuery(con, "SELECT * from " + db_table)
  
}

# close the connection
dbDisconnect(con)