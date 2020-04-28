#!/bin/sh

kubectl create -f deploy/service_account.yaml
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml
kubectl create -f deploy/crds/apm.nxiq.com_nexusiqs_crd.yaml
kubectl create -f deploy/operator.yaml
kubectl create -f deploy/crds/apm.nxiq.com_v1alpha1_nexusiq_cr.yaml
