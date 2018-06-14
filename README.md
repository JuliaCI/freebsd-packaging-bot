# Julia FreeBSD buildbot

To bring this up using VirtualBox, just do `vagrant up`

To bring this up using `libvirt` (e.g. KVM), you must first run:

```bash
$ vagrant plugin install vagrant-libvirt
$ vagrant plugin install vagrant-mutate
$ vagrant mutate freebsd/FreeBSD-11.1-STABLE libvirt
```

Followed by:
```bash
$ vagrant up --provider=libvirt
```
