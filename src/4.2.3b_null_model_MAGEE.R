## Libraries
library(data.table)
library(GMMAT)
library(GWASTools)
library(GENESIS)
library(SeqArray)
library(SeqVarTools)

## File with outcome, exposure, and covariate information
# Sample ID column header should be labelled as “sample.id”
pheno <- fread("/path/to/pheno_input_main.tsv")

## GRM generated from GENESIS or you can use your own GRM and convert it to a matrix. 
mypcrel <- GWASTools::getobj("/path/to/grm/mypcrel.Rdata")
kin.mat <- pcrelateToMatrix(mypcrel)

## Generate the null model for LDL
# Adjust the variable names to reflect column names in pheno
fomula <- as.formula(paste("LDL_ADJ", " ~ ", paste(c("sex", "age","age2",paste("PC", 1:10, sep="")), collapse= "+")))

obj_nullmodel <- GMMAT::glmmkin(fomula,data=pheno,family=gaussian(link = "identity"),id = "sample.id", kins = kin.mat)

## Save the null model to use with MAGEE
saveRDS(obj_nullmodel, file="/path/to/nullmodel/glmmkin_nullmod_ldl.rds")
