resource "aws_lambda_function" "lambda_model_function" {
  function_name = "${var.project_name}-lambda-function"

  role = aws_iam_role.iam_role.arn

  # tag is required, "source image ... is not valid" error will pop up
  image_uri    = "${aws_ecr_repository.repo.repository_url}:latest"
  package_type = "Image"

  # we can check the memory usage in the lambda dashboard, sklearn is a bit memory hungry..
  memory_size = 256

  # Uncomment the next line if you have an M1 processor
  # architectures = [ "arm64" ]
  depends_on = [aws_iam_role.iam_role, null_resource.image]
}
