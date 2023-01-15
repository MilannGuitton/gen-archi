import logging
import pymysql
import os
import json

db_host = os.getenv('DB_HOST')
db_name = os.getenv('DB_NAME')
db_password = os.getenv('DB_PASSWORD')
db_username = os.getenv('DB_USERNAME')

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def response_with(status_code, message=None, content_type="text/html"):
    if content_type == "application/json":
        body = json.dumps(message)
    else:
        body = message

    response = {
        "statusCode": status_code,
        "headers": {'Content-Type': content_type},
        "body": body
    }

    return response


def lambda_handler(event, context):
    data = json.loads(event["body"])

    if not data["name"] or not data["score"]:
        return response_with(400, "Invalid arguments")

    try:
        connection = pymysql.connect(
            host=db_host,
            port = 3306,
            database=db_name,
            user=db_username,
            password=db_password,
            connect_timeout=2,
            autocommit=True)

    except pymysql.MySQLError as e:
        logger.error("ERROR: Unexpected error: Could not connect to MySQL instance." + e)
        connection.close()
        return response_with(400)

    logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")

    try:
        with connection:
            with connection.cursor() as cursor:
                cursor.execute("CREATE TABLE IF NOT EXISTS scores (id SERIAL PRIMARY KEY, name VARCHAR(100), score INT)")
                logger.info(f'Inserting ---> name: {data["name"]} | score: {data["score"]}')
                sql = "INSERT INTO scores (name, score) VALUES (%s, %s)"
                cursor.execute(sql, (data["name"], data["score"]))
                logger.info("Insert done")
    except pymysql.MySQLError as e:
        logger.error(e)
        return response_with(400)

    return response_with(200, "Insert done")
