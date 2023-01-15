from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from fastapi import Request
import sys, os, json, mariadb

app = FastAPI()
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

mariadb_user = os.getenv("MARIADB_USER")
mariadb_password = os.getenv("MARIADB_PASSWORD")
mariadb_host = os.getenv("MARIADB_HOST")
mariadb_port = os.getenv("MARIADB_PORT")
mariadb_database= os.getenv("MARIADB_DATABASE")

try:
    conn = mariadb.connect(
        user=mariadb_user,
        password=mariadb_password,
        host=mariadb_host,
        port=int(mariadb_port),
        database=mariadb_database,
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