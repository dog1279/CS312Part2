## Requirements

- **Terraform** (v1.12.2)  
  Used for provisioning AWS resources.

- **Ansible** (v2.12.3)  
  Used to configure the Minecraft server after provisioning.

- **AWS CLI** (v2.x)  
  For managing AWS credentials and interacting with AWS.

- **Linux/macOS** or **Windows WSL2** (recommended for Windows users)  
  This project uses bash scripts and will run best on Linux or WSL.

---

## Pipeline Overview

### Terraform Initialization and Apply

- Initializes Terraform modules and providers.  
- Creates AWS resources: VPC, subnet, security group, key pair, EC2 instance.

### Output Extraction

- Retrieves the public IP address of the Minecraft server.

### Dynamic Inventory Update

- Updates Ansible inventory with the server’s IP address.

### Server Configuration via Ansible

- Uses the inventory to run the Ansible playbook which installs and configures Minecraft server software on the EC2 instance.

---

## Running the Pipeline

### Prerequisites

Configure AWS CLI with your credentials:

```bash
aws configure
```

Make sure you have your SSH private key accessible, matching the public key referenced in Terraform.

---

### Steps

**Clone the repository**

```bash
git clone <your-repo-url>
cd <your-repo-folder>
```

**Run the deployment script**

```bash
./deploy.sh
```

This script will:

- Run `terraform init` and `terraform apply` automatically.  
- Extract the Minecraft server public IP.  
- Update the Ansible inventory dynamically.  
- Run the Ansible playbook to configure the server.

---

### Verify Minecraft Server

Once completed, connect your Minecraft client to the server using the provided IP and port `25565`.

---

## Notes for Windows Users

- Use **Windows Subsystem for Linux (WSL2)** for the best compatibility with Terraform, Ansible, and bash scripts. Just trust me on this.
- Alternatively, run these tools on a **Linux VM** or remote machine. Overkill but possible.  
- Make sure your **SSH keys** have the correct permissions:

```bash
chmod 400 your/private/key
```

and are accessible from your WSL or VM environment. Ask me how I know. (I had to restart multiple times due to silly key stuff, keep it somewhere safe.)

## Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/index.html)
- Stack Overflow (The Goat)