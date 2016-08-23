output "API Gateway URL" {
    value = "https://${aws_api_gateway_rest_api.user.id}.execute-api.${var.region}.amazonaws.com/prod"
}

output "API Key" {
    value = "${aws_api_gateway_api_key.user.id}"
}
