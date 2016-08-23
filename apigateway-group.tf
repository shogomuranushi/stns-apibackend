resource "aws_api_gateway_resource" "group" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  parent_id = "${aws_api_gateway_rest_api.user.root_resource_id}"
  path_part = "group"
}
