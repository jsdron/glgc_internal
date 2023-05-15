#!/bin/bash

##################################################################################################################################
## 																																##
## 	Script Name: 4.3.1_perform-GWIS_GEM.sh																						##
## 	Description: XXX  						##
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		##
##			 XXX <email>
## 	Date: 2023-05-15																											##
## 	Version: 1.0																												##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Usage:																														##
## 			4.3.1_perform-GWIS_GEM.sh 	A 	B 	C 	D
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Input Parameters: 																											##
##			A = Indication as to whether "BGEN" or "PFILE" will be used as imputation input.  (Required | Type: String)	##
##			B = Path to imputation files, including the prefix. Only include '.bgen' if input is "BGEN", otherwise 
##				do not include any file extensions if input is "PFILE".   (Required | Type: String)	##
##			C = If "BGEN" is the input and it does not contain sample identifiers, this is path to the sample file. 
##				If the sample file is not needed, set parameter as "NA".
##			D = Path to the phenotype file. (Required | Type: String)	##
##			E = 
## 					note that the exposure cannot be listed as a covariate, or else an error will occur. the exposure will automatically be added	
																										##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Output: 																													##
## 			This script will produce a  ... 
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Example 1: 																													##	
## 			4.3.1_perform-GWIS_GEM.sh BGEN /path/to/my/bgen/fileName.bgen

## 	Example 2: 																													##	
## 			4.3.1_perform-GWIS_GEM.sh PFILE /path/to/my/pfile/fileName
## 																																##
##################################################################################################################################

# ------------------------------------- #
#  Input parameters						#
# ------------------------------------- #
file_type = ${1} # type of imputation input file
imputation_file = ${1} # path to output from imputation
pheno_file =
sampleID =  Column name in the phenotype file that contains sample identifiers. Needs to be the same as the one in the $sample file
outcome =
exposure = One or more column names in the ${pheno} file naming the exposure(s) to be included in interaction tests.
covariates =  AGE sex PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10
bgen_sample_file = 

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #


if [[ ${file_type} = BGEN ]]; then

##### INPUT #####
# Path to the BGEN file. Imputed data. *****
bgen=/medpop/esp2/projects/MGB_Biobank/imputation/53K_GSA/release/bgen/GSA_53K.merged.chr${chr}.bgen

pheno=/medpop/esp2/jdron/projects/glgc/pre-analysis/gwis_test/MGB.ldladj-tg-covar.n21872.tsv # Path to the phenotype file

outcome=LDLC_irn # Column name in the ${pheno} file with the outcome of interest. Assumed binary if only 2 unique observations.
exposure=bmi 

##### OTHER PARAMETERS #####
delim=\0 # Delimiter separating values in the phenotype file. Tab delimiter should be represented as \t and space delimiter as \0. Default: , (comma-separated)

##### OUTPUT #####
out_style=full

output=/broad/hptmp/jdron/glgc/mgb_test/gem_apr4_bmi/mgb_${outcome}.chr${chr}.GEM.out # Full path and extension to where GEM output results. Default is `gem.out`
mkdir -p /broad/hptmp/jdron/glgc/mgb_test/gem_apr4_bmi/

/medpop/esp2/jdron/software/GEM_1.4.5_static \
   --pheno-file ${pheno} \
   --bgen ${bgen} \
   --out ${output} \
   --output-style ${out_style} \
   --sampleid-name ${sampleID} \
   --pheno-name ${outcome} \
   --exposure-names ${exposure}\
   --covar-names AGE sex PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 \
   --robust 1 \
   --delim ${delim} \
   --center 0 \
   --scale 0 

elif [[ condition ]]; then


   	#statements   




 fi  	