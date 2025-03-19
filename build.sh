GOLANG_VERSION="1.24.1"
GOARCH="amd64"

# Dependencies
apt update && apt install -y cephadm
cephadm add-repo --release squid
apt update && apt install -y librados-dev librbd-dev libcephfs-dev 
curl -LO https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

# Clone the repo
git clone https://github.com/ceph/ceph-csi.git
cd ceph-csi

# Build image and extract rootfs container
make image-cephcsi
cd ..
chmod +x plugin/rootfs/entrypoint.sh
container_id=$(docker create quay.io/cephcsi/cephcsi:canary)

# Copy the full filesystem from the container to your plugin rootfs directory
docker cp "${container_id}:/." plugin/rootfs/
docker rm "${container_id}" 

# Build the Plugin
docker --debug plugin create cephcsi-docker:latest ./plugin
docker --debug plugin ls