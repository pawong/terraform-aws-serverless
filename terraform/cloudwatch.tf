resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${aws_lambda_function.lambda_model_function.function_name}"

  retention_in_days = 1

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }
}
