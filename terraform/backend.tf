terraform {
  backend "s3" {
    bucket = "terra-state-bucket-pomelo"
    key    = "tfstate"
    region = "us-east-1"
  }
}
