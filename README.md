# Sonatype Nexus IQ Certified Operator
Red Hat certified OpenShift Operator for installing Sonatype Nexus IQ Server
to an OpenShift cluster.

## Building from Source for Local Development and Testing

To develop and test locally, you'll use CodeReady Containers on your workstation
and push your operator image to quay.io to make it available for installation.

1. Install [Red Hat OpenShift Local](https://developers.redhat.com/products/codeready-containers/overview) (formerly known as CodeReady Containers)
   for a local Openshift 4 environment.
2. Ensure you have a personal quay.io account.
3. Generate a new version of the operator image using the templates under test:
   `./scripts/new_version.sh image <new-operator-version> <cert-app-image-version>`
   
   Example: `./scripts/new_version.sh image 1.145.0-1 1.145.0-ubi-1` (*)
4. Build and deploy the operator image to your personal quay.io repository:
   1. `docker build . -f build/Dockerfile --tag quay.io/<username>/nxiq-operator-certified:[operator-version]`
   2. `docker login quay.io`
   3. `docker push quay.io/<username>/nxiq-operator-certified:[operator-version]`
5. Make sure the new image on quay.io is public, so that the OpenShift
   cluster can pull it. You should have **nxiq-operator-certified** repository with public visibility.
6. Update the bundle files for the new image:
   `./scripts/new_version.sh bundle <new-operator-version> <operator-image-id> <certified-app-image-id>`
   
   Example: `./scripts/new_version.sh bundle 1.145.0-1 quay.io/{quay.io-account}/nxiq-operator-certified:1.145.0-1 registry.connect.redhat.com/sonatype/nexus-iq-server@sha256:{sha256}` (*)
7. Install all the descriptors for the operator to your OpenShift cluster:
   1. `./scripts/install.sh`
   2. By executing `kubectl get pods` you should see a pod running in Openshift:

		`example-nexusiq-iqserver-{id}`
8. Expose the new IQ Server outside the cluster: 
   1. Create a Route in OpenShift UI to the new service, using:
      
      **Port:** 8070 → 8070.

      **Service:** example-nexusiq-iqserver-{id}
9. Visit the new URL shown on the Route page in OpenShift UI. And verfify everything on the IQ Server side is working as expected.
10. Default credentials are `admin`/`admin123`.

(*) You can get the tag of Nexus IQ Server Certified Image from [https://catalog.redhat.com/](https://catalog.redhat.com/) → Software → Container images → Find Nexus IQ Server. And the image id in the **Digest** section of this page.
  
## Uninstall Nexus IQ from a Local Test Cluster

1. Remove the route in the console.
2. Uninstall all the descriptors for the operator: `./scripts/uninstall.sh`.
