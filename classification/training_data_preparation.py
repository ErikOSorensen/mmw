import pandas as pd
import json

# === CONFIG ===
INPUT_CSV = "training_data.csv"
OUTPUT_JSONL = "training_data.jsonl"


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
