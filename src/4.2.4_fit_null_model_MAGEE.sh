#!/bin/bash

##################################################################################################################################
## 																																
## 	Script Name: 4.2.3b_null_model_MAGEE.sh																						
## 	Description: This is a wrapper that simplifies the process of running an R script named "4.2.4_fit_null_model_MAGEE.R" 
##               by providing the necessary command-line arguments. 				
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		
##			 Yuxuan Wang <yxw@bu.edu>
## 	Date: 2023-07-19																											
## 	Version: 1.0																												
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Usage:																													
## 			4.2.4_fit_null_model_MAGEE.sh 	A 	B 	C 	D 	E
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Input Parameters (* are required): 																							
##			*A (Type: String) = Path to the phenotype file, including file prefix and extension.  								
##			*B (Type: String) = Outcome. 
##			*C (Type: String) = Path to GRM. 													
##			*D (Type: String) = Covariates as a space-separated list.
##			*E (Type: String) = Path to the output file, including file prefix and extension. 
## ---------------------------------------------------------------------------------------------------------------------------- 
##
## 	Example: 																														
## 			4.2.4_fit_null_model_MAGEE.sh "/path/to/my/phenotype/fileName.csv" "LDLC" "/path/to/grm/mypcrel.Rdata" "sex age PC1 PC2 PC3 PC4 PC5" "/path/to/nullmodel/LDLC_ALLFAST_BMI_ALL_TOT_adult_case.glmmkin_nullmod.rds"
##################################################################################################################################

# ------------------------------------- #
#  Input parameters											#
# ------------------------------------- #

path_to_pheno=$1
outcome=$2
path_to_grm=$3
covariates=$4
outfile=$5


# ------------------------------------- #
#  Starting script											#
# ------------------------------------- #

# Loop through the chromosomes

Rscript 4.2.4_fit_null_model_MAGEE.R \
--pheno_file $path_to_pheno \
--outcome $outcome \
--grm $path_to_grm \
--covariates $covariates \
--outfile $outfile


