from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from fastapi import Request
import mariadb
import sys
import json

app = FastAPI()
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

try:
    conn = mariadb.connect(
        user="tryhard",
        password="1234",
        host="p2-database.aws.tryhard.fr",
        port=80,
        database="mariondb",
        autocommit=True
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

try:
    cur = conn.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS scores (id SERIAL PRIMARY KEY, name VARCHAR(100), score INT)")
except mariadb.Error as e: 
    print(f"Error: {e}")

@app.get("/")
def read_root():
    res = []
    try:
        cur = conn.cursor()
        cur.execute("SELECT name, score FROM scores ORDER BY score DESC LIMIT 5")
        for (name, score) in cur:
            res.append({"name": name, "score": score})
    except mariadb.Error as e:
        print(f"Error: {e}")
    return res

@app.post('/')
async def main(request: Request):
    res = await request.json()
    try:
        cur = conn.cursor()
        print("DEBUG: ", res["name"], res["score"])
        cur.execute("INSERT INTO scores (name, score) VALUES (?, ?)", (res["name"], res["score"]))
    except mariadb.Error as e: 
        print(f"Error: {e}")
    return await request.json()