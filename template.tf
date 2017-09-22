#########################################
# Deployer une vm Linux avec terraform  #
#########################################

##############################################################################
# Network
##############################################################################

######################
# Creating Network
######################

# Creating VPC / 172.16.0.0/16 
resource "aws_vpc" "vpc-001" {

    cidr_block = "172.16.0.0/16"

     tags {
        environment = "${var.TagEnvironment}"
        usage       = "${var.TagUsage}"
        Name        = "vpc-001"
    }
}

# Creating Subnet with VPC
resource "aws_subnet" "subnet-001" {

    vpc_id      = "${aws_vpc.vpc-001.id}"
    cidr_block  = "172.16.1.0/24"
    availability_zone = "${var.AvailableAWS}"
    #map_public_ip_on_launch = true

    tags {
        environment = "${var.TagEnvironment}"
        usage       = "${var.TagUsage}"
        Name        = "subnet-001"
    } 
}

##############################################################################
# Security networking
##############################################################################

######################
# Network Access List
# NACL ANY TO ANY
######################

# Network ACL associated in VPC network
resource "aws_network_acl" "Network-ACL" {

    vpc_id = "${aws_vpc.vpc-001.id}"
    subnet_ids = ["${aws_subnet.subnet-001.id}"]

    tags {
        environment = "${var.TagEnvironment}"
        usage       = "${var.TagUsage}"
        Name        = "Network-ACL"
    }
}

# Rule NACL group 

# ACL Rule In to Any
resource "aws_network_acl_rule" "Network-ACL-RuleIn" {
    
    network_acl_id = "${aws_network_acl.Network-ACL.id}"
    rule_number = 1098
    egress = false
    protocol = "-1"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "0"
    to_port = "0"

}

# ACL Rule Out to Any
resource "aws_network_acl_rule" "Network-ACL-RuleOut" {
    
    network_acl_id = "${aws_network_acl.Network-ACL.id}"
    rule_number = 1099
    egress = true
    protocol = "-1"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "0"
    to_port = "0"
}

##############################################################################
# Security port
##############################################################################

######################
# Security Group
######################

# Creating Security group
resource "aws_security_group" "NSG-001" {

    name = "NSG-001"
    description = "Security Group for vm"
    vpc_id = "${aws_vpc.vpc-001.id}"
    tags {
        environment = "${var.TagEnvironment}"
        usage       = "${var.TagUsage}"
        Name        = "NSG-001"  
    }
}

# Rule Security group 

# Rules RDP
resource "aws_security_group_rule" "NSG-001-RDPin" {

    type = "ingress"
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.NSG-001.id}"   
}

# HTTP RULE
resource "aws_security_group_rule" "NSG-001-HTTPIn" {

    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.NSG-001.id}"
}

# HTTPS RULE
resource "aws_security_group_rule" "NSG-001-HTTPSIn" {

    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.NSG-001.id}"
}

# Rules SSH
resource "aws_security_group_rule" "NSG-001-SSHIn" {

    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.NSG-001.id}"   
}

# Rule to Any 
resource "aws_security_group_rule" "NSG-001-AnyOut" {

    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.NSG-001.id}"	
}

##############################################################################
# Routing
##############################################################################

######################
# Internet GW				
######################

# Creating internet Gateway
resource "aws_internet_gateway" "network-gw" {
    vpc_id = "${aws_vpc.vpc-001.id}"
        tags {
        environment = "${var.TagEnvironment}"
        usage       = "${var.TagUsage}"
        Name        = "network-gw"
    }
}

######################
# Routing table				
######################

# Creating route table
resource "aws_route_table" "default-route" {
    vpc_id          = "${aws_vpc.vpc-001.id}" 	
    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = "${aws_internet_gateway.network-gw.id}"
    }
    tags {
        environment = "${var.TagEnvironment}"
        usage       = "${var.TagUsage}"
        Name        = "default-route"
    }
}

# association subnet route table
resource "aws_route_table_association" "Sub1-association" {
    subnet_id       = "${aws_subnet.subnet-001.id}"
    route_table_id  = "${aws_route_table.default-route.id}"
}

####################
# Public IP Address
####################

# Creating Public IP VM
resource "aws_eip" "vm-eip" {
    vpc 				= true
    network_interface	= "${aws_network_interface.nic-vm.id}"
}

##############################################################################
# NIC 
##############################################################################

####################
# Creating NIC
####################

resource aws_network_interface "nic-vm" {
    subnet_id = "${aws_subnet.subnet-001.id}"
    private_ips = ["172.16.1.90"]
	tags {
		environment = "${var.TagEnvironment}"
		usage       = "${var.TagUsage}"
		Name        = "nic-vm"
    }
}

####################
# NIC association
####################

# NIC and SG association
resource "aws_network_interface_sg_attachment" "NIC-SGVM" {

 security_group_id       = "${aws_security_group.NSG-001.id}"
 network_interface_id    = "${aws_network_interface.nic-vm.id}"
}

##############################################################################
# Instance configuration
##############################################################################

####################
# Import SSH KEY
####################

# AWS Keypair
resource "aws_key_pair" "key-access" {
  key_name   = "key-access"
  public_key = "${var.AWSKeypair}"
  }
  
####################
# Instance Creation
####################
  
# Creating  VM
resource "aws_instance" "VM-001" {
  ami 					= "${var.AMIId}"
  instance_type 			= "${var.VMsize}"
  #security_groups		    	= "${aws_security_group.NSG-001.id}"
  key_name 				= "${aws_key_pair.key-access.key_name}" 
  network_interface {
    network_interface_id 		= "${aws_network_interface.nic-vm.id}"
    device_index = 0
  }
  user_data 				= "${file("install_apache.sh")}"
  tags {
    environment 			= "${var.TagEnvironment}"
    usage       			= "${var.TagUsage}"
    Name 				= "${var.InstanceName}"
  }
}

####################
# Out
####################

output "Public IP instance" {
  value = "${aws_instance.VM-001.public_ip}"
}

output "Private IP  instance" {
  value = "${aws_instance.VM-001.private_ip}"
}
