# Build a VPC with public/private subnets, a bastion instance and NAT/Internet gateways

This is Terraform code to create an AWS VPC properly configured for running some of our other Terraform AWS examples.

You will need the latest version of Terraform to run it: https://terraform.io

### How to use

Copy the dev.tfvars.example to dev.tfvars and fill in all of the values.

```text
key_name="{the name of a key pair that you create - minus .pem}"
access_key="{your aws key}"
secret_key="{your aws secret}"
aws_region="{us-east-1, us-west-1 or us-west-2}"
environment="dev"
zones="3"
```

Issue the terraform plan command

```shell
./plan.sh dev
```

It should show you the resources it would create if you had issued the `apply` command. If everything looks good, issue the `apply` command:

```shell
./apply.sh dev
```

This will create the following resources:

```
- VPC
- 3 private subnets (10.1.10.0, 10.1.20.0, 10.1.30.0)
- 3 public subnets (10.1.1.0, 10.1.2.0, 10.1.3.0)
- 1 IGW
- 3 NAT GWs (1 per AZ)
- 1 bastion instance with associated security group and EIP
```

It will also output the IDs of the VPC, and public/private subnets as well as the public IP of the bastion instance. You can ssh into the bastion instance as the user `ubuntu`. You will need to include the secret key portion of {key_name}. For example, if my {key_name} was stackwire:

```shell
ssh -i stackwire.pem ubuntu@{public IP of bastion instance}
```

The stackwire.pem file would need to exist in the current directory.

### License

You are free to use this code for your own needs without restriction.


### Warranty
This code comes with absolutely no warranty, either expressed or implied, and is completely unsupported. This is meant as a starting point and WILL launch resources in your AWS account. Please read the code and understand what you're launching when you run apply.

We can not be held responsible if this destroys infrastructure or incurs costs. The resources created by this code will cost money, so please be sure to run `./destroy.sh` when you're done.

If you'd like help, we're available to consult. Please reach out to us: https://www.stackwire.io

Copyright © 2017 Stackwire, LLC. All Rights Reserved.
