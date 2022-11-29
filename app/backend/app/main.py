from typing import Union

from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from pydantic import BaseModel
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
        user="user",
        password="mypassword",
        host="127.0.0.1",
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

import csv

class List(BaseModel):
    name: str
    score: int


mylist = "0"

@app.get("/")
def read_root():
    '''f = open("../list.csv", "r")
    print(f.readlines())
    return 0'''
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
    '''with open('../list.csv', 'a', newline='') as csvfile:
        spamwriter = csv.writer(csvfile, delimiter=' ',
                                quotechar='|', quoting=csv.QUOTE_MINIMAL)
        spamwriter.writerow([res["name"], res["score"]])'''
    try:
        print("DEBUG: ", res["name"], res["score"])
        cur.execute("INSERT INTO scores (name, score) VALUES (?, ?)", (res["name"], res["score"]))
    except mariadb.Error as e: 
        print(f"Error: {e}")
    return await request.json()