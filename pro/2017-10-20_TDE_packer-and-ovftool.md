# Found a geerlingguy repos to fork

- Fork [Packer Example - Debian 8 minimal Vagrant Box][]
- Upgrade to latest debian9 and keep vmdk (original targets vagrant box) [Debian-9.2.1][]
  
  Warning: `vmware-workstation` only knows `debian8-64` guest os type
  and fail (without explicit error message when invoked via `packer`)
  if you use `debian9-64`

[Packer Example - Debian 8 minimal Vagrant Box]: https://github.com/geerlingguy/packer-debian-9 "github.com"
[Debian-9.2.1]: https://github.com/thydel/packer-debian-9 "github.com"

On my workstation in [thydel/packer-debian-9][]

[thydel/packer-debian-9]: https://github.com/thydel/packer-debian-9 "github.com"

```
packer build --only=virtualbox-iso debian921.json
packer build --only=vmware-iso debian921.json
```

# Uses ovftool

## Who provides us ovftool 4.1.0

We didn't installed ovftool (which presumably came bundled with vmware-workstation)

```console
thy@tdeltd:~$ ovftool --version
VMware ovftool 4.1.0 (build-3634792)
```

See [ovftool-410-userguide][]

[ovftool-410-userguide]:
	https://www.vmware.com/support/developer/ovf/ovf410/ovftool-410_userguide.pdf "www.vmware.com"
	
## Do we needs ovftool 4.2.0

[vmware ovf page][] offers ovftool 4.2.0 and [ovftool-420-userguide][]

[vmware ovf page]: https://www.vmware.com/support/developer/ovf/ "www.vmware.com"

[ovftool-420-userguide]:
	https://www.vmware.com/support/developer/ovf/ovf420/ovftool-420-userguide.pdf "www.vmware.com"
	
You need a vmware account to download `VMware-ovftool-4.2.0-5965791-lin.x86_64.bundle`

## Make an ova file

On my workstation in [thydel/packer-debian-9][]

- The resulting VM is in packer specified `"output_directory": "packer-debian-921-amd64-vmware"`
- First convert to `ovf`, then to `ova`

```console
thy@tde-ws:~/usr/thydel-forked.d/packer-debian-9/packer-debian-921-amd64-vmware$ ovftool packer-debian-921-amd64.vmx packer-debian-921-amd64.ovf
Opening VMX source: packer-debian-921-amd64.vmx
Opening OVF target: packer-debian-921-amd64.ovf
Writing OVF package: packer-debian-921-amd64.ovf
Transfer Completed
Completed successfully
thy@tde-ws:~/usr/thydel-forked.d/packer-debian-9/packer-debian-921-amd64-vmware$ ovftool packer-debian-921-amd64.ovf packer-debian-921-amd64.ova
Opening OVF source: packer-debian-921-amd64.ovf
The manifest validates
Opening OVA target: packer-debian-921-amd64.ova
Writing OVA package: packer-debian-921-amd64.ova
Transfer Completed
Completed successfully
thy@tde-ws:~/usr/thydel-forked.d/packer-debian-9/packer-debian-921-amd64-vmware$ 
```

## Transfert it to a cluster

On my workstation in [thydel/packer-debian-9][]

```
ovftool --acceptAllEulas -ds=$datastore -dm=thin --net:nat=$network \
        ./packer-debian-921-amd64.ova vi://$user:$pass@evcenter.tld/$datacenter/host/$cluster
```

You may use to find connection problem

```
ovftool --X:logToConsole=True --X:logLevel="verbose" --acceptAllEulas \
        -ds=$datastore -dm=thin --net:nat=$network \
        ./packer-debian-921-amd64.ova vi://$user:$pass@evcenter.tld/$datacenter/host/$cluster
```

