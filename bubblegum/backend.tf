terraform {
  backend "s3" {
    bucket    = "jenkins-bucket2"
    key       = "bubblegum.tfstate"
    region    = "us-east-1"
    profile   = "loretta"
  }
}