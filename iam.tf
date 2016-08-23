resource "aws_iam_instance_profile" "instance_role" {
    name = "dynamodb-osuser-role"
    roles = ["${aws_iam_role.instance_role.name}"]
}

resource "aws_iam_role" "instance_role" {
    name = "dynamodb-osuser-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "instance_role_policy" {
    name = "dynamodb-osuser-policy"
    role = "${aws_iam_role.instance_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [ 
	"dynamodb:GetItem",
	"dynamodb:Query",
	"dynamodb:Scan"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
