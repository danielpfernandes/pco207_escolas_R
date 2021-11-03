########################################################
# AULA 27-10-2021 - DADOS DO INEP
########################################################
library(tidyverse)
library(doMC)

source("functions.R")

prefix = "ESCOLAS"
year = seq(2007, 2014, by = 1)
sufix = ".CSV"
sep = "_"
path = "Data/"
file_names = paste0(path, prefix, sep, year, sufix)

main<-function(n)
{
  if(n==1){
    print("----Test1-----")
    return(data_input_par(file_names, 4))
  }
  
  if(n==2){
    print("----Test2-----")
    columns.list = column_to_rows(file_names)
    return(merge_columns(columns.list))
  } 
}

#### CHAMADA DE FUNÇÃO ####
print("##### SCHOOL DATA INPUT #####")
ttime1 = proc.time()[3]
base = main(2) # Alterar o numero para executar um if diferente
ttime2 = proc.time()[3]

print(paste("Time:",round((ttime2-ttime1), 1),"secs"))
print(paste("Size of base:",format(object.size(base), units="Mb")))

