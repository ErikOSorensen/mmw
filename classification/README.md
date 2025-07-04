# Running the main classification job

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
needs to be entered into the script in the next step.

## Running inference

When the fine tuned model is finished, the `run_inference.py` script needs
to have the name of the trained model into it. This script also needs
a copy of the system text that defines the motivation context. Running
the script, it will loop over the observations to be labelled - so 
network connection is necessary for the duration of the classification.


```sh
uv run run_inference.py
```

This will write a file called `classified_motivations.csv`. 