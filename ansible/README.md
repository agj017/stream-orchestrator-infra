# Stream Orchestrator Ansible

This directory contains Ansible assets for on-premise installation.

## Local Lima Inventory

Use `inventory/local-lima.ini` to test the Node Bootstrap phase against a
single Lima VM.

Install Ansible on the Mac host if it is not already available:

```bash
brew install ansible
```

Create and start the VM:

```bash
limactl create --name so-node-01 deploy/local/lima/so-node-01.yaml
limactl start so-node-01
```

Check SSH access:

```bash
ssh -F /Users/gyujinan/.lima/so-node-01/ssh.config lima-so-node-01
```

Inspect the inventory:

```bash
cd deploy/ansible
ansible-inventory --list
```

Ping the node:

```bash
ansible k8s_cluster -m ping
```

Run a sudo smoke test:

```bash
ansible k8s_cluster -m command -a 'whoami' --become
```

Expected result:

```text
root
```

The inventory models `so-node-01` as both a control-plane and worker node so
the same group structure can later expand to multiple physical machines or VMs.

Run a syntax check:

```bash
ansible-playbook playbooks/node-bootstrap.yml --syntax-check
```

Run the Node Bootstrap playbook:

```bash
ansible-playbook playbooks/node-bootstrap.yml
```

Run the Node Bootstrap playbook through the regular installer script:

```bash
../../scripts/ansible/node-bootstrap.sh
```

This script assumes the Lima VM already exists and is running. It runs
inventory, syntax, SSH, and sudo preflight checks before executing the playbook.

Run post-bootstrap validation checks:

```bash
../../scripts/ansible/node-bootstrap.sh --validate
```

Check idempotency explicitly:

```bash
../../scripts/ansible/node-bootstrap.sh --check-idempotency
```

Run both optional checks:

```bash
../../scripts/ansible/node-bootstrap.sh --validate --check-idempotency
```

The playbook prepares each node for `kubeadm` by configuring hostname,
kernel modules, sysctl settings, swap, chrony, platform directories,
containerd, and Kubernetes node packages.

Useful post-run checks:

```bash
ansible k8s_cluster -m command -a 'hostname'
ansible k8s_cluster -m command -a 'swapon --show'
ansible k8s_cluster -m command -a 'containerd --version'
ansible k8s_cluster -m command -a 'kubeadm version -o short'
ansible k8s_cluster -m command -a 'kubelet --version'
ansible k8s_cluster -m command -a 'kubectl version --client=true'
```
