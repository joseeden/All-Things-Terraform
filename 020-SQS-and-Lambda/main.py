# main.py
#---------------------------------------------------------------------------
# Lambda function that processes data from an SQS queue.
# After two failed attempts, functino sends message to a dead letter queue.
#---------------------------------------------------------------------------

import json

def lambda_handler(event, context):
  for k, v in event.items():
    print(k, v)

  return {
    'StatusCode': 200,
    'body': json.dumps('I feel the need, the need for speed!')
  }