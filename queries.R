
library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

#Porcentaje de personas que hablan español
dbListFields(MyDataBase, 'CountryLanguage')

Español <- dbGetQuery(MyDataBase, "select * from CountryLanguage")

DataEspañol <- Español %>% filter(Language == "Spanish")
head(DataEspañol)
class(DataEspañol)

DataEspañol %>% ggplot(aes(x =CountryCode, y=Percentage, fill = IsOfficial)) + 
  geom_bin2d() +
  coord_flip() +
  ylab("Porcentaje") +
  xlab("Código de pais") + 
  theme_dark()

