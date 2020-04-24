# Sonatype Nexus IQ Certified Operator
Red Hat certified OpenShift Operator for installing Sonatype Nexus IQ Server
to an OpenShift cluster.

## Building from Source for Local Development and Testing

To develop and test locally, you'll use CodeReady Containers on your workstation
and push your operator image to quay.io to make it available for installation.

1. Install [https://developers.redhat.com/products/codeready-containers/overview](CodeReady Containers)
   for a local Openshift 4 environment.
2. Ensure you have a personal quay.io account.
3. Build and deploy the operator image to your personal quay.io repository:
   1. `operator-sdk build quay.io/<username>/nxiq-operator-certified`
   2. `docker login quay.io`
   3. `docker push quay.io/<username>/nxiq-operator-certified`
5. Make sure the new image on quay.io is public.
6. Update the `deploy/operator.yaml` to point to your test image at quay.io.
7. Install all the descriptors for the operator to your OpenShift cluster:
   1. `scripts/install.sh`
8. Expose the new IQ Server outside the cluster: 
   2. Create a Route in OpenShift UI to the new service, port 8070.
9. Visit the new URL shown on the Route page in OpenShift UI.
  
## Uninstall Nexus IQ from a Local Test Cluster

1. Remove the route in the console.
2. Uninstall all the descriptors for the operator: `scripts/uninstall.sh`.

## Building for Production

1. Follow the "Upload Your Image" instructions with IDs provided at
   https://connect.redhat.com/project/4049231/view to login and push 
   your docker image.
2. Package and upload metadata to Operator Config
   1. `cd bundle; zip -rv ../nxiq-operator-certified-metadata.zip .`
   2. Upload the zip to "Operator Config" of
     https://connect.redhat.com/project/4049231/view
   3. Once it successfully scans, which can take up to an hour, publish the config.
