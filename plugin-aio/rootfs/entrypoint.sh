#!/bin/sh

# Exit on any error
set -e

# Debug: enable with DEBUG=true
if [ "$DEBUG_ENTRYPOINT" = "true" ]; then
    set -x
fi

# Default values if not overridden by environment variables
CONTROLLER_SERVER="${CONTROLLER_SERVER:-true}"
NODE_SERVER="${NODE_SERVER:-false}"
STAGING_PATH="${STAGING_PATH:-}"
NODE_ID="${NODE_ID:-default-node-id}"
CSI_ADDONS_ENDPOINT="${CSI_ADDONS_ENDPOINT:-unix://tmp/csi-addons.sock}"
DRIVER_NAME="${DRIVER_NAME:-rbd.csi.ceph.com}"
TYPE="${TYPE:-rbd}"
INSTANCE_ID="${INSTANCE_ID:-default}"
PID_LIMIT="${PID_LIMIT:-0}"
METRICS_PORT="${METRICS_PORT:-8080}"
METRICS_PATH="${METRICS_PATH:-/metrics}"
POLL_TIME="${POLL_TIME:-60s}"
TIMEOUT="${TIMEOUT:-3s}"
CLUSTER_NAME="${CLUSTER_NAME:-ceph}"
RBD_HARD_MAX_CLONE_DEPTH="${RBD_HARD_MAX_CLONE_DEPTH:-8}"
RBD_SOFT_MAX_CLONE_DEPTH="${RBD_SOFT_MAX_CLONE_DEPTH:-4}"
SKIP_FORCE_FLATTEN="${SKIP_FORCE_FLATTEN:-false}"
MAX_SNAPSHOTS_ON_IMAGE="${MAX_SNAPSHOTS_ON_IMAGE:-450}"
MIN_SNAPSHOTS_ON_IMAGE="${MIN_SNAPSHOTS_ON_IMAGE:-1}"
SET_METADATA="${SET_METADATA:-false}"
ENABLE_READ_AFFINITY="${ENABLE_READ_AFFINITY:-false}"
LOG_SLOW_OP_INTERVAL="${LOG_SLOW_OP_INTERVAL:-30s}"

# Set the CSI socket endpoint
CSI_ENDPOINT="${CSI_ENDPOINT:-/run/docker/plugins/csi.sock}"

# Path to the Ceph CSI RBD plugin binary
CSI_RBD_PLUGIN_BINARY="/usr/local/bin/cephcsi"

echo "Starting cephcsi with endpoint: unix:/${CSI_ENDPOINT}"

# Construct the command first
#CMD="\"$CSI_RBD_PLUGIN_BINARY\" \
#    --endpoint=\"unix://${CSI_ENDPOINT}\" \
#    --nodeid=\"${NODE_ID}\" \
#    --csi-addons-endpoint=\"${CSI_ADDONS_ENDPOINT}\" \
#    --drivername=\"${DRIVER_NAME}\" \
#    --type=\"${TYPE}\" \
#    --instanceid=\"${INSTANCE_ID}\" \
#    --pidlimit=\"${PID_LIMIT}\" \
#    --metricsport=\"${METRICS_PORT}\" \
#    --metricspath=\"${METRICS_PATH}\" \
#    --polltime=\"${POLL_TIME}\" \
#    --timeout=\"${TIMEOUT}\" \
#    --clustername=\"${CLUSTER_NAME}\" \
#    --rbdhardmaxclonedepth=\"${RBD_HARD_MAX_CLONE_DEPTH}\" \
#    --rbdsoftmaxclonedepth=\"${RBD_SOFT_MAX_CLONE_DEPTH}\" \
#    --skipforceflatten=\"${SKIP_FORCE_FLATTEN}\" \
#    --maxsnapshotsonimage=\"${MAX_SNAPSHOTS_ON_IMAGE}\" \
#    --minsnapshotsonimage=\"${MIN_SNAPSHOTS_ON_IMAGE}\" \
#    --setmetadata=\"${SET_METADATA}\" \
#    --enable-read-affinity=\"${ENABLE_READ_AFFINITY}\" \
#    --logslowopinterval=\"${LOG_SLOW_OP_INTERVAL}\""

# Evaluate the constructed command
#eval exec $CMD

exec /usr/local/bin/cephcsi \
    --endpoint="unix:/${CSI_ENDPOINT}" \
    --nodeid="${NODE_ID}" \
    --stagingpath="${STAGING_PATH}" \
    --nodeserver=true \
    --controllerserver=true \
    --drivername="${DRIVER_NAME}" \
    --type="${TYPE}" \
    --clustername=ceph \
    --metricsport=8080 \
    --v="${CEPHCSI_VERBOSITY}"