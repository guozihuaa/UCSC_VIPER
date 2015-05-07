#!/bin/sh

type=$1

data=${type}/rnaseq.tab.fixed
pheno=${type}/rnaseq.tab.phenotypes.tab

../../../bin/run-viper.R \
	-e  $data \
	-p $pheno \
	-t Tumor \
	-r Normal \
	-n pathway_extensions_v2.transcriptional.nodir.adj \
	--viper_null \
	--output ${type}
