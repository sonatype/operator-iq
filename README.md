# Sonatype Nexus IQ Certified Operator
Red Hat certified OpenShift Operator for installing Sonatype Nexus IQ Server
to an OpenShift cluster.

## Building from Source for Local Development and Testing

To develop and test locally, you'll use CodeReady Containers on your workstation
and push your operator image to quay.io to make it available for installation.

1. Install [CodeReady Containers](https://developers.redhat.com/products/codeready-containers/overview)
   for a local Openshift 4 environment.
2. Ensure you have a personal quay.io account.
3. Generate a new version of the operator image using the templates under test:
   `./scripts/new_version.sh image <new-operator-version> <cert-app-image-version>`
4. Build and deploy the operator image to your personal quay.io repository:
   1. `docker build . -f build/Dockerfile --tag quay.io/<username>/nxiq-operator-certified:[operator-version]`
   2. `docker login quay.io`
   3. `docker push quay.io/<username>/nxiq-operator-certified:[operator-version]`
5. Make sure the new image on quay.io is public, so that the OpenShift
   cluster can pull it.
6. Update the bundle files for the new image:
   ` ./scripts/new_version.sh bundle <new-operator-version> <operator-image-id> <certified-app-image-id>`
7. Install all the descriptors for the operator to your OpenShift cluster:
   1. `./scripts/install.sh`
8. Expose the new IQ Server outside the cluster: 
   1. Create a Route in OpenShift UI to the new service, port 8070.
9. Visit the new URL shown on the Route page in OpenShift UI.
10. Default credentials are `admin`/`admin123`.
  
## Uninstall Nexus IQ from a Local Test Cluster

1. Remove the route in the console.
2. Uninstall all the descriptors for the operator: `./scripts/uninstall.sh`.
