#!/bin/bash

##################################################################################################################################
## 																																
## 	Script Name: 4.3.2_perform-GWIS_MAGEE.sh																						
## 	Description: This is a wrapper that simplifies the process of running 
##               the R script "4.3.2_perform-GWIS_MAGEE.R" by providing the necessary command-line arguments. 						
## 	Authors: Yuxuan Wang <yxw@bu.edu>
## 	Date: 2023-07-19																											
## 	Version: 1.0																												
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Usage:																													
## 			4.3.2_perform-GWIS_MAGEE.sh 	A 	B 	C 	D 
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Input Parameters (* are required): 																							
##			*A (Type: String) = Path to null model	generated using 4.2.3b_fit_null_model.MAGEE.sh.												
##			*B (Type: String) = Path to genotype files (GDS format).
##			*C (Type: String) = Variable name in the phenotype file that contains the exposure of interest.
##			*D (Type: String) = Path and prefix for output files. Please use the naming convention detailed in 
##								Section 5.2 of the Analysis Plan. 							
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Example: 																														
## 			4.3.2_perform-GWIS_MAGEE.sh "/path/to/nullmodel/LDLC_ALLFAST_BMI_ALL_TOT_adult_case.glmmkin_nullmod.rds"
##      "/path/to/genotype/chr1.gds" "BMI" "/path/to/output/LDLC_ALLFAST_BMI_ALL_TOT_adult_case"
##						
##################################################################################################################################

# ------------------------------------- #
#  Input parameters		                #
# ------------------------------------- #

path_to_nullmodel=$1
path_to_genotype=$2
exposure=$3
outfile=$4

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #

Rscript ../helper/4.3.2_perform-GWIS_MAGEE.R \
--path_to_nullmodel $path_to_nullmodel \
--path_to_genotype $path_to_genotype \
--exposure $exposure \
--outfile $outfile


