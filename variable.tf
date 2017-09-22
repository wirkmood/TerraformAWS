######################################################
# Variables for Template
######################################################

variable "AWSAccessKey" {
  type    	= "string"
  default 	= "*"
}

variable "AWSSecretKey" {
  type    	= "string"
  default 	= "*"
}

variable "Region" {
 type 		= "string"
 default	= "eu-west-2"
}

variable "AvailableAWS" {
 type		= "string"
 default	= "eu-west-2a"
}

variable "AWSKeypair" {
  type 	   	= "string"
  default  	= "ssh *RSA-PUBLIC-KEY*"
}

variable "TagEnvironment" {
    type    = "string"
    default = ""
}

variable "TagUsage" {
    type   	= "string"
    default = ""
}

variable "AMIId" {
  type		= "string"
  default  	= "ami-489f8e2c"  	#Linux AMI 
  #default 	= "ami-b1a2b2d5"  	#Suse Linux
  #default 	= "ami-996372fd"  	#ubuntu
  #default 	= "ami-03e7f667"  	#windows
  #default	= "ami-a1f5e4c5"	#redhat
}
  
 variable "VMsize" {
 type		= "string"
 default	= "t2.micro"
}


variable "InstanceName" {
 type		= "string"
 default	= "Instance1"
}
