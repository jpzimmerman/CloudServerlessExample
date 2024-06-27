resource "aws_iam_role" "quick_lambda_role" {
  name               = "lambda_function_role"
  assume_role_policy = file("json/role.json")
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM Policy for AWS Lambda role"
  policy      = file("json/policy.json")
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.quick_lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/../../../sample-lambda.zip"
  function_name = "Sample_Lambda_Function"
  role          = aws_iam_role.quick_lambda_role.arn
  handler       = "sample.lambda_handler"
  runtime       = "python3.10"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}