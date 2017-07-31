# boxes

* [Vagrant boxes](https://www.vagrantup.com/docs/boxes.html)
* [bento](https://github.com/chef/bento)

## vm_nanopore

This VM holds various useful programs for the analysis of log reads generated by the Oxford Nanopore technology.

Prerequisites:

* VirtualBox provides the virtual machine (VM)
* Vagrant manages the VM
* Ansible (`brew install ansible`) is used by Vagrant for provisioning (you could use other provisioning software)

To fire up a VM, copy `Vagrantfile` and `playbook.yml` to an empty directory, e.g. `vm-nanopore`. 

```
cd /path/to/vm-nanopore
vagrant up --provider virtualbox
# problems?
# vagrant up --debug &> vagrant.log
# made changes to the playbook?
# vagrant provision

vargrant ssh  # to exit, type "exit"
vagrant suspend
vagrant destroy  # going, going, gone
```

Vagrant calls the virtual machine "guest" and the local machine "host". The shared folder between host and guest (e.g. to pass data) is (by default) the directory where the Vagrantfile resides. On the guest machine, it is connected to the `/vagrant` directory. 

## modify

If you provision new things, you can do so without starting the VM anew, as there is a ["start_at_task"](https://www.vagrantup.com/docs/provisioning/ansible_common.html) argument (which corresponds to Ansible's ["--start-at-task"](http://docs.ansible.com/ansible/playbooks_startnstep.html#start-at-task)). [More info in this blog post](http://rosstuck.com/slightly-faster-ansible-testing-with-vagrant/).

```
# from within the virtual machine, i.e. after vagrant ssh
ansible-playbook playbook.yml --start-at-task="install packages"
```

More on how to [manually](http://docs.ansible.com/ansible/guide_vagrant.html) run ansible in Vagrant.

## trouble shooting

### box not found

When using Vagrant for the first time, you might see this error:

```
vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'hashicorp/precise32' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
The box 'hashicorp/precise32' could not be found or
could not be accessed in the remote catalog. If this is a private
box on HashiCorp's Atlas, please verify you're logged in via
`vagrant login`. Also, please double-check the name. The expanded
URL and error message are shown below:

URL: ["https://atlas.hashicorp.com/hashicorp/precise32"]
Error:

```

[Stackoverflow issue 23874260](http://stackoverflow.com/questions/23874260/error-when-trying-vagrant-up), suggests

```
sudo rm -rf /opt/vagrant/embedded/bin/curl
```

(worked for me).

### connection timeout during boot

Sometimes, the Vagrant will timeout during the boot of the VM:

```
vm_nanopore$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'bento/ubuntu-16.04' is up to date...
==> default: Resuming suspended VM...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
The guest machine entered an invalid state while waiting for it
to boot. Valid states are 'restoring, running'. The machine is in the
'paused' state. Please verify everything is configured
properly and try again.

If the provider you're using has a GUI that comes with it,
it is often helpful to open that and watch the machine, since the
GUI often has more helpful error messages than Vagrant can retrieve.
For example, if you're using VirtualBox, run `vagrant up` while the
VirtualBox GUI is open.

The primary issue for this error is that the provider you're using
is not properly configured. This is very rarely a Vagrant issue.
```

This seems to happen [a lot](http://stackoverflow.com/questions/22575261/vagrant-stuck-connection-timeout-retrying). In order to see what the VM is doing, enable the VM GUI during startup by uncommenting this part of the Vagrantfile.

```
config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
end
```

There are other suggestions to just send "Enter" to the VM, in case it waits for a decision:

```
# list of current VMs
vboxmanage list runningvms
# send "Enter" to the corresponding VM
vboxmanage controlvm project_name_somenumber keyboardputscancode 1c
```
