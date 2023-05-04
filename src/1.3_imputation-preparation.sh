#!/bin/bash

##################################################################################################################################
## 																																##
## 	Script Name: 1.3_imputation_preparation.sh																					##
## 	Description: This script c... .  ##
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		##
##			 XXX <email>
## 	Date: 2023-05-03																											##
## 	Version: 1.0																												##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Usage:																														##
## 			1.3_imputation_preparation.sh A B
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Input Parameters: 																											##
##			A =	##
##			B = 					##
##			C =
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Output: 																													##
## 			This script will produce VCF files that will be used as input for imputation with the TOPMed reference panel.		##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Example: 																													##	
## 			1.3_imputation_preparation.sh 
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	IMPORTANT NOTE: 																											##	
## 			The user MUST edit the ./Run-plink.sh script to set the paths to the original study files. This should be the same  ##
##			path that was used as the first input parameter [A] for 1.2_pre-imputation-check.sh.								##  
## 																																##
##################################################################################################################################

# ------------------------------------- #
#  Input parameters						#
# ------------------------------------- #

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #

./Run-plink.sh # the output, Study-updated-chr, is one updated binary file per chromosome
mv ./Study-updated-chr* 

### Convert the newly output Study-updated-chr files to VCF format
for i in {1..22};  
	do 
		plink --bfile ../data/Study-updated-chr${i} --keep-allele-order --recode vcf-iid --out ../data/Study-updated-chr${i}
		bgzip ../data/Study-updated-chr${i}.vcf
		tabix –p vcf ../data/Study-updated-chr${i}.vcf.gz
	done


