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
 default	= "eu-central-1"
}

variable "AWSKeypair" {
  type 	   	= "string"
  default  	= "ssh-rsa **Key-RSA**"

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
  #default  = "ami-657bd20a"  	#Linux AMI 
  #default 	= "ami-c425e4ab"  	#Suse Linux
  default 	= "ami-1e339e71"  	#ubuntu
  #default 	= "ami-4703ad28"  	#windows
  #default	= "ami-d74be5b8"	#redhat
}
  
 variable "VMsize" {
 type		= "string"
 default	= "t2.micro"
}


variable "InstanceName" {
 type		= "string"
 default	= "Instance1"
}