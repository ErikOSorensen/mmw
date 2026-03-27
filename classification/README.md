# Running the main classification job

The pipeline depends on 1) R for prepping and analysing data and 2) "uv" to
manage python code for the classification.

## Classes of files and flows


| Role of file | File name | Description |
|---|---|---|
| Preparing data | normalize_data.R | Data from experiment to input for LLM |
| Preparing data | classifications_defs.R | Unified names of categories |
| Preparing data | B1.csv | Manual classifications I |
| Preparing data | B2.csv | Manual classifications II |
| Preparing data | motivations.csv | Full list of motivations from experiment |
| Preparing data | training_data.csv | Output from normalization |
| Preparing data | training_data.jsonl | Output from normalization adapted for fine tuning LLM |
| Preparing data | training_data_preparation.py | Takes training_data.csv and outputs training_data.jsonl |
| Running inference | run_inference.py | Python interaction with Open AI |
| Running inference | systems.py | Instructions for LLM |
| Running inference | upload_training_data.py | Uploading training_data.jsonl for finetuning |
| Running inference | TIMESTAMPS_classified_motivations.zip | Output from inference (20 .csv files) |
| Analysis | tvariants.tex | Output comparing models |
| Analysis | explore_classifications.R | Analysing classifications |
| Analysis | explore_classifications.html | Analysis of classifications (output) |
| System config | classifications.Rproj | R project file |
| System config | pyproject.toml | Project definition for Python programs |
| System config | uv.lock | Specification of Python dependencies |
| System config | .env.example  | Example for how Open AI API key is entered | 
| Documentation | README.md | This file |


## Preparing data
First, the `normalize_data.R` takes the `B1.csv` and `B2.csv` which contains 
manual encodings, and combine it with `classifications_defs.csv`, the labels that
should be used. The file `training_data.csv` is created.


## Prepping the model

The following command takes the `training_data.csv` and preps it into 
the `.jsonl` format that the openai api expects. The second line
then uploads the file to the openai. This depends on a `.env` file
which define `sh OPENAI_KEY=sk-XXX`, your OPENAI API key (which needs
to be loaded with some money, 10 USD is plenty).

```sh
uv run training_data_preparation.py
uv run upload_training_data.py
```

Note that the second file includes detailed instructions for how the data
should be interpreted and which categories should be applied.

Now it is necessary to wait for the openai servers to prepare the fine-tuned
model. This can easily take an hour. The following command will query the
openai server to see progress. Your computer does not need continuous network
for the fine-tuning operation. Make sure that your `OPENAI_API_KEY` is available
in the environment.

```sh
uv run openai api fine_tuning.jobs.list
```

When the model is prepared, there will be output that contains the name of the
server. Here is an example: 

```
  {
      "id": "ftjob-ZeyHoVyGBWNj6L0vu0JLdyVn",
      "created_at": 1751462139,
      "error": {
        "code": null,
        "message": null,
        "param": null
      },
      "fine_tuned_model": "ft:gpt-3.5-turbo-0125:fair::BorxnCYH",
      "finished_at": 1751463533,
```

The key feature is the value of the "fine_tuned_model" key. This key
needs to be used as a command line argument to the inference script.

## Running inference

When the fine tuned model is finished, the `run_inference.py` script needs
to have the name of the trained model into it. This script also needs
a copy of the system text that defines the motivation context. Running
the script, it will loop over the observations to be labelled - so 
network connection is necessary for the duration of the classification.


```sh
uv run run_inference.py
```
With the proper command line arguments, this will write a file 
called `TIMESTAMP_classified_motivations.csv` where
`TIMESTAMP` is the time the classification was run. This file contains 
specification of the parameters used for running the inference script.


## Analysis 

First unzip the `TIMESTAMPS_classified_motivations.zip` file.
Running the `explore_classifications.Rmd` will now do the necessary
analysis. 