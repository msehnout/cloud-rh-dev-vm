# -*- mode: ruby -*-
# vi: set ft=ruby :

# helper module to guess which platform is the host
module OS
  def OS.linux?
    (/linux/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/31-cloud-base"
  config.vm.box_version = "31.20191023.0"
  config.vm.network "forwarded_port", guest: 9090, host: 9090, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8002, host: 8002, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 1337, host: 1337, host_ip: "127.0.0.1"

  # Provider-specific configuration
  if OS.mac?
    # This is needed for the NFS to work
    config.vm.network "private_network", type: "dhcp"
    puts "Running on macOS"
    config.vm.provider "virtualbox" do |vb|
      # Customize the amount of memory on the VM:
      vb.memory = 4096
      vb.cpus = 2
    end
  elsif OS.linux?
    puts "Running on Linux"
    config.vm.provider :libvirt do |libvirt|
      libvirt.memory = 4096
      libvirt.cpus = 2
    end
  else
    puts "Unknown platform"
  end

  # Use :ansible or :ansible_local to
  # select the provisioner of your choice
  config.vm.provision :ansible_local do |a|
    a.playbook = "playbook.yml"
    a.become = true
  end

  synced_directories = [
    ["insights-chrome/", "/home/vagrant/insights-chrome"],
    ["insights-frontend-starter-app/", "/home/vagrant/insights-frontend-starter-app"],
    ["insights-proxy/", "/home/vagrant/insights-proxy"],
    ["spandx/", "/home/vagrant/spandx"],
    ["starter-app-test/", "/home/vagrant/starter-app-test"],
  ]

  # This does not work by default, see README for workaround
  if OS.mac?
    synced_directories.each do |dir|
      config.vm.synced_folder dir[0], dir[1], type: "nfs"
    end 
  else
    synced_directories.each do |dir|
      config.vm.synced_folder dir[0], dir[1], type: "nfs", nfs_udp: false
    end 
  end
end
