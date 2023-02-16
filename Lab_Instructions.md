# Intrusion Analysis: 
## Analysing a network trace to determine how the Dark Kittens gained access to the server.<br>
#### In this lab you will analyze the network packet trace and discover how the hacker inflitrated the network.

>Please see environment setup (Audition_Read_Me.md) before starting this lab

You are the senior intrusion analyst at Globalmantics and after the most recent security breach, the CSO has asked for a post mortem of the event to determine the need to know how the Dark Kittens infiltraded network and stole the codebase of the CRM program. 

The network security team has created an exact copy of the breached server and the network packet capture that was taken during the security breach. It will be your job to login to the server, analyse the network trace and determine the method that was used to gain access. 

## Prerequisites:
1. Basic understanding of Linux and how to esxecute BASH Shell commands
2. Familier with SSH 
3. The private key file - Privided as a download
4. Working knowledge of TCPDUMP 


### Intrusion Analysis Lab

The first step is to get the public IP address of the virtual machine so that we can login using SSH

1. Login to the lab and open the main Azure Console. 
2. On the left menu under settings, click on Resource Groups 

![](https://github.com/JeffChristman/PL_labs/blob/main/png/mypublicIP.png)

3. Click on MyPublicIP and on the top right, you will see the assigned public IP address - write this down. 

![](https://github.com/JeffChristman/PL_labs/blob/main/png/PublicIP.png)


5. Login to the virtual Machine with SSH with the provided private key using the following command.

`ssh -i id_rsa azureuser@<public_ip_address>`

6. once connected, type YES to accept the certificate
7. Then Navigate to the TMP directory by entering the following command: 

`cd /tmp`


### Analyzing the packet trace 
Now that you have logged into the compromized server, lets begin the intrusion analyses. The capture.cap file is the file we are interested in. 

Start by looking at the whole trace and see if there is some interesting packets. <br>
Enter the following command 

`tcpdump -r capture.cap`

![](https://github.com/JeffChristman/PL_labs/blob/main/png/fullpacket.png)


The output is a bit overwhelming, lets filter the output to only IP traffic and make it easier to find interesting traffic. 

Enter the following command: 

`tcpdump -r capture.cap ip`

![](https://github.com/JeffChristman/PL_labs/blob/main/png/tcpdumpip.png)


Now that we have just the IP traffic, it looks like there is an issue with IP address 10.1.1.1. This is your first clue on how Dark Kitten may have compromised the server. <br>

Now that we have an indication of something wrong, let's take a closer look at 10.1.1.1 traffic. In order to get all the information about the individual packets, we will add some flags to the command. <br>

Let's isolate the source address 10.1.1.1 and include the hexidecimal output to take a closer look. The following command will include -vv for "very Verbose", or show all data about the packet,  and -xx to inlcude the hexidecimal output.

Enter the following command 

`tcpdump -r capture.cap ip src host 10.1.1.1 -vv -xx`

In analyzing the output, it appears that the traffic from 10.1.1.1 is fragmented and overlapping offsets. 

![](https://github.com/JeffChristman/PL_labs/blob/main/png/offset.png)


Lets verify the finding and confirm that the packets from 10.1.1.1 are fragmented. For the next coomand, the following filter will parse the capture file looking for fragmented packets. 

`'((ip[6:2] > 0) and (not ip[6] = 64))'`

The above filter will parse the individual fields of the packet and look for fragemented packets within the whole trace.

Enter the following 

`tcpdump -r capture.cap '((ip[6:2] > 0) and (not ip[6] = 64))' -vv -x`

![](https://github.com/JeffChristman/PL_labs/blob/main/png/filterForFrag.png)

Based on the above output, it appears the only fragemented packets are from 10.1.1.1. With the other information gathered from your analysis, this appears to be a teardrop Denial of service attack coming from IP address 10.1.1.1


### Analysis Report 
With the analysis complete, you meet with Globalmantics Security team to go over the results.

From the analysis you completed, it was determined that Dark Kittens used a teardrop attack which exploits a bug in the code in older systems that handles large amounts of traffic. Teardrop is a type of DDOS  (Distributed Denial of Service) attack. The attack crashed the server and left it vulnerable for further exploitation. Further investigation determined that this server was used as a entry point to the Globalmantics.  

Mitigation for the attacks is to update the server hardware and patch with the latest version of the software or decommision the server and remove from the network. 
 



