import os
import pandas as pd
from openai import OpenAI
from dotenv import load_dotenv
from tqdm import tqdm

# === Load environment ===
load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_KEY"))

# === Config ===
INPUT_FILE = "motivations.csv"
OUTPUT_FILE = "stake_mentions.csv"

# === Load data ===
df = pd.read_csv(INPUT_FILE)

# Prepare output dataframe
output = []

# === Prompt template ===
system_message = """You are a careful assistant. Your task is to determine whether a short motivation text mentions the *size* of the financial stakes or amounts involved in a decision.

If the motivation contains any mention of money amounts, the size of bonuses, large or small rewards, financial impact, or comparable language — respond with "yes".

Otherwise, respond with "no".

Answer with only one word: "yes" or "no".
"""

# === Process each row ===
for _, row in tqdm(df.iterrows(), total=len(df)):
    id_val = row["id"]
    motivation = str(row["motivation"]).strip()

    if not motivation:
        output.append({"id": id_val, "mentions_stake_size": "no"})
        continue

    user_prompt = f"Motivation: \"{motivation}\"\nDoes this mention stake size?"

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {"role": "system", "content": system_message},
                {"role": "user", "content": user_prompt}
            ],
            temperature=0
        )
        answer = response.choices[0].message.content.strip().lower()
        if answer not in {"yes", "no"}:
            answer = "unclear"
    except Exception as e:
        print(f"⚠️ Error for id {id_val}: {e}")
        answer = "error"

    output.append({"id": id_val, "mentions_stake_size": answer, "motivation": motivation})

# === Save output ===
pd.DataFrame(output).to_csv(OUTPUT_FILE, index=False)
print(f"✅ Saved output to {OUTPUT_FILE}")
