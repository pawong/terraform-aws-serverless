# TERRAFORM AWS REST API

AWS + Terraform + Amazon API Gateway + AWS Lambda + VPC + VPC Endpoints

![Tests](https://github.com/pawong/terraform-aws-serverless/workflows/Tests/badge.svg)
[![codecov](https://codecov.io/gh/pawong/terraform-aws-serverless/graph/badge.svg?token=ITUY52M3AH)](https://codecov.io/gh/pawong/terraform-aws-serverless)

**WARNING**: AWS will probably charge you money!

## Prerequisites

### for Deployment:

- AWS Account
- AWS Command Line Tool (CLI) - `aws` [aws cli installation guide]
- Terraform
- Python
- Docker; if you don't have it yet, follow the [installation instructions];
- Docker Compose; refer to the official documentation for the [installation guide].
- Pre-commit; refer to the official documentation for the [pre-commit](https://pre-commit.com/#install).

## Run tests and type checking

Create isolated Python environment `python -m venv venv` and activate it `source venv/bin/activate`

Install all necessary dependencies: `pip install -r requirements-dev.txt`

Run tests:

    python -m pytest tests -v  # increase verbosity

with coverage report:

    python -m pytest --cov=app tests

Run type checking:

    mypy api

## Deploying to AWS

Start

```
% terraform init
% terraform apply --auto-approve
```

Result

```
...

aws_lambda_function.lambda_model_function: Creation complete after 12s [id=terraform-aws-serverless-lambda-function]
aws_apigatewayv2_api.lambda_api: Creating...
aws_apigatewayv2_api.lambda_api: Creation complete after 1s [id=f639je9l09]
aws_lambda_permission.api_gateway: Creating...
aws_apigatewayv2_integration.lambda_integration: Creating...
aws_apigatewayv2_stage.lambda_stage: Creating...
aws_lambda_permission.api_gateway: Creation complete after 0s [id=AllowExecutionFromAPIGateway]
aws_apigatewayv2_integration.lambda_integration: Creation complete after 0s [id=z2twyah]
aws_apigatewayv2_route.lambda_route: Creating...
aws_apigatewayv2_route.lambda_route: Creation complete after 0s [id=f8k952r]
aws_apigatewayv2_stage.lambda_stage: Creation complete after 0s [id=$default]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

apigatewayv2_api_api_endpoint = "https://f639je9l09.execute-api.us-west-2.amazonaws.com"
```

Force rebuild

```
% terraform apply -var "force_image_rebuild=true" --auto-approve
```

## Try an endpoint

Request

```
% curl -k https://f639je9l09.execute-api.us-west-2.amazonaws.com
```

Response

```
{"Hello":"World"}
```

Request

```
% curl -k https://f639je9l09.execute-api.us-west-2.amazonaws.com/api/v1/health
```

Response

```
"OK - 1732918490"
```
