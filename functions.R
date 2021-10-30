data_input = function(base, sep = "|") {
  return(read_delim(base, delim = sep))
}

names = function(base_array) {
  len = length(base_array)
  aux = list()
  for (i in 1:len) {
    aux[[i]] = str_extract(base_array[i], "......._....")
  }
  return(aux)
}

data_input_par = function(base_array, ncores = 0){
  
  browser()
  names_base = names(base_array)
  len = length(base_array)
  aux = list()  
  if ((ncores) & (len>1)){
    print(paste("Doing it parallel with", ncores, "cores"))
    registerDoMC(ncores)
    aux = foreach(i = 1:len) %dopar% {
      data_input(base_array[i])
    }
  }else{
    print(paste("Doing it sequential..."))
    for (i in 1:len){
      aux[[i]] = data_input(base_array[i])
    }
  }
  return(aux)
  
}