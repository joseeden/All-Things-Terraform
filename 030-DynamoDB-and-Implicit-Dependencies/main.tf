# lab08 - Deploy a DynamoDB and a table item.
#----------------------------------------------------

resource "aws_dynamodb_table_item" "lab08-ddb-table-item" {
  table_name = aws_dynamodb_table.lab08-ddb-table.name
  hash_key   = aws_dynamodb_table.lab08-ddb-table.hash_key

  item = <<ITEM
{
  "ddbHashKey": {"S": "StartTheCountdown"},
  "four": {"N": "44444"},
  "three": {"N": "33333"},
  "two": {"N": "22222"},
  "one": {"N": "11111"}
}
ITEM
}

resource "aws_dynamodb_table" "lab08-ddb-table" {
  name           = "lab08-ddb-table"
  hash_key       = "ddbHashKey"
  read_capacity  = 10
  write_capacity = 10

  attribute {
    name = "ddbHashKey"
    type = "S"
  }
}