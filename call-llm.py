import os
import io
import boto3
import json

# grab environment variables
ENDPOINT_NAME = os.environ['ENDPOINT_NAME']
runtime= boto3.client('runtime.sagemaker')

def handler(event, context):
    response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,
                                       ContentType='application/json',
                                       Body=event['body'],
                                       CustomAttributes="accept_eula=true")
    
    result = json.loads(response['Body'].read().decode())

    
    
    return {
        "statusCode": 200,
        "body": json.dumps(result)
    }