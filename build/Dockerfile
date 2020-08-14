# DO NOT MODIFY. This is produced by template.
FROM quay.io/operator-framework/helm-operator:v0.17.0


# Required OpenShift Labels
LABEL name="Nexus IQ Server Operator" \
      vendor="Sonatype" \
      version="1.97.0" \
      release="1" \
      summary="Nexus IQ Server is a policy engine powered by precise intelligence on open source components." \
      description="Nexus IQ Server is a policy engine powered by precise intelligence on open source components."

# Required Licenses
COPY licenses /licenses

COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts/ ${HOME}/helm-charts/
