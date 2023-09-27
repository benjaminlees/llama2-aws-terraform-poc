resource "aws_sagemaker_domain" "main" {
  domain_name = "llama-2-demo"
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.main.id
  subnet_ids  = [aws_subnet.main.id]

  default_user_settings {
    execution_role = aws_iam_role.sagemaker.arn
  }
}

resource "aws_iam_role" "sagemaker" {
  name               = "sagemaker"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker.json
}

data "aws_iam_policy_document" "sagemaker" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}