data "aws_subnets" "private" {
  filter {
    name   = "tag:Terraform Tags"
    values = ["private"]
  }
}