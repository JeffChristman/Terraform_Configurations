## EVALUATOR PLEASE READ 
I do not know the experience level of the person evalauting this lab and 
I am making the following assumptions 

1. The person evaluating the lab has some familiarity with terrafrom. 
2. The steps below will be automated and inlcuded as part of the terraform script 
3. Plurasight has a preffered authentication method that allows the user to login to the virtual machine
4. 


### Prerequisites for the environment setup 

Run the terraform script to create the test vm

Extract the private key and save localy by executing the following command 

`.\terraform output -raw tls_private_key > id_rsa`

The evaluator understands how to run terraform and create the test environment.
2.  

The terraform script will create a linux server on the Azure cloud service. 

Setting up the environment to complete the lab. 

Initialize the terrform 
