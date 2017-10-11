<b>This script deploy a full infrastructure on AWS with terraform tools.</b>
<b>
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
</b>
  
<b>Prerequisite : </b>

<b>1) Edit variable.tf </b>
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

<b>2) Edit template.tf </b>
- You can change some parameters with yours. (IP network / Subnet / IP NIC instance) Also you can create yours statics variables into variable.tf

<b>3) Install terraform on linux / windows / Mac </b>
- Download the lastest terraform version
  * https://www.terraform.io/downloads.html
- Lunch terraform installation 
  * excecute terraform init

<b> 4) Start the script </b>
- Deploy your infrastructure 
  * Lunch <b>terraform apply</b> (you can check the config with terraform plan)
  * Check on AWS Portal
- Destroy your infrastructure
  * </b>terraform destroy<b>
