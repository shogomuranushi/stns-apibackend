resource "aws_dynamodb_table" "dynamo_osuser" {
    name = "${var.role}-stns-osuser"
    read_capacity = 1
    write_capacity = 1
    hash_key = "name"
    attribute {
      name = "name"
      type = "S"
    }
    attribute {
      name = "id"
      type = "S"
    }
    global_secondary_index {
      name = "id-Index"
      hash_key = "id"
      write_capacity = 1
      read_capacity = 1
      projection_type = "ALL"
    }
}

resource "aws_dynamodb_table" "dynamo_osgroup" {
    name = "${var.role}-stns-osgroup"
    read_capacity = 1
    write_capacity = 1
    hash_key = "name"
    attribute {
      name = "name"
      type = "S"
    }
    attribute {
      name = "id"
      type = "S"
    }
    global_secondary_index {
      name = "id-Index"
      hash_key = "id"
      write_capacity = 1
      read_capacity = 1
      projection_type = "ALL"
    }
}
