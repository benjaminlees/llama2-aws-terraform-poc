data "archive_file" "call_llm" {
  type        = "zip"
  source_file = "call-llm.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "call_llm" {
  filename      = "lambda_function_payload.zip"
  function_name = "call-llm"
  role          = aws_iam_role.lambda.arn
  handler       = "call-llm.handler"
  timeout       = 20

  source_code_hash = data.archive_file.call_llm.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = {
      ENDPOINT_NAME = var.model_endpoint
    }
  }
}

resource "aws_cloudwatch_log_group" "call_llm" {
  name = "/aws/lambda/${aws_lambda_function.call_llm.function_name}"

  retention_in_days = var.log_retention
}
