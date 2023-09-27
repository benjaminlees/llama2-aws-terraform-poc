data "aws_iam_policy_document" "sagemaker" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "sagemaker_user" {
  statement {
    effect    = "Allow"
    actions   = ["sagemaker:CreateApp"]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket", "s3:GetObject*"]
    resources = ["arn:aws:s3:::jumpstart-cache-prod-eu-west-2", "arn:aws:s3:::jumpstart-cache-prod-eu-west-2/*"]
  }
}

resource "aws_iam_role" "sagemaker_domain" {
  name               = "sagemaker-domain"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker.json
}

resource "aws_iam_role" "sagemaker_user" {
  name               = "sagemaker-user"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker.json
}

resource "aws_iam_policy" "sagemaker_user" {
  name   = "sagemaker-user"
  policy = data.aws_iam_policy_document.sagemaker_user.json
}

resource "aws_iam_role_policy_attachment" "sagemaker_user" {
  role       = aws_iam_role.sagemaker_user.name
  policy_arn = aws_iam_policy.sagemaker_user.arn
}

