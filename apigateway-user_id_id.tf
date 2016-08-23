resource "aws_api_gateway_resource" "user_id2" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  parent_id = "${aws_api_gateway_resource.user_id.id}"
  path_part = "{id}"
}

resource "aws_api_gateway_method" "user_id" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.user_id2.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "user_id" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.user_id2.id}"
  http_method = "${aws_api_gateway_method.user_id.http_method}"
  integration_http_method = "POST"
  type = "AWS"
  uri = "arn:aws:apigateway:${var.region}:dynamodb:action/Query"
  request_templates = {
    "application/json" = "{
    \"TableName\": \"${var.role}-stns-osuser\",
    \"IndexName\": \"id-Index\",
    \"KeyConditionExpression\": \"id = :id\",
    \"ExpressionAttributeValues\": {
        \":id\": {
            \"S\": \"$input.params('id')\"
        }
    }
}"
  }
  passthrough_behavior = "WHEN_NO_TEMPLATES"
  depends_on = ["aws_api_gateway_method.user_id"]
  credentials = "${aws_iam_role.instance_role.arn}"
}

resource "aws_api_gateway_method_response" "user_id_200" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.user_id2.id}"
  http_method = "${aws_api_gateway_method.user_id.http_method}"
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "user_id" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  resource_id = "${aws_api_gateway_resource.user_id2.id}"
  http_method = "${aws_api_gateway_method.user_id.http_method}"
  status_code = "${aws_api_gateway_method_response.user_id_200.status_code}"
  response_templates = {
  "application/json" = "#set($inputRoot = $input.path('$'))
#foreach($Item in $inputRoot.Items) 
{
  \"$Item.name.S\": {
    \"id\": $Item.id.S,
    \"password\": \"$Item.password.S\",
    \"group_id\": $Item.group_id.S,
    \"directory\": \"$Item.directory.S\",
    \"shell\": \"$Item.shell.S\",
    \"gecos\": \"$Item.gecos.S\",
    \"keys\": [
      $Item.keys.S
    ],
    \"link_users\": $Item.link_users.S
  }
}
#if($foreach.hasNext),#end
#end"
  }
}
