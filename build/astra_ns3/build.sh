#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
NS3_DIR="${SCRIPT_DIR:?}"/../../extern/network_backend/ns3
BUILD_DIR="${SCRIPT_DIR:?}"/build/

function setup {
    protoc et_def.proto\
        --proto_path ${SCRIPT_DIR}/../../extern/graph_frontend/chakra/et_def/\
        --cpp_out ${SCRIPT_DIR}/../../extern/graph_frontend/chakra/et_def/
    mkdir -p "${BUILD_DIR}"
}

function compile {
    cd "${NS3_DIR}/simulation"
    ./waf configure
    ./waf --run 'scratch/AstraSimNetwork'
    cd "${SCRIPT_DIR:?}"
}

case "$1" in
-c|--compile)
    setup
    compile;;
esac
