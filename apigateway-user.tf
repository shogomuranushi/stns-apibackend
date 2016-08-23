resource "aws_api_gateway_rest_api" "user" {
  name = "${var.role}-stnsserver"
  description = "stns server"
}

resource "aws_api_gateway_api_key" "user" {
  name = "${aws_api_gateway_rest_api.user.name}"

  stage_key {
    rest_api_id = "${aws_api_gateway_rest_api.user.id}"
    stage_name = "${aws_api_gateway_deployment.user.stage_name}"
  }
}

resource "aws_api_gateway_deployment" "user" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  stage_name = "prod"

  depends_on = ["aws_api_gateway_method.user_name","aws_api_gateway_method.group_name"]
}

resource "aws_api_gateway_resource" "user" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  parent_id = "${aws_api_gateway_rest_api.user.root_resource_id}"
  path_part = "user"
}
