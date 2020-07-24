#!/bin/sh

if [ $# != 3 ]; then
    echo "Usage: $0 <shortVersion> <ubiVersion> <operatorVersion>"
    echo "Ex: $0 1.90.0 1.90.0-ubi-1 1.90.0-1"
    exit 1
fi

shortVersion=$1
ubiVersion=$2
operatorVersion=$3

oldOperatorVersion=$(cat deploy/olm-catalog/nxiq-operator-certified/nxiq-operator-certified.package.yaml \
    | grep currentCSV: | sed 's/.*v//')

function applyTemplate {
    sed "s/{{shortVersion}}/${shortVersion}/g" \
    | sed "s/{{ubiVersion}}/${ubiVersion}/g" \
    | sed "s/{{operatorVersion}}/${operatorVersion}/g" \
    | sed "s/{{oldOperatorVersion}}/${oldOperatorVersion}/g"
}

cat scripts/templates/Chart.yaml \
    | applyTemplate > helm-charts/iqserver/Chart.yaml

cat scripts/templates/Dockerfile \
    | applyTemplate > build/Dockerfile

cat scripts/templates/nxiq-operator-certified.package.yaml \
    | applyTemplate \
    > deploy/olm-catalog/nxiq-operator-certified/nxiq-operator-certified.package.yaml

if [ ! -d "deploy/olm-catalog/nxiq-operator-certified/${operatorVersion}" ]; then
    mkdir "deploy/olm-catalog/nxiq-operator-certified/${operatorVersion}"
fi

cat scripts/templates/nxiq-operator-certified.vX.X.X-X.clusterserviceversion.yaml \
    | applyTemplate \
    > "deploy/olm-catalog/nxiq-operator-certified/${operatorVersion}/nxiq-operator-certified.v${operatorVersion}.clusterserviceversion.yaml"

cat scripts/templates/operator.yaml | applyTemplate > deploy/operator.yaml

cat scripts/templates/sonatype.com_v1alpha1_nexusiq_cr.yaml \
    | applyTemplate > deploy/crds/sonatype.com_v1alpha1_nexusiq_cr.yaml

cat scripts/templates/values.yaml \
    | applyTemplate > helm-charts/iqserver/values.yaml
