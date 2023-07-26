#!/bin/bash

##################################################################################################################################
## 																																
## 	Script Name: 4.3.2_perform-GWIS_MAGEE.sh																						
## 	Description: This is  is a wrapper that simplifies the process of running 
##               the R script "4.3.2_perform-GWIS_MAGEE.R" by providing the necessary command-line arguments. 						
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		
##			 Yuxuan Wang <yxw@bu.edu>
## 	Date: 2023-07-19																											
## 	Version: 1.0																												
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Usage:																													
## 			4.3.2_perform-GWIS_MAGEE.sh 	A 	B 	C 	D 
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Input Parameters (* are required): 																							
##			*A (Type: String) = Path to Null models													
##			*B (Type: String) = Path to genotype files (GDS format)
##			*C (Type: String) = Exposure (interaction) variables (AGE/BMI)
##			*D (Type: String) = Path to output files						
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Example: 																														
## 			4.3.1_perform-GWIS_MAGEE.sh "/path/to/nullmodel/LDLC_ALLFAST_BMI_ALL_TOT_adult_case.glmmkin_nullmod.rds"
##      "/path/to/genotype/chr1.gds" "BMI" "/path/to/output/LDLC_ALLFAST_BMI_ALL_TOT_adult_case"
##						
##################################################################################################################################

# ------------------------------------- #
#  Input parameters											#
# ------------------------------------- #

path_to_nullmodel=$1
path_to_genotype=$2
exposure=$3
outfile=$4


# ------------------------------------- #
#  Starting script											#
# ------------------------------------- #


Rscript 4.3.2_perform-GWIS_MAGEE.R \
--path_to_nullmodel $path_to_nullmodel \
--path_to_genotype $path_to_genotype \
--exposure $exposure \
--outfile $outfile


