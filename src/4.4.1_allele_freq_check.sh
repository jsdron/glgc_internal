#!/bin/bash

##################################################################################################################################
## 																																
## 	Script Name: 4.4.1_allele_freq_check.sh																				
## 	Description: This script has been adapted from munge_sumstats_beforeQC.wdl.						
## 	Authors: Jacqueline S. Dron <jdron@broadinstitute.org>																		
## 	Date: 2023-07-26																											
## 	Version: 1.0																												
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Usage:																													
## 			4.4.1_allele_freq_check.sh	 my_docker_image.gz input.sumstat AF N Ncontrol Ncase INFO 5 0.8
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Input Parameters (* are required): 																							
##			*A (Type: String) = Indicator for if 'GEM' or 'MAGEE' was used for GWIS.																
##																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Output: 																													
## 			This script will produce a  ... 
## 																																
## ---------------------------------------------------------------------------------------------------------------------------- 
## 	Example: 																														
## 			4.4.1_allele_freq_check.sh 'GEM' /path/to/my/bgen/fileName /
## 																																
##################################################################################################################################

# ------------------------------------- #
#  Input parameters						#
# ------------------------------------- #
software=${1} # GEM or MAGEE

# ------------------------------------- #
#  Starting script						#
# ------------------------------------- #

##### generate a .txt list of all the summary stats so that we can loop through them
cat ../data/sumstat_list.txt | while read -r sumstat_file; do 
	  echo "${sumstat_file}"
	  basename=$(basename "$sumstat_file")
echo "${basename}"




    if [[ ${software} = 'GEM' ]]; then


    elif [[ ${software} = 'MAGEE' ]]; then


    fi


## once the list of bad variants is created, filter for ALL the main GWIS results. save to results_for_upload

done


## clean the summary stat file and put it into the correct format

docker="$1"

af_col="$3"
N_col="$4"
Ncontrol_col="$5"
Ncase_col="$6"
info_col="$7"
min_mac="$8"
min_info="$9"

# Generate the output filename
outfile=${basename}.munged.gz

# Print input file details
echo "Biobank meta-analysis - clean and filter sumstats"
echo "${basename}"
echo ""

# Obtain column numbers from the header
chr_col=$(zcat "${sumstat_file}" | head -1 | tr '\t' ' ' | tr -s ' ' '\n' | grep -nx "#CHR\|CHR" | head -1 | cut -d ':' -f1)
pos_col=$(zcat "${sumstat_file}" | head -1 | tr '\t' ' ' | tr -s ' ' '\n' | grep -nx "POS" | head -1 | cut -d ':' -f1)
N_col_num=$(zcat "${sumstat_file}" | head -1 | tr '\t' ' ' | tr -s ' ' '\n' | grep -nx "${N_col}" | head -1 | cut -d ':' -f1)
Ncase_col_num=$(zcat "${sumstat_file}" | head -1 | tr '\t' ' ' | tr -s ' ' '\n' | grep -nx "${Ncase_col}" | head -1 | cut -d ':' -f1)
Ncontrol_col_num=$(zcat "${sumstat_file}" | head -1 | tr '\t' ' ' | tr -s ' ' '\n' | grep -nx "${Ncontrol_col}" | head -1 | cut -d ':' -f1)

# ... (rest of the original code)
# Place the remaining commands from the original task here

# Make sure to replace any usage of "${outfile}" with "$outfile"

# Example command:
# bgzip "$outfile" > "${outfile}.gz"

# Example tabix command:
# tabix -S 1 -s "$chr_col" -b "$pos_col" -e "$pos_col" "$outfile"










