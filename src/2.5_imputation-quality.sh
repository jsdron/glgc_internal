#!/bin/bash

##################################################################################################################################
## 																																##
## 	Script Name: 2.5_imputation_quality.sh																						##
## 	Description: This script extracts the INFO (R2) score related to quality imputation for each variant.  						##
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		##
##			 XXX <email>
## 	Date: 2023-05-03																											##
## 	Version: 1.0																												##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Usage:																														##
## 			2.5_imputation_quality.sh A
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Input Parameters: 																											##
##			A = Path to imputation output.  (Required | Type: String)	##
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Output: 																													##
## 			This script will produce a  ... 
## 																																##
## ---------------------------------------------------------------------------------------------------------------------------- ##
## 	Example: 																													##	
## 			2.5_imputation_quality.sh /path/to/my/QC/files 19  
## 																																##
##################################################################################################################################

# ------------------------------------- #
#  Input parameters						#
# ------------------------------------- #
imputation_path = ${1} # path to output from imputation

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #

for i in {1..22};  
	do 
		qctool -g ${imputation_path}/chr${i}.bgen -snp-stats -osnp ../results_for_upload/chr${i}.snp-stats.txt
	done


### merge them together? and then delete the single file?

