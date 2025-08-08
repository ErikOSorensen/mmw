import pandas as pd
import json
from systems import SYSTEM_MESSAGE_1

# === CONFIG ===
INPUT_CSV = "training_data.csv"
OUTPUT_JSONL = "training_data.jsonl"

SYSTEM_MESSAGE = SYSTEM_MESSAGE_1

# === LOAD CSV ===
df = pd.read_csv(INPUT_CSV)

# === CLEAN & FORMAT ===
jsonl_lines = []

for _, row in df.iterrows():
    user_prompt = f"Motivation provided by DM: {row['motivation'].strip()}"
    label = row['classification'].strip()

    entry = {
        "messages": [
            {"role": "system", "content": SYSTEM_MESSAGE},
            {"role": "user", "content": user_prompt},
            {"role": "assistant", "content": label}
        ]
    }

    jsonl_lines.append(json.dumps(entry, ensure_ascii=False))

# === SAVE TO FILE ===
with open(OUTPUT_JSONL, "w", encoding="utf-8") as f:
    for line in jsonl_lines:
        f.write(line + "\n")

print(f"✅ Saved {len(jsonl_lines)} examples to {OUTPUT_JSONL}")
