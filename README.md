# Ansible
Set up server with Ansible include: docker, github, nginx with Let's Encrypt

This project automates server configuration and deployment using Ansible. The Makefile provides several commands to simplify common tasks such as setting up the server, installing Ansible roles, and managing server configurations.

## Prerequisites

- **Ansible**: Ensure you have Ansible installed on your local machine.
- **Make**: This project uses a Makefile to simplify command execution. Ensure `make` is installed on your machine.

## Project Structure

- `ansible/inventories/`: Contains inventory files for different environments.
- `ansible/playbooks/`: Contains Ansible playbooks.
- `ansible/roles/`: Contains Ansible roles.
- `ansible/vars/`: Contains variables files.

## Setup and Configuration

### 1. Configuring the Server

Use the following command to copy the example inventory and secrets files to their appropriate locations. This command will only copy the files if they do not already exist.

```
make config-server ENV=<environment>
Replace <environment> with the desired environment name (e.g., production, staging).
```
2. Installing Ansible Roles
Before setting up the server, you need to install the required Ansible roles defined in requirements.yml:

```
make install_requirements
```
3. Setting Up the Server
After installing the requirements, you can set up the server by running the playbook with the setup tag:

```
make setup-server ENV=<environment> NAME=<repository_name>
```
This command will:

Run the Ansible playbook for the specified environment.
Use the setup tag to only run tasks related to the initial setup.
Save the output to output_setup.log for review.

4. Restarting the Server
To restart services on the server using Ansible, you can use the following command:

```
make restart-server ENV=<environment> NAME=<repository_name>
```

This command will:

Run the Ansible playbook for the specified environment.
Use the restart tag to only run tasks related to restarting services.
Save the output to output_restart.log for review.
Makefile Commands
```
make config-server: Copies example inventory and secrets files if they don't already exist.
make install_requirements: Installs Ansible roles from requirements.yml.
make setup-server: Installs requirements and runs the Ansible playbook with the setup tag.
make restart-server: Runs the Ansible playbook with the restart tag.
```
