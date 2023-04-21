# DO NOT MODIFY. This is produced by template.
FROM quay.io/operator-framework/helm-operator:v1.26.0

# Required OpenShift Labels
LABEL name="Nexus IQ Server Operator" \
      vendor="Sonatype" \
      version="1.160.0" \
      release="1" \
      summary="Nexus IQ Server is a policy engine powered by precise intelligence on open source components." \
      description="Nexus IQ Server is a policy engine powered by precise intelligence on open source components."

USER root

RUN microdnf update -y \
    && microdnf clean all

# back to helm-operator's user
USER 1001

# Required Licenses
COPY licenses /licenses

COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts/ ${HOME}/helm-charts/
