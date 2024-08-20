# Ansible
help:
	@echo "Available commands:"
	@echo ""
	@echo "  make config-server          - Copy example inventory and secrets files to their appropriate locations."
	@echo "  make install_requirements   - Install Ansible roles listed in the requirements.yml file at https://galaxy.ansible.com/ui/"
	@echo "  make setup-server           - Install requirements and run the Ansible playbook with the 'setup' tag."
	@echo "  make restart-server         - Run the Ansible playbook with the 'restart' tag."
	@echo ""

config-server:
	@cp -n ansible/inventories/$(ENV)/example.inventory.ini ansible/inventories/$(ENV)/inventory.ini
	@cp -n ansible/vars/example.secrets.yml ansible/vars/secrets

install_requirements:
	@ansible-galaxy install -r ansible/roles/requirements.yml -p ansible/roles

setup-server: config-server install_requirements
	@ansible-playbook -i ansible/inventories/$(ENV)/inventory.ini ansible/playbooks/site.yml \
	--extra-vars "repo_name=$(NAME) branch_name=$(ENV)" \
	--tags setup \
	-vvv | tee ansible/inventories/$(ENV)/output_setup.log

restart-server:
	@ansible-playbook -i ansible/inventories/$(ENV)/inventory.ini ansible/playbooks/site.yml \
	--extra-vars "repo_name=$(NAME) branch_name=$(ENV)" \
	--tags restart \
	-vvv | tee ansible/inventories/$(ENV)/output_restart.log