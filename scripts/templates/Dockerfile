# {{templateWarning}}
FROM quay.io/operator-framework/helm-operator:v1.19.1

# Required OpenShift Labels
LABEL name="Nexus IQ Server Operator" \
      vendor="Sonatype" \
      version="{{shortVersion}}" \
      release="1" \
      summary="Nexus IQ Server is a policy engine powered by precise intelligence on open source components." \
      description="Nexus IQ Server is a policy engine powered by precise intelligence on open source components."

# Required Licenses
COPY licenses /licenses

COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts/ ${HOME}/helm-charts/
