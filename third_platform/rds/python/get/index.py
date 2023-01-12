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
    logger.error(e)
    sys.exit()

logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")

def lambda_handler(event, context):
    try:
        cur.execute("SELECT * FROM scores")
        for (id, name, score) in cur:
            print(f"ID: {id}, Name: {name}, Score: {score}")
    except mariadb.Error as e:
        print(f"Error: {e}")
    return 0

