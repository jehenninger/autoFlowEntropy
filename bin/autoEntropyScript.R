library(flowCore)
library(ggplot2)
library(FNN)

file_name <- c('/Users/jon/Google Drive/zbow entropy test/EXPORTED LIVE CELLS/WKM_Fish_005_007.livecells.fcs',
               '/Users/jon/Google Drive/zbow entropy test/EXPORTED LIVE CELLS/WKM_Fish_018_020.livecells.fcs')

flow_entropy_5 <- autoEntropy(file_name = file_name[1], k = 50)
flow_entropy_18 <- autoEntropy(file_name = file_name[2], k = 50)

plot(flow_entropy_5, xlim = c(0,50), ylim = c(0,2))
points(flow_entropy_18, col = 'red')


