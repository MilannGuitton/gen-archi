from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from fastapi import Request
import mariadb
import sys

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
        host="10.0.0.30",
        port=3306,
        database="mariondb"
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

cur = conn.cursor()

try:
    cur.execute("CREATE TABLE IF NOT EXISTS scores (id SERIAL PRIMARY KEY, name VARCHAR(100), score INT)")
except mariadb.Error as e: 
    print(f"Error: {e}")

@app.get("/")
def read_root():
    try:
        cur.execute("SELECT * FROM scores")
        for (id, name, score) in cur:
            print(f"ID: {id}, Name: {name}, Score: {score}")
    except mariadb.Error as e:
        print(f"Error: {e}")
    return 0

@app.post('/')
async def main(request: Request):
    res = await request.json()
    try:
        print("DEBUG: ", res["name"], res["score"])
        cur.execute("INSERT INTO scores (name, score) VALUES (?, ?)", (res["name"], res["score"]))
    except mariadb.Error as e: 
        print(f"Error: {e}")
    return await request.json()