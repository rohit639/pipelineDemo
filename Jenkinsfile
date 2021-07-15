#!/usr/bin/env groovy

pipeline {
  agent {
    kubernetes {
    defaultContainer 'maven'
      yaml '''
        kind: Pod
        metadata:
          labels:
            some-label: some-label-value
        spec:
          containers:
          - name: maven
            image: maven:3.6.3-jdk-8-slim
            command:
            - cat
            tty: true
          '''
          }
          }

          stages {

          stage('Build') {
              parallel {
                  stage('micro service 1') {

                      steps {
                          sh '''
                          echo compile with test, Jar/War file
                          '''
                      }

                      post {

                          always {
                              script {
                                  if (env.CHANGE_ID) {
                                      pullRequestCommentCreatedAction(allowedBranches: "<h2>PR Check Point Failed!!</h2>" + "<table border=\"2\" width=35% style=\"border-collapse: collapse\">" +

                                              "<tr>" + "<th>Stage</th><th>Description</th><th>Status</th>" + "</tr>" +
                                              "<tr>" + "<td>1</td><td>mvn clean install</td><td align=\"CENTER\">:x:</td>" + "</tr>" +
                                              "<tr>" + "<td colspan=\"3\">" +
                                              "<table border=\"2\" width=100% style=\"border-collapse: collapse\">" +
                                              "<tr>" + "<th>Job Details</th><th>Links</th>" + "</tr>" +
                                              "<tr>" + "<td align=\"CENTER\">Jenkins Build</td><td align=\"CENTER\"><a href=$RUN_DISPLAY_URL>build</a></td>" + "</tr>" +
                                              "<tr>" + "<td align=\"CENTER\">Pull-Request</td><td align=\"CENTER\"><a href=$CHANGE_URL>$BRANCH_NAME</a></td>" + "</tr>" +
                                              "</tr>" + "</table>" + "</td>" + "</tr>" + "</table>")

                                  }
                              }
                          }

                      }
                  }
                  stage('micro service 2') {
                      steps {
                          echo 'any other service running ..'
                      }

                      post {
                          unsuccessful {
                              script {
                                  if (env.CHANGE_ID) {
                                      pullRequest.comment("<h2>PR Check Point Failed!!</h2>" + "<table border=\"2\" width=35% style=\"border-collapse: collapse\">" +

                                              "<tr>" + "<th>Stage</th><th>Description</th><th>Status</th>" + "</tr>" +
                                              "<tr>" + "<td align=\"CENTER\">1</td><td align=\"CENTER\">service 2 failed</td><td align=\"CENTER\">:x:</td>" + "</tr>" +
                                              "<tr>" + "<td colspan=\"3\">" +
                                              "<table border=\"2\" width=100% style=\"border-collapse: collapse\">" +
                                              "<tr>" + "<th>Job Details</th><th>Links</th>" + "</tr>" +
                                              "<tr>" + "<td align=\"CENTER\">Jenkins Build</td><td align=\"CENTER\"><a href=$RUN_DISPLAY_URL>build</a></td>" + "</tr>" +
                                              "<tr>" + "<td align=\"CENTER\">Pull-Request</td><td align=\"CENTER\"><a href=$CHANGE_URL>$BRANCH_NAME</a></td>" + "</tr>" +
                                              "</tr>" + "</table>" + "</td>" + "</tr>" + "</table>")

                                  }
                              }
                          }

                      }
                  }
              }
          }


            }
  }
