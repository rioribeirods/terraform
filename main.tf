provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  version = "~> 2.0"
  region  = "us-east-2"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = "${var.amis["us-east-1"]}"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["sg-075edaff647a54b3d"]
}

/*
resource "aws_instance" "dev3" {
  ami           = "${var.amis["us-east-1"]}"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  tags = {
    Name = "dev3"
  }
  vpc_security_group_ids = ["sg-075edaff647a54b3d"]
  depends_on = [ aws_s3_bucket.dev3 ]
}

resource "aws_s3_bucket" "dev3" {
  bucket = "my-tf-test-bucket-dev3"

  tags = {
    Name = "my-tf-test-bucket-dev3"
  }
}
*/

resource "aws_instance" "dev4" {
  ami           = "${var.amis["us-east-1"]}"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  tags = {
    Name = "dev4"
  }
  vpc_security_group_ids = ["sg-075edaff647a54b3d"]
}



resource "aws_instance" "dev5" {
  provider = "aws.us-east-2"
  ami           = "${var.amis["us-east-2"]}"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  tags = {
    Name = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.access-ssh-us-east-2.id}"]
  depends_on = [ "aws_dynamodb_table.dynamodb-table" ]
}

resource "aws_instance" "dev6" {
  provider = "aws.us-east-2"
  ami           = "${var.amis["us-east-2"]}"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  tags = {
    Name = "dev6"
  }
  vpc_security_group_ids = ["${aws_security_group.access-ssh-us-east-2.id}"]
}

resource "aws_dynamodb_table" "dynamodb-table" {
  provider = "aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}