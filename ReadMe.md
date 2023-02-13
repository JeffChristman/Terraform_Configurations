## Notes about the lab setup for the audition

### Prerequisites for the environment setup 

Run the terraform script to create the test vm

extract the private key and save localy 

`.\terraform output -raw tls_private_key > id_rsa`

The evaluator understands how to run terraform and create the test environment.
2.  

The terraform script will create a linux server on the Azure cloud service. 

Setting up the environment to complete the lab. 

Initialize the terrform 