task lift {

    String docker
    File sumstat_file
    File tbi_file = sumstat_file + ".tbi"
    String base = basename(sumstat_file)
    File b37_ref
    File b38_ref
    String dollar = "$"

    command <<<

        echo "Biobank meta-analysis - lift over sumstats if needed"
        echo "${sumstat_file}"
        echo "${b37_ref}"
        echo "${b38_ref}"
        echo ""

        mv ${sumstat_file} ${base}
        mv ${tbi_file} ${base}.tbi

        tabix -R ${b37_ref} ${base} | wc -l > b37.txt
        tabix -R ${b38_ref} ${base} | wc -l > b38.txt

        echo "`date` `cat b37.txt` chr 21 variants build 37"
        echo "`date` `cat b38.txt` chr 21 variants build 38"

        if ((`cat b37.txt` == 0 && `cat b38.txt` == 0)); then
            echo "`date` no chr 21 variants found in either build, quitting"
            exit 1
        fi

        if ((`cat b37.txt` > `cat b38.txt`)); then
            echo "`date` lifting to build 38"
            time /META_ANALYSIS/scripts/lift.py -chr "#CHR" -pos POS -ref Allele1 -alt Allele2 \
            -chain_file /META_ANALYSIS/data/hg19ToHg38.over.chain.gz -tmp_path /cromwell_root/ \
            ${base} > ${base}.lift.out 2> ${base}.lift.err
            gunzip -c ${base}.lifted.gz | \
            cut -f2- | awk '
            BEGIN { FS=OFS="\t" }
            NR==1 { for (i=1;i<=NF;i++) a[$i]=i; print $0 }
            NR>1 {
                temp=$a["#CHR"]; $a["#CHR"]=$a["anew_chr"]; $a["anew_chr"]=temp; temp=$a["POS"]; $a["POS"]=$a["anew_pos"]; $a["anew_pos"]=temp;
                sub("^0", "", $a["#CHR"]); sub("^chr", "", $a["#CHR"]); sub("^X", "23", $a["#CHR"]);
                if ($a["#CHR"] ~ /^[0-9]+$/) {
                    print $0
                }
            }' | bgzip > ${base}
        else
            echo "`date` presumably already in build 38"
        fi

    >>>

    output {
        File out = base
    }

    runtime {
        docker: "${docker}"
        cpu: "1"
        memory: "20 GB"
        disks: "local-disk 200 HDD"
        zones: "us-central1-f"
        preemptible: 0
        noAddress: false
    }
}

task harmonize {

    String docker
    File sumstat_file
    String base = basename(sumstat_file)
    File gnomad_ref
    String gnomad_ref_base = basename(gnomad_ref)
    Int n
    String options

    command <<<

        echo "Biobank meta-analysis - harmonize sumstats to reference"
        echo "${sumstat_file}"
        echo "${gnomad_ref}"
        echo ""

        mv ${sumstat_file} ${base}
        mv ${gnomad_ref} ${gnomad_ref_base}

        echo "`date` harmonizing stats with gnomAD"
        python3 /META_ANALYSIS/scripts/harmonize.py ${base} ${gnomad_ref_base} ${n} ${options}\
        | bgzip > ${base}.${gnomad_ref_base} && \
        tabix -S 1 -s 1 -b 2 -e 2 ${base}.${gnomad_ref_base} && \
        echo "`date` done"

    >>>

    output {
        File out = base + "." + gnomad_ref_base
        File out_tbi = base + "." + gnomad_ref_base + ".tbi"
    }

    runtime {
        docker: "${docker}"
        cpu: "1"
        memory: "2 GB"
        disks: "local-disk 200 SSD"
        zones: "us-central1-f"
        preemptible: 0
        noAddress: false
    }
}


task plot {

    File sumstat_file
    String base = basename(sumstat_file)
    String pop
    String docker

    command <<<

        mv ${sumstat_file} ${base} && \

        Rscript - <<EOF
        require(ggplot2)
        require(data.table)
        options(bitmapType='cairo')
        data <- fread("${base}")
        png("${base}_AF.png", width=1000, height=1000, units="px")
        p <- ggplot(data, aes_string(x="AF_Allele2", y="AF_gnomad_v3_b38_ref_${pop}")) +
          geom_point(alpha=0.1) +
          xlab("AF_${base}") +
          theme_minimal(base_size=18)
        print(p)
        dev.off()
        EOF

        echo "`date` QQ plot start" 
        /plot_scripts/QQplot.r --input=${base} --prefix="${base}" --af=AF_Allele2 --pvalue=p.value        
        echo "`date` Manhattan plot start"
        /plot_scripts/ManhattanPlot.r --input=${base} --PVAL=p.value --knownRegionFlank=1000000 --prefix="${base}"  --ismanhattanplot=TRUE --isannovar=FALSE --isqqplot=FALSE --CHR="#CHR" --POS=POS --ALLELE1=Allele1 --ALLELE2=Allele2 
    >>>

    output {
        Array[File] pngs = glob("*.png")
        File out = base + ".regions.txt"
        File out_tophits = base + ".tophits.txt"
    }

    runtime {
        docker: "${docker}"
        cpu: "1"
        memory: 15*ceil(size(sumstat_file, "G")) + " GB"
        disks: "local-disk 200 HDD"
        zones: "us-central1-f"
        preemptible: 0
        noAddress: false
    }
}


