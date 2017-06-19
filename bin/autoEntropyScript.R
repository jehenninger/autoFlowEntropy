library(tcltk)
library(flowCore)
library(ggplot2)
library(FNN)
library(ggcyto)

## TO DO:
## Merge the print of each sample into one line. Only use the sample name
## Do analyses in parallel


# #Start parallelization
# no_cores <- detectCores()/2
# cl <- makeCluster(no_cores, type = "FORK")



# file_name <- list.files('/Users/jon/Google Drive/zbow entropy test/EXPORTED LIVE CELLS/',
#                         full.names = TRUE, include.dirs = FALSE)

file_name_control <- tk_choose.files(caption =  "Select control marrows", filters = matrix(c("FCS files", ".fcs"),1,2))
num_of_controls <- length(file_name_control)
file_name_injected <- tk_choose.files(caption = "Select injected marrrows")
num_of_injected <- length(file_name_injected)

file_name <- c(file_name_control, file_name_injected)


control_idx <- c(1:num_of_controls)
injected_idx <- c((num_of_controls + 1):(num_of_controls + num_of_injected))
# file_name <- c('/Users/jon/Google Drive/zbow entropy test/EXPORTED LIVE CELLS/WKM_Fish_005_007.livecells.fcs',
# '/Users/jon/Google Drive/zbow entropy test/EXPORTED LIVE CELLS/WKM_Fish_018_020.livecells.fcs')

# For parallelization, although I haven't figured out how to get one output
# flow_entropy <- parLapply(cl, file_name, autoEntropy)
# stopCluster(cl)

flow_entropy <- list()
# flow_entropy <- lapply(file_name, autoEntropy)


for(i in 1:length(file_name)){
  flow_entropy[[i]] <- autoEntropy(file_name = file_name[i], k = 10)
  print(paste0("Sample ", basename(file_name[i]), " is done."))
}

mean_flow_entropy <- sapply(flow_entropy,mean)
point_colors <- rainbow(length(file_name))

plot(flow_entropy[[1]], xlim = c(0,10), ylim = c(0,2.5))
for(k in 2:length(file_name)){
  points(flow_entropy[[k]], col = point_colors[k])
}

plot(rep(1,length(control_idx)),flow_entropy[control_idx], xlim = c(0,10), ylim = c(0,2.5), col = 'black')
points(rep(2,length(injected_idx)), flow_entropy[injected_idx], col = 'red')