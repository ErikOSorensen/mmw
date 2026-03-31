# Analysis for: Fairness in Winner-Take-All Competitions

This repository provides data and code to replicate the analysis of the paper.

## Table of Contents

- [Authors](#authors)
- [Abstract](#abstract)
- [1. Data Availability and Provenance Statement](#1-data-availability-and-provenance-statement)
  - [1.1 Statement about rights](#11-statement-about-rights)
  - [1.2 License for Data](#12-license-for-data)
  - [1.3 Summary of availability](#13-summary-of-availability)
  - [1.4 Details on each data source](#14-details-on-each-data-source)
- [2. Computational requirements](#2-computational-requirements)
  - [2.1 Software requirements](#21-software-requirements)
  - [2.2 Controlled Randomness](#22-controlled-randomness)
  - [2.3 Memory, Runtime, Storage Requirements](#23-memory-runtime-storage-requirements)
  - [2.4 Classification of Free-Text Motivations](#24-classification-of-free-text-motivations)
- [3. Instructions to replicators](#3-instructions-to-replicators)
  - [3.1 Using Docker (recommended)](#31-using-docker-recommended)
  - [3.2 Without Docker](#32-without-docker)
- [4. List of Display Items and Programs](#4-list-of-display-items-and-programs)

## Authors

- Björn Bartling
- Alexander W. Cappelen
- Mathias Ekström
- Erik Ø. Sørensen
- Bertil Tungodden



## Abstract

This paper investigates fairness perceptions of extreme income inequality
generated in winner-take-all competitions. Two large-scale experiments with
more than 7,000 participants from the general population of the U.S. show
that extreme earnings inequality is widely accepted, even when the winner
only slightly outperforms the runner-up. The effect of the winning margin
on inequality acceptance is modest compared to the effect of shifting the
source of inequality from luck to winning by the smallest possible margin.
The experimental choices are systematically associated with broader fairness
attitudes and policy preferences, including support for higher taxation
of top earners and redistributive economic policy.


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

| Data file | Content | License |
|-----------|---------|---------|
| data/mmwinner.dta | Data from lab experiment | CC0 |
| data/mmwinner_RN2018.dta | Data main experiment | CC0 |
| data/mmwinner_Prolific2025.dta | Data from Follow-Up Study | CC0 | 
| classification/B1.csv | Manual classification data for training LLM | CC0 |
| classification/B2.csv | Manual classification data for training LLM | CC0 |


# 2. Computational requirements

# 2.1 Software requirements

The analysis is written in R, relying on targets for automation and renv for controlling the version of
packages. The exact version used of each included package is documented in the `renv.lock` file.

**Option A: Docker (recommended)**

- Docker and Docker Compose

The provided `Dockerfile` and `docker-compose.yml` create a fully configured environment
based on `rocker/tidyverse:4.5.1` with all packages restored from `renv.lock`.

**Option B: Local R installation**

- R, version 4.5.x
- renv, version 1.1.5 or later


# 2.2 Controlled Randomness

The only part of the analysis that relies on randomness is the classification of
free text motivations. See Section 2.4 for details on reproducibility of this step.

# 2.3 Memory, Runtime, Storage Requirements

The estimation of results on the local computer requires only minimal memory and
computational resources, and should only take a few minutes and require a few
megabytes of storage and memory.

The classification of free text motivations was done in the cloud using OpenAI
servers, requiring an API key and in the low tens of US dollars.

# 2.4 Classification of Free-Text Motivations

The 2025 follow-up study collected free-text motivations from participants explaining
their redistribution decisions. These motivations were classified into categories
using a fine-tuned GPT model via the OpenAI API. This subsection gives an overview
of this process. More details are provided in `classification/README.md`.

**Training data for fine-tuning:**

The GPT model was fine-tuned on manually coded training examples. The training data
derives from two files containing human-coded classifications:

- `classification/B1.csv` - First batch of manually coded motivations
- `classification/B2.csv` - Second batch of manually coded motivations
/e
These files are combined with `classification/classifications_defs.csv` (category definitions)
by `classification/normalize_data.R` to produce `classification/training_data.csv`, which is
then converted to the JSONL format required by OpenAI's fine-tuning API.

**Frozen classification output (used in analysis):**

| Attribute | Value |
|-----------|-------|
| File | `classification/20250721_125758_classified_motivations.csv` |
| Model | `ft:gpt-3.5-turbo-0125:fair::BvgCjJLB` (fine-tuned) |
| System message | SYSTEM_MESSAGE_3 in `classification/systems.py` |
| System message hash | `9a22828ecc90b0a2321239de64933606ae97f7e0c11d00f5bc3ca949d880e81e` |
| Temperature | 0 (for reproducibility) |

The classification output is included in this replication package as a frozen artifact.
Replicators can verify all downstream R analyses without re-running the classification.
Replicators need to unzip the `TIMESTAMPS_classified_motivations.zip` in the 
`./classifications/` directory in order for the `classification/20250721_125758_classified_motivations.csv` 
to be available.

**Re-running the classification (optional):**

Re-running the classification requires an OpenAI API key and incurs costs. Due to the
nature of LLM inference, results may differ slightly from the frozen output even with
temperature=0, as OpenAI may update model weights or infrastructure over time.

To re-run classification:

1. Copy `classification/.env.example` to `classification/.env` and add your OpenAI API key
2. Install Python dependencies: `cd classification && uv sync`
3. Fine-tune a new model (see `classification/README.md` for detailed steps)
4. Run inference: `uv run run_inference.py --model <model-name> --system 2`

The classification scripts, training data, and system prompts are provided for
transparency and to enable validation of this step.

# 3. Instructions to replicators

This replication package supports two levels of verification:

- **Standard replication**: Run the R/targets pipeline using the provided classification
  output. This verifies all statistical analyses and reproduces all tables and figures.
- **Full replication**: Additionally re-run the OpenAI classification step (requires API
  key and incurs costs; see Section 2.4).

## 3.1 Using Docker (recommended)

The simplest way to replicate the analysis is using Docker, which ensures an identical
computational environment.

**Run the full pipeline from scratch:**
```bash
docker compose build runner
docker compose run --rm runner
```

This builds a container with all dependencies from `renv.lock`, copies the data and code,
and executes `targets::tar_make()`. Outputs are saved to `html_reports/`, `graphs/`, and `tables/`.

Note: The initial `docker compose build` downloads the base image and installs all R packages,
which may take several minutes. Subsequent builds and container starts are fast since Docker
caches the layers.

**Interactive development with RStudio:**
```bash
docker compose build rstudio
docker compose up rstudio
```
Then open http://localhost:8787 in a browser (user: `rstudio`, password: `shirapur`).

The RStudio container provides a browser-based IDE for exploring the analysis interactively.
You can inspect intermediate results, run individual targets, modify code, and re-run
parts of the pipeline. Changes to code and data files are synced with your local directory,
while outputs (`html_reports/`, `graphs/`, `tables/`) persist after the container stops.

## 3.2 Without Docker

Replicators need to install renv and use the lock file to install other packages.
In R, a `tar_make()` command will then calculate all results and output all displays
listed below. The displays are created as side-effects of creating the Vignettes,
which also create html pages with narratives surrounding the displays.

Sometimes it can be difficult to bootstrap renv and the packages. I've found
that it can help to manually install renv, and then, in RStudio's terminal do:

```
R --vanilla -q -e "renv::restore(prompt = FALSE)"
```
# 4. List of Display Items and Programs

All the Figures are output in the `graphs` subdirectory, while latex versions of
the tables are output in the `tables` subdirectory.

There are also html reports created in the `html_reports` subdirectory that 
contains the narrative results, with figures and tables included, of the 
Vignettes that are found in `code/*.Rmd`.

For the main paper:

| Display item        | File name           | Vignette         | Chunk name       |
|---------------------|---------------------|------------------|------------------|
| Figure 1            | MS31587_Figure-1.pdf      |   analysis_main_sample.Rmd   |  Share of earnings given to winner |
| Figure 2            | MS31587_Figure-2.pdf             |   analysis_main_sample.Rmd   |  Winner-take-all vs luck           |
| Figure 3            | MS31587_Figure-3.pdf   |   analysis_main_sample.Rmd   |  Role of winning margin            |
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
| Figure A.5          | RN2018_hetero_coefplot.pdf      |   analysis_main_sample.Rmd   |  heterogeneity analysis I          |
| Figure A.6          | RN2018_hetero_coefplot_s.pdf    |   analysis_main_sample.Rmd   |  heterogeneity analysis II         |
| Figure A.7          | RN2018_subtreatment_heterogeneity.pdf | analysis_main_sample.Rmd |  heterogeneity between treatments |
| Figure A.8          | RN2018_attitudes_hist.pdf              |   analysis_main_sample.Rmd   |  questionnaire responses           |
| Figure A.9          | P2025_distributions.pdf                | follow_up_2025.Rmd          | distributions in 2025 |
| Figure A.10         | P2025_classifications.pdf              | follow_up_2025.Rmd          | Shares of classifications |
| Table A.1           | Not applicable: No data                |                             |                      |
| Table A.2           | RN2018_balance.tex                     |   analysis_main_sample.Rmd   | balance |            
| Table A.3           | RN2018_T_comparisons.tex               |   analysis_main_sample.Rmd   |  comparisons of treatments |
| Table A.4           | RN2018_winning_margin_over_distribution.tex | analysis_main_sample.Rmd | winning_margin_over_distribution |
| Table A.5           | RN2018_outcomes_on_background.tex      |   analysis_main_sample.Rmd   |  outcomes on background |
| Table A.6           | RN2018_hetmerit_all.tex                |   analysis_main_sample.Rmd   |  heterogeneous merit all   |
| Table A.7           | RN2018_hetmerit_share.tex              |   analysis_main_sample.Rmd   |  heterogeneous merit share |
| Table A.8           | RN2018_hetmerit_margin.tex             |   analysis_main_sample.Rmd   |  heterogeneous merit margin|
| Table A.9           | RN2018_attitudes_share.tex             |   analysis_main_sample.Rmd   |  general attitudes share   |
| Table A.10           | P2025_balance.tex                      |   follow_up_2025.Rmd         | balance |
| Table A.11          | P2025_ntab.tex                         |   follow_up_2025.Rmd         | by place in distribution |
| Table A.12          | tvariants.tex                          |   explore_classifications.Rmd | different models |
| Table A.13          | P2025_outcomes_by_classification.tex   |   follow_up_2025.Rmd         | classifications and decisions |
| Table A.14          | P2025_attitudes.tex                    |   follow_up_2025.Rmd         | general attitudes all |
| Table A.15          | P2025_attitudes_share.tex              |   follow_up_2025.Rmd         | general attitudes share |
| Table B.1           | RN2018_main_restricted.tex             |   restricted_sample_2018.Rmd |  main_restricted           |
| Table B.2           | RN2018_hetmerit_all_restricted.tex     |   restricted_sample_2018.Rmd | heterogeneous merit all restricted |
| Table B.3           | RN2018_hetmerit_share_restricted.tex   |   restricted_sample_2018.Rmd | heterogeneous merit share restricted |
| Table B.4           | RN2018_hetmerit_margin_restricted.tex  |   restricted_sample_2018.Rmd | heterogeneous merit margin restricted |
| Table B.5           | RN2018_attitudes_restricted.tex        |   restricted_sample_2018.Rmd | general attitudes restricted | 
| Table C.1           | LAB_balance.tex                        |   lab_experiment.Rmd         | balance |
| Table C.2           | LAB_replication.tex                    | lab_experiment.Rmd | replication of main |