task plot2 {

    File sumstat_file
    String base = basename(sumstat_file)
    String pop
    String docker

    command <<<

        mv ${sumstat_file} ${base} && \

        Rscript - <<EOF
        require(ggplot2)
        require(data.table)
        options(bitmapType='cairo')
        data <- fread("${base}")
        png("${base}_AF.png", width=1000, height=1000, units="px")
        p <- ggplot(data, aes_string(x="AF_Allele2", y="AF_gnomad_v3_b38_ref_${pop}")) +
          geom_point(alpha=0.1) +
          xlab("AF_${base}") +
          theme_minimal(base_size=18)
        print(p)
        dev.off()
        EOF

        echo "`date` QQ plot start"
        /plot_scripts/QQplot.r --input=${base} --prefix="${base}" --af=AF_Allele2 --pvalue=p.value
        echo "`date` Manhattan plot start"
        /plot_scripts/ManhattanPlot.r --input=${base} --PVAL=p.value --knownRegionFlank=1000000 --prefix="${base}"  --ismanhattanplot=TRUE --isannovar=FALSE --isqqplot=FALSE --CHR="#CHR" --POS=POS --ALLELE1=Allele1 --ALLELE2=Allele2
    >>>

    output {
        Array[File] pngs = glob("*.png")
        File out = base + ".regions.txt"
        File out_tophits = base + ".tophits.txt"
    }

    runtime {
        docker: "${docker}"
        cpu: "1"
        memory: 15*ceil(size(sumstat_file, "G")) + " GB"
        disks: "local-disk 200 HDD"
        zones: "us-central1-f"
        preemptible: 0
        noAddress: false
    }
}


task filterbyfc_comparetoLOCObbk_qc {

    String docker
    File sumstat_file
    String base = basename(sumstat_file)
    File rmlistfile
    String rmlistfile_base = basename(rmlistfile)
    File amlistfile
    String amlistfile_base = basename(amlistfile)
    String outfile = sub(basename(sumstat_file, ".gz"), "\\.bgz$", "") + ".postGWASQC.gz"


    command <<<

        echo "Biobank meta-analysis - postGWASQC-filterbyfc_comparetoLOCObbk"
        echo "${sumstat_file}"
        echo ""

        mv ${sumstat_file} ${base}
        mv ${rmlistfile} ${rmlistfile_base}
        mv ${amlistfile} ${amlistfile_base}

        python3 /META_ANALYSIS/scripts/harmonize_postGWASQC.py ${base} ${rmlistfile_base} ${amlistfile_base} \
        | bgzip > ${outfile} && \
        tabix -S 1 -s 1 -b 2 -e 2 ${outfile} && \
        echo "`date` done"

    >>>

    output {
        File out = outfile
        File out_tbi = outfile + ".tbi"
    }

    runtime {
        docker: "${docker}"
        cpu: "1"
        memory: "2 GB"
        disks: "local-disk 200 SSD"
        zones: "us-central1-f"
        preemptible: 0
        noAddress: false
    }
}



workflow munge_sumstats {

    File sumstats_loc
    Array[Array[String]] sumstat_files = read_tsv(sumstats_loc)
    String gnomad_ref_template

    scatter (sumstat_file in sumstat_files) {
        call clean_filter {
            input: sumstat_file=sumstat_file[0], info_col=sumstat_file[3]
        }
        call lift {
            input: sumstat_file=clean_filter.out
            #input: sumstat_file=sumstat_file[0]
        }
        call harmonize {
            #input: sumstat_file=sumstat_file[0], gnomad_ref=sub(gnomad_ref_template, "POP", sumstat_file[1]), n=sumstat_file[2]
            input: sumstat_file=lift.out, gnomad_ref=sub(gnomad_ref_template, "POP", sumstat_file[1]), n=sumstat_file[2]
        }
        call plot {
            input: sumstat_file=harmonize.out, pop=sumstat_file[1]
        }

	#call filterbyfc_comparetoLOCObbk_qc {
        #    input: sumstat_file=harmonize.out, rmlistfile=sumstat_file[4], amlistfile=sumstat_file[5]
        #}

        #call plot2 {
        #    input: sumstat_file=filterbyfc_comparetoLOCObbk_qc.out, pop=sumstat_file[1]
        #}

    }
}

