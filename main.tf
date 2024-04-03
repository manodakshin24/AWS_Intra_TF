provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "static_website" {
  bucket = "my-first-bucket-from-terraform"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = "my-first-bucket-from-terraform"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "devops_bucket" {
  bucket = "mano-test-bucket-1"
  force_destroy = true
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket" "delete-later" {
  bucket = "will-delete-later"
  force_destroy = true
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}


resource "aws_s3_bucket" "devops_bucket_1" {
  bucket = "mano-test-bucket1234"
  tags = {
      Env = "dev"
      Service = "s3"
      Team = "devops"
  }
}

resource "aws_s3_bucket_versioning" "versioning_cf" {
  bucket = "mano-test-bucket1234"
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_object" "Mano_folder" {
  bucket = aws_s3_bucket.devops_bucket_1.id
  key    = "Mano/dakshin/"
}


resource "aws_instance" "example_ec2_instance" {
  ami = "ami-0faac27e2fc42cead"
  instance_type = "t2.micro"
  count         = 1

  tags = {
    Name = "MDak"
  }
}