import sys
import logging
import pymysql
import os

rds_host = os.getenv('ENDPOINT')
name = os.getenv('NAME')
password = os.getenv('PASSWORD')
db_name = "mariondb"

logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    conn = pymysql.connect(host=rds_host, user=name, passwd=password, db=db_name, connect_timeout=5)
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.info(f"{rds_host} - {name} - {password} - {db_name}")
    logger.error(e)
    sys.exit()

logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")
def lambda_handler(event, context):
    res = event.json()
    try:
        print("DEBUG: ", res["name"], res["score"])
        cur.execute("INSERT INTO scores (name, score) VALUES (?, ?)", (res["name"], res["score"]))
    except mariadb.Error as e:
        print(f"Error: {e}")
