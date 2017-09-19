provider "aws" {
    access_key  = "${var.AWSAccessKey}"
    secret_key  = "${var.AWSSecretKey}"
    region      = "${var.Region}"
}