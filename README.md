# ceph-csi-swarm



Repackages ceph-csi driver as swarm-compatible managed plugin.

## Method
  - `plugin/rootfs/entrypoint.sh` Wrapper that parses docker plugin settings into cephcsi arguments

## Build
  - Execute build.sh