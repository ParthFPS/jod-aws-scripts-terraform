# This Code prints event details to CloudWatch Logs
import json

def lambda_handler(event, context):
    print("Received event:")
    print(json.dumps(event, indent=2))
    return {
        'statusCode': 200,
        'body': json.dumps('Event logged successfully')
    }