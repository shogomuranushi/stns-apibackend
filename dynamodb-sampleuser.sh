#!/bin/sh

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_DEFAULT_OUTPUT=json

aws dynamodb put-item \
    --table-name user-stns-osuser \
    --item '{ "name": {"S": "orenouser"},"directory": {"S": "/home/oreuser"},"gecos":  {"S": "null"},"group_id":  {"S": "1002"},"id":  {"S": "1002"},"keys":  {"S": "\"ssh-rsa\""},"link_users":  {"S": "null"},"link_users":  {"S": "null"},"password":  {"S": "null"},"shell":  {"S": "/bin/bash"} }'

aws dynamodb put-item \
    --table-name user-stns-osgroup \
    --item '{ "name": {"S": "orenogroup"},"id": {"S": "1002"},"link_groups":  {"S": "null"},"users":  {"S": "\"orenouser\""} }'

#    --item '{ \
#        "name": {"S": "ore"}, \
#        "directory": {"S": "/home/ore"}, \
#        "gecos":  {"S": "null"}, \
#        "group_id":  {"S": "1002"}, \
#        "id":  {"S": "1002"}, \
#        "keys":  {"S": "\"ssh-rsa\""}, \
#        "link_users":  {"S": "null"}, \
#        "password":  {"S": "null"}, \
#        "shell":  {"S": "/bin/bash"} \
#	}'
#aws dynamodb put-item \
#    --table-name user-stns-osgroup \
#    --item '{ \
#        "name": {"S": "ore"}, \
#        "id": {"S": "1002"}, \
#        "link_groups":  {"S": "null"}, \
#        "users":  {"S": "\"shogo\""} \
#	}'
