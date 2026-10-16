# RHEL Automation Lab

<img width="580" height="565" alt="kickstart-ansible-diagram" src="https://github.com/user-attachments/assets/3606edc5-5e6d-41ee-96d2-f3cb3353a6fb" />


Small Ansible project I use to set up two RHEL hosts:

- **infra01** → NFS server (`/srv/nfs`)
- **app01** → NFS client (`/mnt/nfs`)

Everything is managed from `control01`.

### What’s included

- **baseline** role – puts the lab interface in the internal firewall zone, keeps SELinux enforcing, makes sure `labadmin` has UID 1000 + sudo, and writes the lab hosts into `/etc/hosts`
- **nfs_server** role – exports `/srv/nfs` to app01 only
- **nfs_client** role – mounts it as NFSv4 at `/mnt/nfs`
- **Kickstart** – unattended install of a blank VM (OEMDRV ISO) so Ansible can take over right after first boot
- **verify.yml** – checks SELinux, firewall zone, services, export options, the mount, and does a real write from the client that must show up on the server

### Layout
```
ansible.cfg
requirements.yml        # pinned collections
inventory/              # hosts, group_vars, host_vars
playbooks/              # site.yml, verify.yml, all.yml
roles/                  # baseline, nfs_server, nfs_client
kickstart/              # ks.cfg source and ISO build script
```

### Quick start

From `control01`:

```bash
# install collections if needed
ansible-galaxy collection install -r requirements.yml

# configure both hosts
ansible-playbook playbooks/site.yml

# run the full verification
ansible-playbook playbooks/verify.yml
```

Or just run everything at once:
```bash
ansible-playbook playbooks/all.yml
```

### Screenshots

Kickstart booting process

<img width="602" height="404" alt="boot-kickstart" src="https://github.com/user-attachments/assets/1f2f1c4b-25e9-4d96-818c-50ab58345f84" />



Running ansible-playbook to check inventory hosts

<img width="795" height="608" alt="Screenshot 2026-10-12 112327" src="https://github.com/user-attachments/assets/42293701-38f3-4b6b-aa23-7d2082d96384" />

<img width="817" height="428" alt="Screenshot 2026-10-08 122302" src="https://github.com/user-attachments/assets/327c7249-3445-4f63-bde8-61a807a37127" />

