#!/bin/bash

##################################################################################################################################
## 																																
## 	Script Name: 2.5_imputation_quality.sh																						
## 	Description: This script extracts the INFO (R2) score related to quality imputation for each variant.  						
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		
## 	Date: 2023-05-03																											
## 	Version: 1.0																												
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Usage:																														
## 			2.5_imputation_quality.sh  																							
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Input Parameters: None																																															
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Output: 																													
## 			This script will produce .txt files (one per chromosome) with SNP summary statistics, including R2.					
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Example: 																														
## 			2.5_imputation_quality.sh 																							
## 																																
##################################################################################################################################

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #

### Filter variants by a particular R2 threshold? 

for i in {1..22};  
	do 
		zcat ../results_tmp/chr${i}.imputed.poly.vcf.gz | qctool -g - -filetype vcf -snp-stats -osnp ../results_for_upload/imputation_qc/chr${i}.snp-stats.txt
	done


### Merge each file together into a single file

