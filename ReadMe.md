## EVALUATOR PLEASE READ 
The following steps will set up the environment for the lab.

### Prerequisites for the environment setup 

Run the terraform script to create the test vm in the azure cloud. <br>
<br>

Extract the private key and save localy by executing the following command 

`.\terraform output -raw tls_private_key > id_rsa`

Note: This private key should be made available to the user as a download for the user to complete the lab <br>
<br>

Extract the public IP address and note the address 

`.\terraform output public_ip_address <public IP Address>`<br>
<br>

SSH into the virtual machine

`ssh -i id_rsa azureuser@<public_ip_address>`<br>
<br>

Copy the pcap file to the virtual machine to the /tmp directory

`scp -i id_rsa capture.cap azureuser@74.235.17.169:/tmp`<br>
<br>

The environment is ready for the lab. 
