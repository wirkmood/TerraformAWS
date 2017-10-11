## Welcome to GitHub Pages

<b>This script deploy a full infrastructure on AWS with terraform tools.</b>

- Network :
  * Networking 
  * Subnetwork
  * Public IP
  * NIC
- Security :
  * Network Access List
  * Security Group (Allow SSH / RDP / HTTP / HTTPS into inbound)
  * Import a SSH KEY
- Instance 
  * Images 
  * VMsize
  * Startup Script ( Bash scripting)
  
Prerequisite : 

1) edit variable.tf
- Fill out with your AWS login : 
  * Access Key
  * Security Key
- SSH Key :
  * Generate RSA Key and export the private and public key with putty gen  (https://www.ssh.com/ssh/keygen/)
  * Copy the RSA key by the new one into "AWSKeypair" variable
- Choise the image 
  * Uncomment the AMIID to select your AMIID disared. (maybe you would change AMIId variable by what AWS propose you)
  * Example : default 	= "ami-1e339e71"  	#ubuntu
- VM Size :
  * By default VMsize is t2.micro for free instances

2) edit template.tf 
- You can change some parameters with yours. (IP network / Subnet / IP NIC instance) Also you can create yours statics variables into variable.tf

3) install terraform on linux / windows / Mac
- Download terraform -
  * https://www.terraform.io/downloads.html
- Lunch terraform installation 
  * excecute terraform init

4) Start the script
- Deploy your infrastructure 
  * Lunch terraform apply (you can check the config with terraform plan)
- Destroy your infrastructure
  * terraform destroy
