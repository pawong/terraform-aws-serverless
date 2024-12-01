output "apigatewayv2_api_api_endpoint" {
  description = "The URI of the API"
  value       = try(aws_apigatewayv2_api.lambda_api.api_endpoint, "")
}
