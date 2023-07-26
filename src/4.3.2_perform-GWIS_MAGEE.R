## Libraries
library(MAGEE)
library(argparse)


parser <- ArgumentParser()
parser$add_argument("--path_to_nullmodel", type = "character", required = TRUE) # "/path/to/nullmodel/LDLC_ALLFAST_BMI_ALL_TOT_adult_case.glmmkin_nullmod.rds"
parser$add_argument("--path_to_genotype", type = "character", required = TRUE) # "/path/to/genotype/file.gds"
parser$add_argument("--exposure", type = "character", required = TRUE) # Exposure (interaction) variables
parser$add_argument("--outfile", type = "character", required = TRUE) # "/path/to/output/"

## Parse arguments 
args <- parser$parse_args()

path_to_nullmodel <- args$path_to_nullmodel 

path_to_genotype <- args$path_to_genotype 

exposure <- args$exposure

outfile <- args$outfile

## Null model
model0 <- readRDS(path_to_nullmodel)

## Imputed genotypes
geno.file <- path_to_genotype

## Exposure (interaction) variables
exposure <- exposure

## Output
outfile <- outfile

## Run MAGEE
glmm.gei(null.obj = model0, 
         interaction = exposure, 
         geno.file = geno.file, 
         outfile = outfile, 
         MAF.range = c(0.001,0.5), 
         meta.output = T,
         ncores = detectCores(), ## You can change the numbers based on computational resources
         center = F)

showfile.gds(closeall = T)