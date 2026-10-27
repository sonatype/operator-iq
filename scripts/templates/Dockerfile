# {{templateWarning}}
FROM quay.io/operator-framework/helm-operator:v1.26.0

# Required OpenShift Labels
LABEL name="Nexus IQ Server Operator" \
      vendor="Sonatype" \
      version="{{shortVersion}}" \
      release="1" \
      summary="Nexus IQ Server is a policy engine powered by precise intelligence on open source components." \
      description="Nexus IQ Server is a policy engine powered by precise intelligence on open source components." \
      maintainer="Sonatype"

USER root

RUN microdnf update -y \
    && microdnf clean all

# Distrust the roots of the compromised eMudhra intermediate CAs (CLM-55907).
# Remove once the base image ships a ca-certificates without them.
RUN d=/etc/pki/ca-trust/source/blocklist; [ -d "$d" ] || d=/etc/pki/ca-trust/source/blacklist; \
    trust extract --overwrite --format=pem-bundle \
      --filter='pkcs11:object=Comodo%20AAA%20Services%20root;type=cert' "$d/Comodo_AAA_Services_root.pem" \
    && trust extract --overwrite --format=pem-bundle \
      --filter='pkcs11:object=emSign%20ECC%20Root%20CA%20-%20G3;type=cert' "$d/emSign_ECC_Root_CA_-_G3.pem" \
    && update-ca-trust

# back to helm-operator's user
USER 1001

# Required Licenses
COPY licenses /licenses

COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts/ ${HOME}/helm-charts/
