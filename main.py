import uvicorn
from fastapi import FastAPI
import requests


app = FastAPI()


@app.post("/generate/")
async def generate_text(prompt: str):
    headers = {
        "Content-Type": "application/json",
    }

    data = {
        "inputs": "What is Deep Learning?",
        "parameters": {
            "max_new_tokens": 20,
        },
    }

    generated_text = requests.post(
        "http://localhost:3000/generate", headers=headers, data=data
    )

    return {"generated_text": generated_text}


uvicorn.run(app, host="0.0.0.0", port=8000)
