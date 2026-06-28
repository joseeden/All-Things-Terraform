# lab02_dev_sqs_lambda
#--------------------------------------------------------------
# This terraform template deploys a main SQS queue which will 
# trigger a Lambda function.
#--------------------------------------------------------------

# Creates a zip file of the main.py function.
data "archive_file" "tfzip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

# Creates lambda function
resource "aws_lambda_function" "lambda_python_test" {
  filename         = "main.zip"
  function_name    = "lambda_python_test"
  role             = aws_iam_role.lambda_python_test_iam_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("main.zip")
}

# Creates lambda IAM role.
resource "aws_iam_role" "lambda_python_test_iam_role" {
  name = "lambda_python_test_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole", 
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Create SQS-Main queue
resource "aws_sqs_queue" "lab2-main-queue" {
  name                      = "lab2-main-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create SQS-dead letter queue
resource "aws_sqs_queue" "lab2-dlq-queue" {
  name                      = "lab2-dlq-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Create the policy document which will contain the actions for 
# accessing the SQS main queue.
data "aws_iam_policy_document" "sqs-policy-doc" {

  statement {
    sid = "1"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      aws_sqs_queue.lab2-main-queue.arn,
      aws_sqs_queue.lab2-dlq-queue.arn
    ]
  }

  statement {
    sid = "2"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogDelivery",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

# Creates the policy from the policy document.
resource "aws_iam_policy" "sqs-policy" {
  name   = "sqs-policy"
  policy = data.aws_iam_policy_document.sqs-policy-doc.json
}

# Attaches the policy to the IAM role
resource "aws_iam_role_policy_attachment" "sqs-policy-attach" {
  role       = aws_iam_role.lambda_python_test_iam_role.name
  policy_arn = aws_iam_policy.sqs-policy.arn
}

# Creates the mapping between the SQS main queue and Lambda function.
resource "aws_lambda_event_source_mapping" "sqs-trigger" {
  event_source_arn = aws_sqs_queue.lab2-main-queue.arn
  function_name    = aws_lambda_function.lambda_python_test.arn
}

# Creates the CloudWatch Log group which will contain the Lambda logs
resource "aws_cloudwatch_log_group" "example" {
  name = "/aws/lambda/${aws_lambda_function.lambda_python_test.function_name}"
}

