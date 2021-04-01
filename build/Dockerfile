# DO NOT MODIFY. This is produced by template.
FROM quay.io/operator-framework/helm-operator:v1.5.0

# Required OpenShift Labels
LABEL name="Nexus IQ Server Operator" \
      vendor="Sonatype" \
      version="1.108.0" \
      release="1" \
      summary="Nexus IQ Server is a policy engine powered by precise intelligence on open source components." \
      description="Nexus IQ Server is a policy engine powered by precise intelligence on open source components."

USER root
RUN microdnf install yum
RUN yum -y update-minimal --security --sec-severity=Important --sec-severity=Critical
RUN microdnf remove yum && microdnf clean all

# Required Licenses
COPY licenses /licenses

COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts/ ${HOME}/helm-charts/
