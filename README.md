# RHEL Automation Lab

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
