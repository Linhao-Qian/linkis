#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

WORK_DIR=`cd $(dirname $0); pwd -P`

. ${WORK_DIR}/common.sh

TMP_DIR=`mktemp -d -t kind-XXXXX`

set -e

# create kind cluster
echo "# Creating KinD cluster ..."
# create data dir for KinD cluster
KIND_CLUSTER_HOST_PATH=${TMP_DIR}/data
mkdir -p ${KIND_CLUSTER_HOST_PATH}
# create kind cluster conf
KIND_CLUSTER_CONF_TPL=${RESOURCE_DIR}/kind-cluster.yaml
KIND_CLUSTER_CONF_FILE=${TMP_DIR}/kind-cluster.yaml
KIND_CLUSTER_HOST_PATH=${KIND_CLUSTER_HOST_PATH} envsubst < ${KIND_CLUSTER_CONF_TPL} > ${KIND_CLUSTER_CONF_FILE}

echo "- kind cluster config: ${KIND_CLUSTER_CONF_FILE}"
cat ${KIND_CLUSTER_CONF_FILE}
kind create cluster --name ${KIND_CLUSTER_NAME} --config ${KIND_CLUSTER_CONF_FILE}