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
OUTPUT_FILE = "stake_small.csv"

# === Load data ===
df = pd.read_csv(INPUT_FILE)

# Prepare output dataframe
output = []

# === Prompt template ===
system_message = """You are a careful assistant. Your task is to determine whether a short 
motivation text in any way indicates that the monetary stakes are small. Note
that the numbers themselves are not directly meaningful, but we are looking for 
whether people mention small stake sizes as a reason for them making the 
redistributive decision - that is, implicitly, they would have done differently 
with a large stake size. Or saying that small stake size makes this an 
irrelevant or uninteresting choice.

If so, respond "yes". Otherwise, respond with "no".

Answer with only one word: "yes" or "no".
"""

# === Process each row ===
for _, row in tqdm(df.iterrows(), total=len(df)):
    id_val = row["id"]
    motivation = str(row["motivation"]).strip()

    if not motivation:
        output.append({"id": id_val, "mentions_small_stakes": "no"})
        continue

    user_prompt = f"Motivation: \"{motivation}\"\nDoes this mention the stake size being small?"

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

    output.append({"id": id_val, "mentions_small_stakes": answer, "motivation": motivation})

# === Save output ===
pd.DataFrame(output).to_csv(OUTPUT_FILE, index=False)
print(f"✅ Saved output to {OUTPUT_FILE}")
