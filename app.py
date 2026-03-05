from fastapi import FastAPI
from transformers import pipeline
from pydantic import BaseModel

app = FastAPI()
pipe = None


class Request(BaseModel):
    text: str


@app.on_event("startup")
def load_model():
    global pipe
    pipe = pipeline("text2text-generation", model="google/flan-t5-small")


@app.get("/")
def home():
    return {"message": "Hi"}


@app.post("/response")
def generate(req: Request):
    result = pipe(req.text)[0]["generated_text"]
    return {"response": result}