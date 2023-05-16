#!/bin/bash

##################################################################################################################################
## 																																##
## 	Script Name: 2.4_post-imputation-variant-pruning.sh																			##
## 	Description: This script removes any monomorphic variants and only keeps polymophic variants.  								##
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		##
##			 XXX <email>
## 	Date: 2023-05-03																											##
## 	Version: 1.0																												##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Usage:																														##
## 			2.4_post-imputation-variant-pruning.sh	 A
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Input Parameters (* are required): 																							##
##			*A (Type: String) = Path to imputation output.  																	##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Output: 																													##
## 			This script will produce VCFs (one per chromosome) that only include polymorphic sites.								##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Example: 																													##	
## 			2.4_post-imputation-variant-pruning.sh /path/to/my/QC/files   
## 																																##
##################################################################################################################################

# ------------------------------------- #
#  Input parameters						#
# ------------------------------------- #
imputation_path=${1} # path to output from imputation

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #

for i in {1..22};
	do
		bcftools view –c 1:minor chr${i}.dose.vcf.gz -O z > chr${i}.imputed.poly.vcf.gz
		tabix -p vcf ../results_tmp/chr${i}.imputed.poly.vcf.gz
	done
