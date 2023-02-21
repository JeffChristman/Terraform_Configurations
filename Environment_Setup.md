## Installing the environment 
The following steps will set up the environment for the lab.

### Audition Lab Development Environment 

The terraform environment was developed on a Windows 11 OS using WSLv2 and Terraform v1.3.9 <br>
>The AWS credentials are set in the teraafrom.tfvars file.

### Executing the script
1. Run the terraform script to create the ubuntu server vm in the aws cloud. <br>
`.\terraform plan -out "linux-vm-main.tfplan"` <br>
`.\terraform apply "linux-vm-main.tfplan"`

>Note: The first run will fail due to the public_ip address field changes during the runtime when associating the EIP ( Elastic IP) . Additonally, inheritence on the private key will need to be disabled inorder to connect to the AWS virtual nmachine. 

2. After the first run, the terrform-cloud-key-pair will be copied down to the local directory. Change the permissons by going to the properties and remove all inheritence and add the local user as the sole owner

![image](https://github.com/JeffChristman/PL_labs/blob/main/png/finalpermission.png) <br>


3. Run the terraform again executing both the "plan" and the "apply"<br>
`.\terraform plan -out "linux-vm-main.tfplan"` <br>
`.\terraform apply "linux-vm-main.tfplan"`

4. The second run will have the correct permission on the private key and upload the test file "Capture.cap" <br>
![image](https://github.com/JeffChristman/PL_labs/blob/main/png/2ndrunn.png)


### Validate the lab setup <br>
To validate the lab environment, login to the server using ssh 
> `sh -i "terraform-cloud-key-pair.pem" ubuntu@ec2-3-135-34-127.us-east-2.compute.amazonaws.com`

Note: be sure to use the dns name as shown ion the last line of the output on the second run. in this example - <br> 
`ec2-3-135-34-127.us-east-2.compute.amazonaws.com`

One logged in, execute `ls -al` and verify that capture.cap is listed <br>
![image](https://github.com/JeffChristman/PL_labs/blob/main/png/verifycapture.png)


The lab environment is ready for the lab. PLease see Lab_Instructions.md to ccomplete the lab.
