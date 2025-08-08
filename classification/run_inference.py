import argparse
import pandas as pd
import os
import hashlib
from datetime import datetime
from openai import OpenAI
from dotenv import load_dotenv
from tqdm import tqdm
from systems import SYSTEMS_LIST

# === Parse command-line arguments ===
parser = argparse.ArgumentParser(description="Classify motivations using a GPT model.")
parser.add_argument(
    "--model",
    type=str,
    required=True,
    help="The GPT model to use (e.g., 'gpt-o4', '-gpt-o4-mini', or a fine-tuned model)."
)
parser.add_argument(
    "--system",
    type=int,
    required=True,
    help="The index of the system message to use (0-based index)."
)
args = parser.parse_args()
MODEL_NAME = args.model
SYSTEM_INDEX = args.system

# === CONFIG ===
INPUT_CSV = "motivations.csv"
BASE_OUTPUT_CSV = "classified_motivations.csv"

# === Generate timestamped output file name ===
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
OUTPUT_CSV = f"{timestamp}_{BASE_OUTPUT_CSV}"

# === Load API key ===
load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_KEY"))

# === Load motivations ===
df = pd.read_csv(INPUT_CSV)
df = df.dropna(subset=["motivation"])

# === System message used during fine-tuning ===
SYSTEM_MESSAGE = SYSTEMS_LIST[SYSTEM_INDEX]

# === Compute hash of SYSTEM_MESSAGE ===
system_hash = hashlib.sha256(SYSTEM_MESSAGE.encode("utf-8")).hexdigest()

# === Run inference ===
predicted_labels = []

for motivation in tqdm(df["motivation"], desc="Classifying"):
    user_message = (
        f"Classify the following motivation into a single category label (from the list). "
        f"Return only the label, with no additional explanation.\n\n"
        f"Motivation: {motivation.strip()}"
    )

    try:
        response = client.chat.completions.create(
            model=MODEL_NAME,
            messages=[
                {"role": "system", "content": SYSTEM_MESSAGE},
                {"role": "user", "content": user_message}
            ],
            temperature=0
        )
        label = response.choices[0].message.content.strip()
    except Exception as e:
        label = f"ERROR: {e}"

    predicted_labels.append(label)

# === Save output ===
output_df = pd.DataFrame({
    "id": df["id"],
    "predicted_label": predicted_labels,
    "motivation": df["motivation"],
    "model_name": MODEL_NAME,
    "system_message_hash": system_hash
})

output_df.to_csv(OUTPUT_CSV, index=False)
print(f"✅ Saved results to {OUTPUT_CSV}")
