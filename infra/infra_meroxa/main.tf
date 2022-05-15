terraform {
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 3.27"
    # }
    meroxa = {
      source  = "meroxa/meroxa"
      version = "1.5.0"
    }
  }

  required_version = ">= 0.14.9"
}


# provider "aws" {
#   profile = "default"
#   region  = "ap-southeast-2"
# }

# resource "aws_instance" "app_server" {
#   ami           = "ami-07cc15c3ba6f8e287"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "ExampleAppServerInstance"
#   }
# }


provider "meroxa" {
  access_token = "TODO" # optionally use MEROXA_ACCESS_TOKEN env var
}

# Configure PostgreSQL Resource

# resource "meroxa_resource" "credential_block" {
#   name = "credential-block"
#   type = "postgres"
#   url  = "postgres://example:5432/db"
#   credentials {
#     username = "foo"
#     password = "bar"
#   }
# }

# resource "meroxa_resource" "snowflake" {
#   name = "credential-block"
#   type = "snowflake"
#   url  = "https://XXXXXXXXXXXXXXX.ap-southeast-2.snowflakecomputing.com"
#   credentials {
#     username = "dave"
#     password = "TODO Public key"
#   }
# }
