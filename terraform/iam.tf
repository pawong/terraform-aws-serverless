resource "aws_iam_role" "iam_role" {
  name = "${var.project_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_vpc" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.lambda_model_policy.arn
}


resource "aws_iam_policy" "lambda_model_policy" {
  name = "${var.project_name}-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
  EOF
}

