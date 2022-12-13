// API GATEWAY
resource "aws_api_gateway_rest_api" "serverless_event" {
  name = "serverless-event"
}

// API1
resource "aws_api_gateway_resource" "api1" {
  path_part   = "api1"
  parent_id   = aws_api_gateway_rest_api.serverless_event.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.serverless_event.id
}

resource "aws_api_gateway_method" "api1_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_event.id
  resource_id   = aws_api_gateway_resource.api1.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api1_post_method_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_event.id
  resource_id             = aws_api_gateway_resource.api1.id
  http_method             = aws_api_gateway_method.api1_post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.fn_api1.invoke_arn
}

resource "aws_api_gateway_method_response" "api1_post_method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.serverless_event.id
  resource_id = aws_api_gateway_resource.api1.id
  http_method = aws_api_gateway_method.api1_post_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.api1_post_method]
}

resource "aws_lambda_permission" "api_gateway_fn_api1" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fn_api1.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.serverless_event.execution_arn}/*/*/${aws_api_gateway_resource.api1.path_part}"
}


// API2
resource "aws_api_gateway_resource" "api2" {
  path_part   = "api2"
  parent_id   = aws_api_gateway_rest_api.serverless_event.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.serverless_event.id
}

resource "aws_api_gateway_method" "api2_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_event.id
  resource_id   = aws_api_gateway_resource.api2.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api2_post_method_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_event.id
  resource_id             = aws_api_gateway_resource.api2.id
  http_method             = aws_api_gateway_method.api2_post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.fn_api2.invoke_arn
}

resource "aws_api_gateway_method_response" "api2_post_method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.serverless_event.id
  resource_id = aws_api_gateway_resource.api2.id
  http_method = aws_api_gateway_method.api2_post_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.api2_post_method]
}

resource "aws_lambda_permission" "api_gateway_fn_api2" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fn_api2.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.serverless_event.execution_arn}/*/*/${aws_api_gateway_resource.api2.path_part}"
}

// API3
resource "aws_api_gateway_resource" "api3" {
  path_part   = "api3"
  parent_id   = aws_api_gateway_rest_api.serverless_event.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.serverless_event.id
}

resource "aws_api_gateway_method" "api3_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_event.id
  resource_id   = aws_api_gateway_resource.api3.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api3_post_method_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_event.id
  resource_id             = aws_api_gateway_resource.api3.id
  http_method             = aws_api_gateway_method.api3_post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.fn_api3.invoke_arn
}

resource "aws_api_gateway_method_response" "api3_post_method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.serverless_event.id
  resource_id = aws_api_gateway_resource.api3.id
  http_method = aws_api_gateway_method.api3_post_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.api3_post_method]
}

resource "aws_lambda_permission" "api_gateway_fn_api3" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fn_api3.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.serverless_event.execution_arn}/*/*/${aws_api_gateway_resource.api3.path_part}"
}

// DEPLOY
resource "aws_api_gateway_deployment" "rest_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.serverless_event.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.serverless_event.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.api1_post_method_integration,
    aws_api_gateway_integration.api2_post_method_integration,
    aws_api_gateway_integration.api3_post_method_integration,
  ]
}


// STAGE
resource "aws_api_gateway_stage" "rest_api_stage" {
  deployment_id = aws_api_gateway_deployment.rest_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.serverless_event.id
  stage_name    = "v7"
}
