import json

def lambda_handler(event, context):
    response = {
        "statusCode": 200,
        "body": "OK",
        "headers": {
            'Content-Type': 'text/html',
        }
    }
    return response

