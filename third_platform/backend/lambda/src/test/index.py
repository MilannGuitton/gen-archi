import json
import logging
import socket

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def ping(host, port):

    # to ping a particular PORT at an IP
    # if the machine won't receive any packets from
    # the server for more than 3 seconds
    # i.e no connection is
    # made(machine doesn't have a live internet connection)
    # <except> part will be executed
    try:
        logger.info("Trying to connect")
        socket.setdefaulttimeout(3)

        # AF_INET: address family (IPv4)
        # SOCK_STREAM: type for TCP (PORT)
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        server_address = (host, port)

        # send connection request to the defined server
        s.connect(server_address)

    except OSError as error:

        # function returning false after
        # data interruption(no connection)
        logger.error("Could not connect")
        return False
    else:

        # the connection is closed after
        # machine being connected
        logger.info("Connect is ok")
        s.close()
        return True


def lambda_handler(event, context):
    is_google_ok = ping("8.8.8.8", 53)
    is_mysql_ok = ping("spacelift.ct51s2fxxugy.eu-west-3.rds.amazonaws.com", 3306)
    response = {
            "statusCode": 200,
            "body": f"Can I ping google ? {is_google_ok}   |   Can I ping my db ? {is_mysql_ok}",
            "headers": {
                'Content-Type': 'text/html',
                }
            }
    return response
