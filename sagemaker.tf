resource "aws_sagemaker_domain" "main" {
  domain_name = "llama-2-demo"
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.main.id
  subnet_ids  = [aws_subnet.main.id]

  default_user_settings {
    execution_role = aws_iam_role.sagemaker_domain.arn
  }
}

resource "aws_sagemaker_user_profile" "test" {
  domain_id         = aws_sagemaker_domain.main.id
  user_profile_name = "test"

  user_settings {
    execution_role = aws_iam_role.sagemaker_user.arn
  }
}