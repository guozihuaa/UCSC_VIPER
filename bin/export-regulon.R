#!/usr/bin/env	Rscript

# convert the names
library(GenomicFeatures)
library(mygene)

# Get command line options:
library('getopt')
# the real network score --
opt = getopt(matrix(c('regulon', 'r', 1, "character"),ncol=4,byrow=TRUE));


GenEntToGenSym <- function (GeneList) {
  GenSym <- queryMany(GeneList, fields="symbol", species="human", size=1)  
  GenSym <- GenSym[,"symbol"] 
}

regulon_name <- opt$regulon
load(regulon_name)

reg_names <- names(regul)
reg_genes <- GenEntToGenSym(reg_names)


net <- c()
for (i in 1:length(regul)) {
  target <- names(regul[[i]]$tfmode)
  vals <- regul[[i]]$tfmode
  net <- rbind(net, cbind(matrix(reg_genes[i],length(vals),1), vals, target))
}
row.names(net) <- NULL
net[,3] <- GenEntToGenSym(net[,3])

write.table(net, 
            file=paste(unlist(strsplit(regulon_name, split='.', fixed=TRUE))[1], '.tsv', sep=''), 
            col.names = FALSE, row.names = FALSE, sep="\t", quote=F)

