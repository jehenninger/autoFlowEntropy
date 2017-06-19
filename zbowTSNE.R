zbowTSNE <- function(file_name) {
  
  sample_size <- 1000
  default_transform <- loadFCS(file_name, transform_type = 'AUTO')
  color_transform <- loadFCS(file_name, transform_type = 'CUSTOM')
  
  
  
  set.seed(42)
  
  sample_idx <- sample(nrow(default_transform), sample_size, replace = FALSE)

  data_sample <- exprs(default_transform)[sample_idx,]
  
  r <- normalize_vector(exprs(color_transform$FJComp.PE.A)[sample_idx,])
  g <- normalize_vector(exprs(color_transform$FJComp.FITC.A)[sample_idx,])
  b <- normalize_vector(exprs(color_transform$FJComp.CFP.A)[sample_idx,])
  
  r_gamma <- gamma_color(red,1.5)
  g_gamma <- gamma_color(g,1.5)
  b_gamma <- gamma_color(b,1.5)

  color <- rgb(r_gamma, g_gamma, b_gamma, alpha = 0.6)
  
  tsne_out <- Rtsne(data_sample, dims = 2, theta = 0.5, perplexity = 10, pca = FALSE)
  
  plot(tsne_out$Y, pch = 21, bg = color, col = NULL)
  
  return(tsne_out)
  
}