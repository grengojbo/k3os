

+ cd ..
++ docker run --net=host --privileged --rm -itd rancher/k3os-iso:dev
+ ID=4f4b02cc4df5bb934020eae9f528088ff9695c67fc474c832b8834958f5d62f4
+ docker attach 4f4b02cc4df5bb934020eae9f528088ff9695c67fc474c832b8834958f5d62f4
SeaBIOS (version rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org)


F0217 19:46:18.528665    6070 server.go:186] unknown 'kubernetes.io' or 'k8s.io' labels specified with --node-labels: [node-role.kubernetes.io/worker]
--node-labels in the 'kubernetes.io' namespace must begin with an allowed prefix (kubelet.kubernetes.io, node.kubernetes.io) or be in the specifically allowed set (beta.kubernetes.io/arch, beta.kubernetes.io/instance-type, beta.kubernetes.io/os, failure-domain.beta.kubernetes.io/region, failure-domain.beta.kubernetes.io/zone, kubernetes.io/arch, kubernetes.io/hostname, kubernetes.io/os, node.kubernetes.io/instance-type, topology.kubernetes.io/region, topology.kubernetes.io/zone)


# VMware

vSphere guestinfo: https://github.com/vmware/cloud-init-vmware-guestinfo
issue: https://github.com/rancher/k3os/issues/413
PR: https://github.com/linuxkit/linuxkit/pull/3526