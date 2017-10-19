# Install packer

Use [install-packer][] playbook to install latest packer version

```console
thy@tdeltd:~$ packer version
Packer v1.1.0
```

[install-packer]: https://github.com/thydel/misc-play/blob/master/install-packer.yml "github.com"

# Install vagrant

Use [install-vagrant][] playbook to install latest vagrant version

[install-vagrant]: https://github.com/thydel/misc-play/blob/master/install-vagrant.yml "github.com"

# Install virtualbox

Use [install-virtualbox][] playbook to install latest virtualbox version

[install-virtualbox]: https://github.com/thydel/misc-play/blob/master/install-virtualbox.yml "github.com"

# Install vmware-workstation

- Use [install-vmware-workstation playbook][] to install vmware-workstation
- See [install-vmware-workstation doc][]

basically

```
export LD_LIBRARY_PATH=/usr/lib/vmware/lib/libatspi.so.0:/usr/lib/x86_64-linux-gnu/gtk-2.0/modules:$LD_LIBRARY_PATH
vmplayer
```

[install-vmware-workstation playbook]:
	https://github.com/thydel/misc-play/blob/master/install-vmware-workstation.yml "github.com"

[install-vmware-workstation doc]:
	https://github.com/thydel/misc-play/blob/master/install-vmware-workstation.md "github.com"

# Configure AWS

```
sudo aptitude install awscli
aws configure --profile epi
aws configure --profile perso
export AWS_DEFAULT_PROFILE=epi
aws ec2 describe-instances
```

# Create an account on digitalocean

# Getting started

Follow [Getting started][], create and use [example](2017-10-19_TDE_packer-and-vmware-workstation/example.json)

```
packer validate example.json
 export ak=aws_access_key
 export sk=aws_secret_key
packer build -var "aws_access_key=$ak" -var "aws_secret_key=$sk" example.json
packer validate -var 'do_api_token=dummy' example.json
 export dot=do_api_token
packer build -var "aws_access_key=$ak" -var "aws_secret_key=$sk" -var "do_api_token=$dot" example.json
packer build -only=amazon-ebs -var "aws_access_key=$ak" -var "aws_secret_key=$sk" -var "do_api_token=$dot" example.json
```

[Getting started]: https://www.packer.io/intro/getting-started/install.html "packer.io"

# Play with aws

- Consult [AWS CLI Command Reference][]
- See [Advanced AWS CLI JMESPath Query Tricks][]

```
aws ec2 describe-images --owner self
aws ec2 describe-images --region=us-east-1 --owner self
```

[AWS CLI Command Reference]: http://docs.aws.amazon.com/cli/latest/reference/ "docs.aws.amazon.com"

[Advanced AWS CLI JMESPath Query Tricks]:
	http://opensourceconnections.com/blog/2015/07/27/advanced-aws-cli-jmespath-query/ "opensourceconnections.com"
