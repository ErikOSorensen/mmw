import pandas as pd
import os
from openai import OpenAI
from dotenv import load_dotenv
from tqdm import tqdm

# === CONFIG ===
INPUT_CSV = "motivations.csv"
OUTPUT_CSV = "classified_motivations.csv"
MODEL_NAME = "ft:gpt-3.5-turbo-0125:fair::BosTyFuR"  # Replace with your actual model name

# === Load API key ===
load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_KEY"))

# === Load motivations ===
df = pd.read_csv(INPUT_CSV)
df = df.dropna(subset=["motivation"])

# === System message used during fine-tuning ===
SYSTEM_MESSAGE = """You are a helpful assistant that categorizes motivations for decisions in an economic experiment, considering performance outcomes and redistribution choices.

**Context:**
Two participants attempt to solve up to 24 problems in 10 minutes. The participant who solves the most problems (Y, the winner) receives earnings proportional to their performance; the other (X, the loser) receives nothing.

A third party - the Decision Maker (DM) - can redistribute some of Y's earnings to X. After making their decision, the DM provides a written motivation. Your task is to classify these motivations into one of the following categories exhaustive and exclusive categories (choose only one from the list):

**"libertarian"**: Appeals to rules, procedures, or default entitlements - regardless of performance.

**"meritocrat - margin does not matter"**: Arguments based on performance or effort, but with no reference to the size of the performance gap.

**"meritocrat - margin matters"**: Arguments based on performance that explicitly reference the size of the performance gap or the relative number of problems solved.

**"egalitarian"**: Arguments favoring equal outcomes without any reference to merit, performance, or effort.

**"compensate"**: Motivation centers on helping the loser out, without merit-based or equality-based reasoning.

**"fairness"**: Vague or general appeals to fairness without further elaboration.

**"logic"**: The DM states that their choice was the logical or obvious one, without justification rooted in merit, fairness, or equality.

**"incentives"**: The motivation focuses on encouraging future effort or behavior (e.g., rewarding winners to incentivize performance).

**"no reason"**: The DM gives no coherent reason, or simply restates their decision, or no reason at all.

**"misunderstand"**: The DM clearly misunderstands the rules of the task or the meaning of the redistribution.

"""
# === Run inference ===
predicted_labels = []

for motivation in tqdm(df["motivation"], desc="Classifying"):
    user_message = f"Motivation provided by DM: {motivation.strip()}"

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
    "motivation": df["motivation"]
})

output_df.to_csv(OUTPUT_CSV, index=False)
print(f"✅ Saved results to {OUTPUT_CSV}")
