resource "aws_apigatewayv2_api" "main" {
  name          = var.project_name
  protocol_type = "HTTP"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.main.name}"

  retention_in_days = 5
}

resource "aws_apigatewayv2_stage" "main" {
  api_id = aws_apigatewayv2_api.main.id

  name        = var.project_name
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.main.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "call_llm_lambda" {
  api_id = aws_apigatewayv2_api.main.id

  integration_uri    = aws_lambda_function.call_llm.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "all_llm" {
  api_id = aws_apigatewayv2_api.main.id

  route_key = "POST /call-llm"
  target    = "integrations/${aws_apigatewayv2_integration.call_llm_lambda.id}"
}

resource "aws_lambda_permission" "call_llm_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.call_llm.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}