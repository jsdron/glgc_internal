# GLGC 2023 Analysis Pipeline

This repo contains all the necessary scripts for study cohorts to run through the GLGC 2023 Analysis Pipeline. If you are interested in joining the [Global Lipids Genetics Consortium](http://www.lipidgenetics.org/), please contact Gina Peloso <gpeloso@bu.edu>.

Current version: 1.0

## Table of Contents

- [Installation](#installation)
- [Dependancies](#dependancies)
- [Set-Up](#setup)
- [Analysis Plan](#analysisplan)
- [Contact](#contact)

## Installation

To install the GLGC 2023 Analysis Pipeline, run the following code: 
```bash
git clone https://github.com/jsdron/glgc_internal.git
```

## Dependancies
The following software is required to run the pipeline successfully; however, studies will only need either GEM or MAGEE, depending on if there are unrelated or related individuals, respectively. 
- [BGZIP and tabix](http://www.htslib.org/download/) (0.2.6 or above), which can be downloaded as part of the `htslib` package
- [BCFtools](http://www.htslib.org/download/) (1.3.1 or above)
- [QCTOOL](https://www.well.ox.ac.uk/~gav/qctool_v2/documentation/download.html) (2.0.1 or above) 
- [vcftools](https://github.com/vcftools/vcftools) (0.1.8 or above)
- [PLINK 1.9](https://www.cog-genomics.org/plink/) 
- [PLINK 2.0](https://www.cog-genomics.org/plink/2.0/)
- [GEM](https://github.com/large-scale-gxe-methods/GEM) (1.4.5 or above)
- [MAGEE](https://github.com/large-scale-gxe-methods/MAGEE) (1.3.0 or above) 
- R (4.1.0 or above)

## Overview
A flowchart overview of the [analysis plan](#analysisplan) is provided: `/helper/2023 GLGC Analysis Plan.pdf`

![2023 GLGC Analysis Plan](https://github.com/jsdron/glgc_internal/assets/13053565/c4756083-52fb-43eb-b2ae-b1fdb55dead5)

## Analysis Plan
Do we want to include a PDF of our workplan? We could have a version control thing here, where we link the (uneditable) document here for studies to download. we can also have the different versions everytime they get updated.


## Contact
If you have any questions or feedback, please open an issue in this repository or contact the appropriate person listed in the analysis plan document. 
