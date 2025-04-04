# ceph-csi-swarm
https://github.com/ceph/ceph-csi/issues/3769


Repackages ceph-csi driver as swarm-compatible managed plugin.

## Method
  - `plugin/rootfs/entrypoint.sh` Wrapper that parses docker plugin settings into cephcsi arguments

## Build
  - Execute build.sh
