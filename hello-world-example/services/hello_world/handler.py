import json


def lambda_handler(event, context):
    http_method = event.get('httpMethod')

    return {
        'statusCode': 200,
        'body': json.dumps({
            "message": "HelloWorld",
            "method": http_method,
        }),
        "headers": {
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": True,
        }
    }
