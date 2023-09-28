data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_execution" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    // resources should be more specific here for better security
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:InvokeEndpoint"
    ]
    // resources should be more specific here for better security
    resources = ["*"]
  }
}



resource "aws_iam_policy" "lambda" {
  name   = "${var.project_name}-lambda"
  policy = data.aws_iam_policy_document.lambda_execution.json
}


resource "aws_iam_role" "lambda" {
  name               = "${var.project_name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}