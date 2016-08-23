resource "aws_api_gateway_resource" "group_name2" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  parent_id = "${aws_api_gateway_resource.group_name.id}"
  path_part = "{name}"
}

resource "aws_api_gateway_method" "group_name" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.group_name2.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "group_name" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.group_name2.id}"
  http_method = "${aws_api_gateway_method.group_name.http_method}"
  integration_http_method = "POST"
  type = "AWS"
  uri = "arn:aws:apigateway:${var.region}:dynamodb:action/GetItem"
  request_templates = {
    "application/json" = "{
  \"TableName\": \"${var.role}-stns-osgroup\",
  \"Key\": {
    \"name\": {
      \"S\": \"$input.params().path.name\"
    }
  }
}"
  }
  passthrough_behavior = "WHEN_NO_TEMPLATES"
  depends_on = ["aws_api_gateway_method.group_name"]
  credentials = "${aws_iam_role.instance_role.arn}"
}

resource "aws_api_gateway_method_response" "group_name_200" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.group_name2.id}"
  http_method = "${aws_api_gateway_method.group_name.http_method}"
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "group_name" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.group_name2.id}"
  http_method = "${aws_api_gateway_method.group_name.http_method}"
  status_code = "${aws_api_gateway_method_response.group_name_200.status_code}"
  response_templates = {
  "application/json" = "#set($inputRoot = $input.path('$'))
{
  \"$inputRoot.Item.name.S\": {
    \"id\": $inputRoot.Item.id.S,
    \"users\": [ $inputRoot.Item.users.S ],
    \"link_groups\": $inputRoot.Item.link_groups.S
  }
}"
  }
}
