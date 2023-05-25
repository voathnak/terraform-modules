data "aws_iam_policy_document" "lambda_assume_role_policy_docs" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "lambda_dynamodb_role_policy_docs" {
  statement {
    actions   = ["dynamodb:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "lambda_logs_access_policy_docs" {
  statement {
    actions   = ["logs:*"]
    resources = ["arn:aws:logs:*:*:*"]
  }
}
data "aws_iam_policy_document" "s3_full_access_assume_role_policy_docs" {
  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_role" "quick_set_lambda_role" {
  name = "${var.project_name}_${terraform.workspace}_general_lambda_role"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy_docs.json
}

resource "aws_iam_role_policy" "quick_set_access_lambda_policy" {
  #  attach policy to role
  name   = "${var.project_name}_${terraform.workspace}_s3_full_access_policy"
  role   = aws_iam_role.quick_set_lambda_role.id
  policy = data.aws_iam_policy_document.quick_set_access_lambda_policy_docs.json
}

data "aws_iam_policy_document" "quick_set_access_lambda_policy_docs" {
  source_policy_documents = [
    data.aws_iam_policy_document.lambda_dynamodb_role_policy_docs.json,
    data.aws_iam_policy_document.lambda_logs_access_policy_docs.json,
    data.aws_iam_policy_document.s3_full_access_assume_role_policy_docs.json,
  ]
}
