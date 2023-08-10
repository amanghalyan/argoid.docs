ssh-users-creation 
=========
A role which creates ssh-user IDs in all VMs
Also provides sudo privilege for SSH Users

Requirements
------------
SSH users local public key should be placed in
`roles/ssh-users-creation/files/ssh_user_name.local.key.pub`
Gateway Public and private key also need to be placed in same folder     
`roles/ssh-users-creation/files/ssh_user_name.gw.key.pub` `roles/ssh-users-creation/files/ssh_user_name.id_rsa` respectively

Role Variables
--------------
All the varibales will be loaded from inventory file
Examples: 

```
[argoid:vars]
ssh_users=["chackra", "jeyaraj"]         ## SSH usernames to be created in all servers except in SSH-Gateway
delete_ssh_users=["chackra"]             ## SSH usernames to be deleted in all servers except in SSH-Gateway, make it empty list if none of the users to be deleted 
create_ssh_private_keys=False            ## Whether to create private keys in all servers except in SSH-Gateway, set it to `False` always
enable_superuser_privileges=True         ## To provide superuser privileges for ssh-users, set to `False` if you not intended to provide sudo privilege for ssh-users
ssh_superusers=["chackra", "jeyaraj"]    ## List of ssh-users who needs sudo privilege 

[ssh_gateway]
10.0.0.23                        

[ssh_gateway:vars]
create_ssh_private_keys=True            ## Whether to create private keys for ssh-users in SSH-Gateway, set it to `True` always
enable_superuser_privileges=True        ## To provide superuser privileges for ssh-users, set to `False` if you not intended to provide sudo privilege for ssh-users
ssh_superusers=["chackra", "jeyaraj"]   ## List of ssh-users who needs sudo privilege in SSH-Gateway 
```

Dependencies
------------
all the public and private keys are encrypted with ansible-vault , so connect with Devops team to get the vault password

Example Playbook
----------------
`$cd argoid-infra/argoid-ansible`
`$chmod 400  roles/ansible-ssh-user/files/id_rsa`
`$ansible-vault decrypt roles/ansible-ssh-user/files/id_rsa`

To Create user IDs in Gateway VM 

`$ansible-playbook  -i inventory/template.ini sites/argoid-team-users.yml --tags=create_ssh_users_in_gw  --private-key=roles/ansible-ssh-user/files/id_rsa  --ask-vault-pass`

To Create user IDs in all VMs excluding SSH-Gateway VM 

`$ansible-playbook  -i inventory/template.ini sites/argoid-team-users.yml --tags=create_ssh_users  --private-key=roles/ansible-ssh-user/files/id_rsa  --ask-vault-pass`

To Delete user IDs in all VMs excluding SSH-Gateway VM 

`ansible-playbook  -i inventory/template.ini sites/argoid-team-users.yml --tags=delete_ssh_users  --private-key=roles/ansible-ssh-user/files/id_rsa  --ask-vault-pass`

