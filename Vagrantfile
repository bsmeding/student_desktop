# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 2.2.15"

Vagrant.configure("2") do |config|
    config.vagrant.host = :detect
    config.vm.box = "gusztavvargadr/ubuntu-desktop-2004-lts-xfce" # "ubuntu/focal64"
#   config.vm.box_version = "2020.10.0100"
    config.vm.boot_timeout = 300
    config.vm.box_check_update = true
    config.vm.graceful_halt_timeout = 60
    config.vm.post_up_message = "Login credentials are vagrant/vagrant"
    config.vm.synced_folder ".", "/vagrant", disabled: false
	# config.vm.provision "shell", inline: <<-SHELL
	# 	sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
	# 	sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
	# 	service ssh restart
	# SHELL


    # uncomment to put the box on the network so it can be accessed by others
    # config.vm.network "public_network"

    config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
        v.customize ["modifyvm", :id, "--hwvirtex", "on"]
        v.customize ["modifyvm", :id, "--nestedpaging", "on"]
        v.customize ["modifyvm", :id, "--vtxvpid", "on"]
        v.customize ["modifyvm", :id, "--largepages", "on"]
        v.customize ["modifyvm", :id, "--acpi", "on"]
        v.customize ["modifyvm", :id, "--groups", "/BS Students"]

        # change the network card hardware for better performance
        v.customize ["modifyvm", :id, "--nictype1", "virtio"]
        v.customize ["modifyvm", :id, "--nictype2", "virtio"]

        # suggested fix for slow network performance
        # see https://github.com/mitchellh/vagrant/issues/1807
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

        v.customize ["modifyvm", :id, "--vram", "48"]
    end

    # Install Ansible
    config.vm.provision :shell,
        path: "scripts/install-ansible.sh"

    project = ENV['USER_PLAYS']
    config.vm.provision "shell" do |custom|
        custom.path = "scripts/install-custom.sh"
        custom.args = project
        custom.privileged = false
        custom.name = "Personal Ansible Provisions"
    end

    # project = ENV['STUDENT_PLAYS']
    project = 'bsmeding/devnetops_student_desktop_provisioning'
    config.vm.provision "shell" do |student|
        student.path = "scripts/install-student.sh"
        student.args = project
        student.privileged = false
        student.name = "Student Ansible Provisions"
    end

    config.vm.define "bs_student", primary: true do |xubuntu|
        xubuntu.vm.provider "virtualbox" do |v|
            v.gui = true
            v.name = "bs_automation_student.xubuntu"
            v.memory = 6144
            v.cpus = 2
        end
    end

end
