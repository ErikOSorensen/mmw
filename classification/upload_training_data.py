import openai
import os
from dotenv import load_dotenv

load_dotenv()
client = openai.OpenAI(api_key=os.getenv("OPENAI_KEY"))

# Upload training file
with open("training_data.jsonl", "rb") as f:
    uploaded_file = client.files.create(file=f, purpose="fine-tune")

print(f"Uploaded file ID: {uploaded_file.id}")

# Start fine-tuning job
response = client.fine_tuning.jobs.create(
    training_file=uploaded_file.id,
    model="gpt-3.5-turbo"
)

print(f"Fine-tune job started: {response.id}")
