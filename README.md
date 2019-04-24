# LMS-2-2-Automate-Deployment-Ansible
Automating the deployment of the Simulations CP using Ansible and packer.
## Description
To ease the task of deploying systems, system image is one of the common approaches. A system image is a collection of files containing the system configurations and data. These files are saved in an immutable image that can be used to create and deploy replica system on any other server, faster and with the exact same configurations.

The main tools/packages used in this repo are:

* **Ansible** is an open-source software tool used for provisioning, configuration management, and application deployment. It is agentless which means it can run on a remote machine without need to install ansible on it.

* **Packer** is an open source tool used for creating machine images source configuration. These images can be deployed on any platform making packer a very useful tool for DevOps engineers as well as IT operations engineers.

## Pre-requisite
  1. A laptop or computer with at least 4gb of RAM
  2. **Packer**: Download and install Packer. The instructions to do this can be accessed [here](https://www.packer.io/).              
  3. **Ansible**: Download and install Ansible. The instructions to do this can be accessed [here](https://www.ansible.com/).
  4. **AWS Account**: Register for an account with AWS from [here](https://aws.amazon.com/)

### Steps To Set up.
If all the above pre-requisites are completed, then we can get on to setting up.

### Cloning the Repo

1. We need to clone this repo. Run this command on your terminal:
   ``` 
   git clone https://github.com/bryan-munene/LMS-2-2-Automate-Deployment-Ansible.git 
   ```

2. Move inside the newly created folder by running this command on your terminal:
   ``` 
   cd LMS-2-2-Automate-Deployment-Ansible
   ```
#### Customising the scripts

Inside the `LMS-2-2Automate-Deployment-Ansible` directory, there are two sub-directories `packer` and `scripts`. 

The `packer` directory contains packer template file (`devOpsDemoPacker.json`), as well as a template for declaring your variables (`sampleVars.json`). 

The `scripts` directory contains a bash script (`setup.sh`) and an ansible yml script (`baseConfig.yml`). As well as a template for declaring your enviroment variables for the application (`sampleenv`).


3. Create a variables file as outlined in the `sampleVars.json` file. Name the file `vars.json`.

4. The `devOpsDemoPacker.json` contains the configurations with which Packer will use to build an AMI. You may change these configurations to suit your needs and taste. Configurations such as `ami_name`.

5. Create a varibles file for your enviroment as outlined in the `sampleenv` file. Name the file `.env`.

6. The `setup.sh` file contains bash command to update the image of the installed server os. You can add any commands you may need to run here before installing the other packages, such as upgrading (`sudo apt-get upgrade`) or granting permissions to files and directories you deem necessary.

7. The `baseConfig.yml` file contains the actions to be performed by ansible when provisioning the instance.
 These actions are defined as `tasks`. I have a couple of tasks in this file to accomplish my goal of deploying my project, however, you can add, delete or eidt these steps as you see fit to accomplish your goal.
 You can change the name, limmit the hosts where this script can be executed or any other attribute that you wish to accomplish your goal.

#### Creating an AMI

_Having complete all the steps above, it is time to create an AMI(Amazon Machine Image). This will create an immutable image with the configurations and installations set in the scripts above._

8. To execute the scripts avove and create the AMI, you need first to move into the packer directory by running this command:
```
cd packer
```

9. To begin the execution of the script, run this command:
```
packer build -var-file=vars.json devOpsDemoPacker.json
```

You should see output that looks like this:
```
amazon-ebs output will be in this color.

==> amazon-ebs: Prevalidating AMI Name: PackerAnsible-demo 1556181800
    amazon-ebs: Found Image ID: ami-0e04554247365d806
==> amazon-ebs: Creating temporary keypair: packer_5cc17328-7c54-c158-e390-545ae60a5567
==> amazon-ebs: Creating temporary security group for this instance: packer_5cc1732f-2cef-6e33-bbd3-633e2bbde926
==> amazon-ebs: Authorizing access to port 22 from [0.0.0.0/0] in the temporary security groups...
==> amazon-ebs: Launching a source AWS instance...
==> amazon-ebs: Adding tags to source instance
    amazon-ebs: Adding tag: "Name": "Packer Builder"
    amazon-ebs: Instance ID: i-0f81e03f9f6047185
==> amazon-ebs: Waiting for instance (i-0f81e03f9f6047185) to become ready...
==> amazon-ebs: Using ssh communicator to connect: 18.188.136.231
==> amazon-ebs: Waiting for SSH to become available...
==> amazon-ebs: Connected to SSH!
==> amazon-ebs: Provisioning with shell script: ../scripts/setup.sh
    amazon-ebs: Get:1 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
    amazon-ebs: Hit:2 http://archive.ubuntu.com/ubuntu bionic InRelease
    amazon-ebs: Get:3 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
    amazon-ebs: Get:4 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
    amazon-ebs: Get:5 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [325 kB]
    amazon-ebs: Get:6 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [8570 kB]
    amazon-ebs: Get:7 http://security.ubuntu.com/ubuntu bionic-security/main Translation-en [117 kB]
    amazon-ebs: Get:8 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [242 kB]
    amazon-ebs: Get:9 http://security.ubuntu.com/ubuntu bionic-security/universe Translation-en [138 kB]
    amazon-ebs: Get:10 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64 Packages [4008 B]
    amazon-ebs: Get:11 http://security.ubuntu.com/ubuntu bionic-security/multiverse Translation-en [2060 B]
    amazon-ebs: Get:12 http://archive.ubuntu.com/ubuntu bionic/universe Translation-en [4941 kB]
    amazon-ebs: Get:13 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [151 kB]
    amazon-ebs: Get:14 http://archive.ubuntu.com/ubuntu bionic/multiverse Translation-en [108 kB]
    amazon-ebs: Get:15 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [592 kB]
    amazon-ebs: Get:16 http://archive.ubuntu.com/ubuntu bionic-updates/main Translation-en [218 kB]
    amazon-ebs: Get:17 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [863 kB]
    amazon-ebs: Get:18 http://archive.ubuntu.com/ubuntu bionic-updates/universe Translation-en [262 kB]
    amazon-ebs: Get:19 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages [6636 B]
    amazon-ebs: Get:20 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse Translation-en [3556 B]
    amazon-ebs: Get:21 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages [1024 B]
    amazon-ebs: Get:22 http://archive.ubuntu.com/ubuntu bionic-backports/main Translation-en [448 B]
    amazon-ebs: Get:23 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages [3468 B]
    amazon-ebs: Get:24 http://archive.ubuntu.com/ubuntu bionic-backports/universe Translation-en [1604 B]
    amazon-ebs: Fetched 16.8 MB in 6s (2695 kB/s)
    amazon-ebs: Reading package lists...
==> amazon-ebs: Provisioning with Ansible...
==> amazon-ebs: Executing Ansible: ansible-playbook --extra-vars packer_build_name=amazon-ebs packer_builder_type=amazon-ebs -o IdentitiesOnly=yes -i /var/folders/fl/1j26vkc919z2xt9lb3r39tn40000gn/T/packer-provisioner-ansible435749224 /Users/bryanmunene/Documents/devops-13/LMS-2-2-Automate-Deployment-Ansible/scripts/baseConfig.yml -e ansible_ssh_private_key_file=/var/folders/fl/1j26vkc919z2xt9lb3r39tn40000gn/T/ansible-key440036077
    amazon-ebs:
    amazon-ebs: PLAY [ah birdbox frontend] *****************************************************
    amazon-ebs:
    amazon-ebs: TASK [Gathering Facts] *********************************************************
    amazon-ebs: ok: [default]
    amazon-ebs:
    amazon-ebs: TASK [Install gpg key for node js] *********************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [Add nodejs repo] *********************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [install nginx] ***********************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [install nodejs] **********************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [Install PM2] *************************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [clone the repo] **********************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [Install dependancies] ****************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [Configure pm2] ***********************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [Remove NGINX default files] **********************************************
    amazon-ebs: changed: [default] => (item=/etc/nginx/sites-enabled/default)
    amazon-ebs: changed: [default] => (item=/etc/nginx/sites-available/default)
    amazon-ebs:
    amazon-ebs: TASK [Change ownership of sites_available directory] ***************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [Add custom nginx configuration] ******************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: TASK [create symlinks for nginx configuration] *********************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: RUNNING HANDLER [restart nginx] ************************************************
    amazon-ebs: changed: [default]
    amazon-ebs:
    amazon-ebs: PLAY RECAP *********************************************************************
    amazon-ebs: default                    : ok=14   changed=13   unreachable=0    failed=0
    amazon-ebs:
==> amazon-ebs: Stopping the source instance...
    amazon-ebs: Stopping instance
==> amazon-ebs: Waiting for the instance to stop...
==> amazon-ebs: Creating AMI PackerAnsible-demo 1556181800 from instance i-0f81e03f9f6047185
    amazon-ebs: AMI: ami-040f8a85176177b13
==> amazon-ebs: Waiting for AMI to become ready...
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: Cleaning up any extra volumes...
==> amazon-ebs: No volumes to clean up, skipping
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' finished.

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
us-east-2: ami-040f8a85176177b13
```
And just like that we have created an AMI and provisioned it with ansible.

Go to your AMI dashboard to view your newly created AMI.
This image can be used to create a system with these exact configurations on any platform. To learn how to do this is addressed [here](https://github.com/bryan-munene/LMS-2-2-Automate-Deployment-Ansible#launching-your-ami).


**CONGRATULATIONS!!!**



## Launching Your AMI.

Now that we have created an AMI, makes sense to launch it and see what we have.
The following steps will help you achieve that.

### Pre-requisite

For this section, in addition to the earlier requirements, you'll also need the following before we get started:

1. A domain name: You can register one [here](https://my.freenom.com/) for free.

### Steps to follow

#### Launching an instance.

For this we will be launching an instance using the image we have just created.

1. Go to your AWS EC2 AMIs dashboard. 

2. Select the option `Owned by Me` at the top from the drop down menu. Select the image you wish to launch from the list that appears below that and click on the `Launch Instance` button.

_If the list is too long, you can use the search bar at the top to filter it._

3. Choose an instance type then click `Review and Launch`.

4. On the next page, click on Launch. A dialog box will pop up prompting you to create a security key pair. This will be used to authenticate you whn you try to access the instance. Give the key pair a name and **download it**. Save it in a directory where you won't accidentally delete it. 
Without this file you cannot access your instance.

5. Your instance will be created and launched after this.

6. From the panel at the bottom of your instance page. Click on the security group link attatched to your instance.

7. The next page is the security group that is attatched to your instance. On the panel at the bottom click on the `inbound` tab and then click on the `Edit` button.

8. The result is a pop up that contains the rules to the ports allowed to access th instance. `Add rule` and then add the ports we want to open. For this case we will add pots `80` for the `http` and `443` for the `https`. Then click `save`.

9. Back on our instances page, copy the public DNS on the panel at the bottom and paste it on your browser. You should be able to access your application.

#### Configuring Elastic IP

Now that our app is being served on port `80`. Lets assign it an IP address that doesn't change with the restart of the instance.

10. On the navigation panel on the left, go to the `Elastic IP` tab and click. The resulting page is where we will configure our instances elastic IP.

11. At the top click on `Allocate new Address`. Choose the `Amazon pool` option and click on create. This creates an Elastic IP. Click on the generated IP.

12. On the next page, click on `Actions` at the top of the page. And then on `Associate Address` in the resultant dropdown menu.

13. Select `instance` in the next page then choose the correct instance from the drop down menu the n click on the `Associate` button at the bottom right. That's it. Now we can use the Elastic IP we have created to acceess our app on the browser.

#### Configuring Route 53 and Linking a Domain Name

Now to make our site more conventional, we need to link it to a domain name so we don't have to access it always through the IP.

14. Access your [Route 53](https://console.aws.amazon.com/route53/home?) dash board on AWS

15. On the left navigation panel, click on `hosted zones` then on `Create Hosted zone` button from the resulting page at the top.

16. A dialog box pops on the right, add your domain name and click `Create` button at the bottom.

17. Click on the hosted zone you just created from the list and click on `created record set` at the top. This willbe the record to link your instance to your domain name.

18. A dialog box pops on the right, add your sub-domain if any. This includes `www`, `some-sub-domain`, etc. Anything you wish to appear before your domain name. This can also be empty Add the Elastic IP we configured above on the `value` field. You can add as many record sets as you deem necesary.

19. Now copy the `name servers` from the record set labeled `NS` in the type column and paste them as Name servers in your Domain name configuration page on your domain name provider's site.
Now we can access the app using our domain name.

#### Add SSL certificates

20. First access your instance from the terminal by running the command like this:
```
ssh -i "path/to/key_pair_file.pem" ubuntu@instance_public_dns
```
Substitute it with the appropriate values.

21. Once logged in to the instance, run the following command:
```
sudo certbot --nginx --email <<YOUR EMAIL ADDRESS> --agree-tos --no-eff-email -d <<<YOUR DOMAIN NAME>>
```
Substitute it with the appropriate values.

22. Choose to `Redirect all HTTP traffic to HTTPS` from the reulting prompt. It's ussually the second option.

23. Restart `nginx` by running this command:
```
sudo service nginx restart
```
View your site on the browser and the padlock icon on the adress bar will be present showing that it is secure.


**CONGRATULATIONS YOU HAVE A SECURE WEBSITE**

