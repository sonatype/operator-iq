/*
 * Copyright (c) 2016-present Sonatype, Inc. All rights reserved.
 * Includes the third-party code listed at http://links.sonatype.com/products/nexus/attributions.
 * "Sonatype" is a trademark of Sonatype, Inc.
 */
@Library(['private-pipeline-library', 'jenkins-shared']) _

properties([
  parameters([
    string(
      name: 'version',
      description: 'Version tag to apply to the image, like 1.142.0-1.'
    ),
  ]),
])

node('ubuntu-zion') {
  try {
    stage('Preparation') {
      deleteDir()

      checkout scm

      sh 'docker system prune -a -f'
      sh '''
        wget -q -O preflight \
          https://github.com/redhat-openshift-ecosystem/openshift-preflight/releases/download/1.13.1/preflight-linux-amd64
        chmod 755 preflight
      '''
    }
    stage('Build') {
      withCredentials([
        usernamePassword(
          credentialsId: 'red-hat-quay-nexus-iq-server-operator',
          usernameVariable: 'REGISTRY_LOGIN',
          passwordVariable: 'REGISTRY_PASSWORD'),
        string(
          credentialsId: 'red-hat-api-token',
          variable: 'API_TOKEN'),
      ]) {
        sh 'PATH="$PATH:." VERSION=$version ./build_red_hat_image.sh'
      }
    }
  } finally {
    sh 'docker logout'
    sh 'docker system prune -a -f'
    sh 'git clean -f && git reset --hard origin/main'
  }
}
