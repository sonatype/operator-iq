#!/bin/sh

rm -rf bundle
rm -f nxiq-operator-certified-metadata.zip

mkdir bundle

CSVS=$(find deploy/olm-catalog -name '*.clusterserviceversion.yaml')

cp -v $CSVS bundle
cp -v deploy/olm-catalog/nxiq-operator-certified/nxiq-operator-certified.package.yaml bundle
cp -v deploy/crds/sonatype.com_nexusiqs_crd.yaml bundle/nxiq-operator-certified.crd.yaml

(cd bundle; zip -rv ../nxiq-operator-certified-metadata.zip .)

rm -rf bundle
