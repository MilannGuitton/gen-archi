import json

import boto3

region = 'eu-west-3'


def lambda_handler(event, context):
    content = ("<!DOCTYPE html>\n<html>\n<head>\n"
        + "<title>GWENARCHI</title>\n</head>\n<body>\n\n"
        + f"<h1>COUCOU</h1>\n"
        + '<p><a href="https://start.strapi.sdi.aws.tryhard.fr">Start Strapi</a></p>'
        + '<p><a href="https://stop.strapi.sdi.aws.tryhard.fr">Stop Strapi</a></p>'
        + "</body>\n</html>\n")
    response = {
        "statusCode": 200,
        "body": content,
        "headers": {
            'Content-Type': 'text/html',
        }
    }
    return response

