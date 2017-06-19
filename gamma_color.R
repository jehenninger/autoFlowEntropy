gamma_color <- function(color, gamma = 1){
  
  output <- color^(1/gamma)
  
  return(output)
}