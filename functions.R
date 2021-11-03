data_input = function(base, sep = "|") {
  return(read_delim(base, delim = sep))
}

filenames = function(base_array) {
  len = length(base_array)
  aux = list()
  for (i in 1:len) {
    aux[[i]] = str_extract(base_array[i], "......._....")
  }
  return(aux)
}

data_input_par = function(base_array, ncores = 0){
  
  names_base = filenames(base_array)
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

column_to_rows = function(base_array, ncores = 0){
  names_base = filenames(base_array)
  len = length(base_array)
  aux = data_input_par(base_array)
  columns = list()
  for (i in 1:len){
    column_names = colnames(aux[[i]]);
    columns[[i]] = as.data.frame(column_names)
    names(columns[[i]]) <-c(toString(names_base[[i]]))
  }
  return(columns)
}

merge_columns = function(base_array) {
  max.rows <- max(unlist(lapply(base_array, nrow), use.names = F))
  base_array <- lapply(base_array, function(x) {
    na.count <- max.rows - nrow(x)
    if (na.count > 0L) {
      na.dm <- matrix(NA, na.count, ncol(x))
      colnames(na.dm) <- colnames(x)
      rbind(x, na.dm)
    } else {
      x
    }
  })
  do.call(cbind, base_array)
}