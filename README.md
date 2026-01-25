# Analysis for: Fairness in Winner-Take-All Competitions

This repository provides data and code to replicate the analysis of the paper.



## Authors

- Björn Bartling
- Alexander W. Cappelen
- Mathias Ekström
- Erik Ø. Sørensen
- Bertil Tungodden



## Abstract
This paper investigates fairness perceptions of extreme income inequality generated in winner-take-all competitions. 
In two large-scale experimental studies with more than 7,000 participants from the general population of the U.S., we find that 
extreme earnings inequality in winner-take-all competitions is commonly accepted, even when the winner outperforms the runner-up by 
the smallest possible margin. The effect of the winning margin is modest, being small compared to the effect of moving from luck as 
the source of inequality to winning by the smallest possible margin. Finally, we show that spectators' behavior in the experiment is closely related to their fairness views in broader societal and policy contexts---those 
who implement less redistribution in the winner-take-all competition are less likely to support higher taxes on the top one percent. The 
results advance our understanding of public attitudes toward fairness and redistributive policies in winner-take-all competitions marked 
by extreme earnings inequality.



# 1. Data Availability and Provenance Statement

# 1.1 Statement about rights

The authors have the rights to make the data from the experiment available in the public domain.

# 1.2 License for Data

The data collected as part of the study are available in the public domain at Harvard Dataverse
with a Creative Commons CC0 license.

# 1.3 Summary of availability

All data are publicly available and also provided as part of this replication package. 
The main source for the data is Harvard Dataverse at 


# 1.4 Details on each data source


# 2. Computational requirements

# 2.1 Software requirements. 

The analysis is written in R, relying on the targets for automation, and renv for controlling the version of
packages. The exact version used of each included package is documented in the renv.lock file managed by the renv package. 
For bootstrapping the renv.lock specified packages, the latest run used:

R, version 4.5.2 on Windows 11.
renv, version 1.1.5.

# 2.2 Controlled Randomness

The only part of the analysis that relies on randomness is the classification of 
free text motivations.

# 2.3 Memory, Runtime, Storage Requirements

The estimation of results on the local computer requires only minimal memory and
computational resources, and should only take a few minutes and require a few
megabytes of storage and memory.

The classification of free text motivations was done in the cloud using OpenAI
servers, requiring an API key and in the low tens of US dollars. 

# 3. Instructions to replicators

Replicators need to install renv and use the lock file to install other packages. 
In R, a tar_make() command will then calculate all results and output all displays
listed below. The displays are created as side-effects of creating the Vignettes,
which also create html pages with narratives surrounding the displays.

Sometimes it can be difficult to bootstrap renv and the packages. I've found
that it can help to manually install renv, and then, in Rstudio's terminal do:

```
R --vanilla -q -e "renv::restore(prompt = FALSE)"
```
# 4. List of Display Items and Programs

All the Figures are output in the `graphs` subdirectory, while latex versions of
the tables are output in the `tables` subdirectory.

For the main paper:

| Display item        | File name           | Vignette         | Chunk name       |
|---------------------|---------------------|------------------|------------------|
| Figure 1            | RN2018_hist_shareY_wta.pdf      |   analysis_main_sample.Rmd   |  Share of earnings given to winner |
| Figure 2            | RN2018_wta_luck.pdf             |   analysis_main_sample.Rmd   |  Winner-take-all vs luck           |
| Figure 3            | RN2018_flatness1_version2.pdf   |   analysis_main_sample.Rmd   |  Role of winning margin            |
| Table 1             | RN2018_role_of_merit.tex        |   analysis_main_sample.Rmd   |  role of merit for inequality acceptance |
| Table 2             | RN2018_role_of_margin.tex       |   analysis_main_sample.Rmd   |  role of margin for inequality acceptance |
| Table 3             | RN2018_attitudes.tex            |   analysis_main_sample.Rmd   |  general attitudes                |
| Table 4             | P2025_winning_margin.tex        |   follow_up_2025.Rmd | winning margin 2025 |

For the supplementary material:

| Display item        | File name           | Vignette         | Chunk name       |
|---------------------|---------------------|------------------|------------------|
| Figure A.1          | RN2018_distribution_levels.pdf  |   analysis_main_sample.Rmd   |  distributions I                   |
| Figure A.2          | RN2018_distribution_margins.pdf |   analysis_main_sample.Rmd   |  distributions II                  |
| Figure A.3          | RN2018_flatness_all_byT.pdf     |   analysis_main_sample.Rmd   |  role of winning margin take-all   |
| Figure A.4          | RN2018_flatness_share_byT.pdf   |   analysis_main_sample.Rmd   |  role of winning margin share      |
| Figure A.5          | RN2018_hetero_coefplot_s.pdf           |   analysis_main_sample.Rmd   |  heterogeneity analysis II         |

| Figure 4            | RN2018_hetero_coefplot.pdf             |   analysis_main_sample.Rmd   |  heterogeneity analysis I          |
| Figure 5            | RN2018_attitudes_hist.pdf              |   analysis_main_sample.Rmd   |  questionnaire responses           |



| Table A.1           | Not applicable: No data            |    | |
| Table A.2           | RN_2018_balance.tex                | analysis_main_sample.Rmd | balance |            
| Table A.3           | RN2018_T_comparisons.tex           |   analysis_main_sample.Rmd   |  comparisons of treatments |
| Table A.4           | RN2018_outcomes_on_background.tex  |   analysis_main_sample.Rmd   | outcomes on background |
| Table A.5           | RN2018_hetmerit_all.tex            |   analysis_main_sample.Rmd   |  heterogeneous merit all   |
| Table A.6           | RN2018_hetmerit_share.tex          |   analysis_main_sample.Rmd   |  heterogeneous merit share |
| Table A.7           | RN2018_hetmerit_margin.tex         |   analysis_main_sample.Rmd   |  heterogeneous merit margin|
| Table A.8           | RN2018_attitudes_share.tex         |   analysis_main_sample.Rmd   |  general attitudes share   |
| Table A.9           | P2025_ntab.tex                     |   follow_up_2025.Rmd         | by place in distribution |
| Table A.10          | P2025_attitudes.tex                |   follow_up_2025.Rmd         | general attitudes all |
| Table A.11          | P2025_attitudes_share.tex          |   follow_up_2025.Rmd         | general attitudes share |
| Table A.12          | classification/tvariants.tex       |   classification/explore_classifications.Rmd | different models |
| Table B.1           | RN2018_main_restricted.tex         |   restricted_sample_2018.Rmd |  main_restricted           |
| Table B.2           | RN2018_hetmerit_all_restricted.tex | restricted_sample_2018.Rmd | heterogeneous merit all restricted |
| Table B.3           | RN2018_hetmerit_share_restricted.tex | restricted_sample_2018.Rmd | heterogeneous merit share restricted |
| Table B.4           | RN2018_hetmerit_margin_restricted.tex | restricted_sample_2018.Rmd | heterogeneous merit margin restricted |
| Table B.5           | RN2018_attitudes_restricted.tex | restricted_sample_2018.Rmd | general attitudes restricted | 
| Table C.1           | LAB_balance.tex                     | lab_experiment.Rmd | balance |
| Table C.2           | LAB_replication.tex | lab_experiment.Rmd | replication of main |
