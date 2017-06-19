loadFCS <- function(file_name, transform_type = 'AUTO') {
  options(warn = -1)
  # file_name <- '/Users/jon/Google Drive/zbow entropy test/EXPORTED LIVE CELLS/WKM_Fish_005_007.livecells.fcs'
  param_to_read <- "FSC.A|SSC.A|Comp.FITC.A|Comp.GFP.A|Comp.PE.A|Comp.*Red.A|Comp.CFP.A|Comp.DAPI.A"
  fcs_data <- read.FCS(file_name, transformation = FALSE, alter.names = TRUE, column.pattern = param_to_read)
  
  param_names <- gsub('<.*> ','',names(fcs_data))
  
  r_param_index <- grep('PE|.*Red', param_names)
  g_param_index <- grep('GFP|FITC', param_names)
  b_param_index <- grep('CFP|DAPI', param_names)
  
  
  
  
  switch(transform_type,
         'AUTO' = {
           default_logicle <- estimateLogicle(fcs_data, channels = param_names)        
           transform_data <- transform(fcs_data,default_logicle)
           
           color_indices <- c(r_param_index, g_param_index, b_param_index)
           
           # output <- list()
           # output[[1]] <- transform_data
           # output[[2]] <- color_indices
           
           output <- transform_data
           
           return(output)
         },
         
         'CUSTOM' = {
           
           r_custom_transform <- logicleTransform(w = 1.5, m = 4.5, t = 262144, a = 0)
           g_custom_transform <- logicleTransform(w = 1.5, m = 4.5, t = 262144, a = 0)
           b_custom_transform <- logicleTransform(w = 1.8, m = 4.5, t = 262144, a = 0)

           custom_transform <- transformList(c(param_names[[r_param_index]],
                                               param_names[[g_param_index]],
                                               param_names[[b_param_index]]),
                                             c(r_custom_transform,
                                               g_custom_transform,
                                               b_custom_transform))
      

           color_data <- flowCore::transform(fcs_data, custom_transform)
           return(color_data)

         }
  )
  
  options(warn = 0)

}