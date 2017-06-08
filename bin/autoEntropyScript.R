file_name <- "E:\\zon_lab\\FACS\\2015.12.2 Pooled gRNA Zbow\\EXPORTED LIVE CELLS\\WKM_Fish_005_007.livecells.fcs"

## use read.flowset to read in a whole directory of fcs files in the future
## 

param_to_read <- "FSC.A|SSC.A|Comp.FITC.A|Comp.GFP.A|Comp.PE.A|Comp.*Red.A|Comp.CFP.A|Comp.DAPI.A"
fcs_data <- read.FCS(file_name, transformation = FALSE, alter.names = TRUE, column.pattern = param_to_read)

param_names <- gsub('<.*> ','',names(fcs_data))

r_param_index <- grep('PE|.*Red', param_names)
g_param_index <- grep('GFP|FITC', param_names)
b_param_index <- grep('CFP|DAPI', param_names)

default_logicle <- estimateLogicle(fcs_data, channels = param_names)

def_transform_data <- transform(fcs_data,default_logicle)

r_custom_transform <- logicleTransform("rLogicle", w = 1.5, m = 4.5, t = 262144, a = 0)
g_custom_transform <- logicleTransform("gLogicle", w = 1.75, m = 4.5, t = 262144, a = 0)
b_custom_transform <- logicleTransform("bLogicle", w = 1.75, m = 4.5, t = 262144, a = 0)

#rTrans <- transformList(param_names[[r_param_index]],r_custom_transform)
#gTrans <- transformList(param_names[[g_param_index]],g_custom_transform)
#bTrans <- transformList(param_names[[b_param_index]],b_custom_transform)

color_data <- flowCore::transform(fcs_data,
                                  'rLogicle' = r_custom_transform(param_names[[r_param_index]]),
                                  'gLogicle' = g_custom_transform(param_names[[g_param_index]]),
                                  'bLogicle' = b_custom_transform(param_names[[b_param_index]]))