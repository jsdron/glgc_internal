## Libraries
library(MAGEE)

## Null model
model0 <- readRDS("/path/to/nullmodel/glmmkin_nullmod_ldl.rds")

## Imputed genotypes
geno.file <- "/path/to/genotype/file.gds"

## Exposure (interaction) variables
env <- "age"

## Output
outfile <- "output.file.name"

## Run MAGEE
glmm.gei(null.obj = obj_nullmodel, 
         interaction = env, 
         geno.file = geno.file, 
         outfile = outfile, 
         MAF.range = c(0.001,0.5), 
         meta.output = T,
         ncores = detectCores(), ## You can change the numbers based on computational resources
         center = F)

showfile.gds(closeall = T)