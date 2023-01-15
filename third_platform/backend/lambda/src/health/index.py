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
    try:
        connection = pymysql.connect(
            host=db_host,
            port = 3306,
            database=db_name,
            user=db_username,
            password=db_password,
            connect_timeout=5,
            autocommit=True)

    except pymysql.MySQLError as e:
        error_msg = "ERROR: Unexpected error: Could not connect to MySQL instance"
        logger.error(error_msg)
        logger.error(e)
        return response_with(400, error_msg)

    success_msg = "SUCCESS: Connection to RDS MySQL instance succeeded"
    logger.info(success_msg)
    return response_with(200, success_msg)

