## Installing the environment 
The following steps will set up the environment for the lab.

### Development Environment 

The terraform environment was developed on a Windows 11 OS using WSLv2. 

###Executing the script
1. Run the terraform script to create the test vm in the azure cloud. <br>
<br>

2. After the first run, the terrform-cloud-key-pair will be copied down to the local directory. Change the permissons by going to the properties and remove all inheritence and add the local user as the sole owner 

3. Run the terraform again 


4. 

. Extract the private key and save locally by executing the following command 

`.\terraform output -raw tls_private_key > id_rsa`

Note: This private key should be made available to the user as a download for the user to complete the lab <br>
<br>

Extract the public IP address and note the address 

`.\terraform output public_ip_address <public IP Address>`<br>
<br>

SSH into the virtual machine

`ssh -i id_rsa azureuser@<public_ip_address>`<br>
<br>

Copy the pcap (in the sampledata folder) file to the virtual machine to the /tmp directory

`scp -i id_rsa capture.cap azureuser@74.235.17.169:/tmp`<br>
<br>

The environment is ready for the lab. 
