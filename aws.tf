variable "role" {
    default = "user"
}

variable "region" {
    default = "ap-northeast-1"
}

provider "aws" {
    access_key = ""
    secret_key = ""
    region = "${var.region}"
}
