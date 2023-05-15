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
## 			4.3.1_perform-GWIS_GEM.sh 	A 	B 	C 	D 	E 	F 	G 	H 	I 	J 	K
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Input Parameters (* are required): 																							##
##			*A (Type: String) = Indicator for imputation input. Must be one of the following:	 								##
##									'BGEN' = .bgen input																		##
##									'PFILE' = .pgen, .pvar, .psam input															##	
##			*B (Type: String) = Path to imputation files, including the file prefix. Only include '.bgen' if input is 'BGEN',	##
##								otherwise do not include any file extensions if input is 'PFILE'. 								##
##			*C (Type: String) = If 'BGEN' input does not contain sample identifiers, this is the path to the sample file, 		##
##								including the file prefix and extension. If the sample file is not needed, 						##
##								set parameter as 'NA'.  																		##
##			*D (Type: String) = Path to the phenotype file, including file prefix and extension. 								##
##			*E (Type: String) = Delimiter of the phenotype file. Must be one of the following:									##
##									'\t' = tab-delimited																		##
##									'\0' = space-delimited																		##
##									',' = comma-separated																		##
##			*F (Type: String) = Variable name in the phenotype file that contains sample identifiers. Needs to match the IDs 	##
##								used in the .bgen sample file, if provided.														##
##			*G (Type: String) = Variable name in the phenotype file that contains the outcome of interest.						##
##			*H (Type: String) = Variable name in the phenotype file that contains the exposure of interest.						##
##			*I (Type: String) = List of covariates to be used in the model. Variable names must correspond to names used		##
##								in the phneotype file. Put a single space between each listed variable.							##
##								DO NOT INCLUDE THE EXPOSURE AS A COVARIATE or else an error will occur. GEM automatically		##
##								includes the exposure as a covariate. 															##
##			*J (Type: String) = Indicate the path for all GEM output results to be stored.										##
##			*K (Type: String) = The prefix for all of the GEM output files. The extension is automatically set to 'gem.out'. 	##
##								Please use the naming convention detailed in XXXXXX. 
##																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Output: 																													##
## 			This script will produce a  ... 
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Example 1: 																													##	
## 			4.3.1_perform-GWIS_GEM.sh BGEN /path/to/my/bgen/fileName.bgen /path/to/my/bgen/sample/fileName.tsv					##
##					/path/to/my/phenotype/fileName.tsv '\t' 'sample_ID' 'LDLC' 'bmi' 'AGE AGE2 sex PC1 PC2 PC3 PC3 PC4'			##	
##					/path/to/my/gem/output/	''
## 	Example 2: 																													##	
## 			4.3.1_perform-GWIS_GEM.sh BGEN /path/to/my/bgen/fileName.bgen NA /path/to/my/phenotype/fileName.csv ',' 'IID'
##					'ldlc_adj' 'AGE' 'AGE2 sex PC1 PC2 PC3 PC3 PC4 PC5 PC6'	

## 	Example 3: 																													##	
## 			4.3.1_perform-GWIS_GEM.sh PFILE /path/to/my/pfile/fileName NA /path/to/my/phenotype/fileName.tsv '\t' 'ids'
##					'tg_fast' 'age' 'age2 sex PC1'	
## 																																##
##################################################################################################################################

# ------------------------------------- #
#  Input parameters						#
# ------------------------------------- #
file_type=${1} # Type of imputation  file
imputation_file=${2} # Path to imputation file
sample_file=${3} # If .bgen doesn't have a header block, this file must have the sample ID information. Troubleshooting here: https://large-scale-gxe-methods.github.io/GEMShowcaseWorkspace
pheno_file=${4} # Path to the phenotype file that includes information on outcomes, exposures, and covariates
delim=${5} # Delimiter separating values in the phenotype file
sampleID=${6} # Name of the variable/column header in the phenotype file that corresponds to the sample IDs
outcome=${7} # Name of the variable/column header in the phenotype file that corresponds to the outcome of interest
exposure=${8} # Name of the variable/column header in the phenotype file that corresponds to the exposure of interest
covariates=${9} # List of covariates
output_directory=${10} # Path to the directory for all results to be saved to
output_filename=${11} # GEM defaults the extension to 'gem.out'

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #

# Creating an folder for all outputs

output=/broad/hptmp/jdron/glgc/mgb_test/gem_apr4_bmi/mgb_${outcome}.chr${chr}.GEM.out # Full path and extension to where GEM output results. Default is `gem.out`
mkdir -p ${output_directory}


if [[ ${file_type} = BGEN ]]; then




if [[ ${sample_file} = ]] ; then


/medpop/esp2/jdron/software/GEM_1.4.5_static \
   --bgen ${imputation_file} \
   --pheno-file ${pheno} \
   --delim ${delim} \
   --sampleid-name ${sampleID} \
   --pheno-name ${outcome} \
   --exposure-names ${exposure}\
   --covar-names AGE sex PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 \
   --robust 1 \
   --center 0 \
   --scale 0 \
   --out ${output} \
   --output-style full 

elif [[ condition ]]; then


   	#statements   




 fi  	






 if [[ $test = 'a' ]]; then
