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
    effect = "Allow"
    actions = [
      "sagemaker:CreateApp",
      "sagemaker:AddTags",
      "sagemaker:ListTags",
      "sagemaker:CreateModel",
      "sagemaker:CreateEndpointConfig",
      "sagemaker:DescribeEndpointConfig",
      "sagemaker:CreateEndpoint",
      "sagemaker:DescribeEndpoint",
      "sagemaker:DescribeModel",
      "sagemaker:ListCompilationJobs",
      "sagemaker:ListMonitoringSchedules"
    ]
    // resources should be more specific here for better security
    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["iam:PassRole"]
    // resources should be more specific here for better security
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket", "s3:GetObject*"]
    resources = ["arn:aws:s3:::jumpstart-cache-prod-eu-west-1", "arn:aws:s3:::jumpstart-cache-prod-eu-west-1/*"]
  }
}

resource "aws_iam_role" "sagemaker_domain" {
  name               = "${var.project_name}-sagemaker-domain"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker.json
}

resource "aws_iam_role" "sagemaker_user" {
  name               = "${var.project_name}-sagemaker-user"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker.json
}

resource "aws_iam_policy" "sagemaker_user" {
  name   = "${var.project_name}-sagemaker-user"
  policy = data.aws_iam_policy_document.sagemaker_user.json
}

resource "aws_iam_role_policy_attachment" "sagemaker_user" {
  role       = aws_iam_role.sagemaker_user.name
  policy_arn = aws_iam_policy.sagemaker_user.arn
}

