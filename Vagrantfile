# vi:ft=ruby

Vagrant.configure(2) do |config|
  config.vm.box = "freebsd/FreeBSD-11.1-STABLE"
  config.vm.base_mac = "080027D14C66"
  config.ssh.shell = "/bin/sh"

  # Vagrant can't mount shared folders on BSD guests so just disable it
  # and avoid the warning
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define :freebsd_builder do |builder|
    builder.vm.provision :shell,
      path: "setup.sh",
      args: ["freebsd11_1-x64"],
      keep_color: false,
      privileged: true

    # Always run this line, even if it isn't our first time provisioning
    builder.vm.provision "shell", run: "always", inline: "buildbot-worker start worker"

    builder.vm.provider "virtualbox" do |v|
      v.memory = 12000 # 12.0 GB, 2 GB per core
      v.cpus = 6
    end

    builder.vm.provider "libvirt" do |v|
      v.memory = 12000
      v.cpus = 6
    end
  end

  config.vm.define :freebsd_tester do |tester|
    tester.vm.provision :shell,
      path: "setup.sh",
      args: ["tabularasa_freebsd11_1-x64"],
      keep_color: false,
      privileged: true

    # Always run this line, even if it isn't our first time provisioning
    tester.vm.provision "shell", run: "always", inline: "buildbot-worker start worker"
   
    tester.vm.provider "virtualbox" do |v|
      v.memory = 8000 # 8.0 GB
      v.cpus = 6
    end
    
    tester.vm.provider "libvirt" do |v|
      v.memory = 8000
      v.cpus = 6
    end
  end
end
