## Libraries
rm(list = ls())
library(data.table)
library(GMMAT)
library(GWASTools)
library(GENESIS)
library(SeqArray)
library(SeqVarTools)
library(argparse)


parser <- ArgumentParser()
parser$add_argument("--pheno_file", type = "character", required = TRUE) # "/path/to/my/phenotype/fileName.csv"
parser$add_argument("--outcome", type = "character", required = TRUE) # "LDLC"
parser$add_argument("--grm", type = "character", required = TRUE) # "/path/to/grm/mypcrel.Rdata"
parser$add_argument("--covariates", type = "character", nargs = "*", required = TRUE) # "sex age PC1 PC2 PC3 PC4 PC5"
parser$add_argument("--outfile", type = "character", required = TRUE) # "/path/to/nullmodel/LDLC_ALLFAST_BMI_ALL_TOT_adult_case.glmmkin_nullmod.rds"

## Parse arguments 
args <- parser$parse_args()

pheno_file <- args$pheno_file

outcome <- args$outcome

grm <- args$grm 

### Covariates
if (!is.null(args$covariates)) {
  # Split the covariates string using space (" ") as the delimiter
  covariates <- strsplit(args$covariates, " ")[[1]]
} else {
  # If --covariates not provided, set covariates to an empty vector
  covariates <- character(0)
}

outfile <- args$outfile

print(paste("Phenotype File Path: ", pheno_file))
print(paste("Outcome: ", outcome))
print(paste("GRM File Path: ", grm))
print(paste("Covariates: ", paste(covariates, collapse = ", ")))
print(paste("Output File Path: ", outfile))


## File with outcome, exposure, and covariate information
# Sample ID column header should be labelled as “sample.id”
pheno <- fread(pheno_file)

## GRM generated from GENESIS or you can use your own GRM and convert it to a matrix. 
mypcrel <- GWASTools::getobj(grm)

## Subset GRM based on the sample ID if needed: e.g. sample.include = pheno$sample.id
kin.mat <- pcrelateToMatrix(mypcrel,sample.include = pheno$sample.id)


## Generate the null model for LDLC
# Adjust the variable names to reflect column names in pheno
fomula <- as.formula(paste(outcome, " ~ ", paste(covariates, collapse= "+")))

obj_nullmodel <- GMMAT::glmmkin(fomula,data=pheno,family=gaussian(link = "identity"),id = "sample.id", kins = kin.mat)

## Save the null model to use with MAGEE
saveRDS(obj_nullmodel, file=outfile)
