normalize_vector <- function(x){
  x <- (x-min(x))/(max(x)-min(x))
  return(x)
}