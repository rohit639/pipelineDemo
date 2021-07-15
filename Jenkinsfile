#!/usr/bin/env groovy

pipeline {
  agent any

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
                                      pullRequest.comment("<h2>PR Check Point Failed!!</h2>" + "<table border=\"2\" width=35% style=\"border-collapse: collapse\">" +

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

          stage('Deploy') {
              steps {
                  timeout(time: 2, unit: 'MINUTES') {
                      sh '''
                 echo "Copy/Move from target to server"
                '''

                  }

              }



          }


          stage('Server Check') {
              parallel {
                  stage('server 1') {
                      steps {

                          timeout(time: 6, unit: 'MINUTES') {
                              sh '''
                 echo "Can run curl to check if server is up or not in a loop. If up break the loop"
              '''
                          }
                      }


                  }
                  stage('server 2') {
                      steps {
                          timeout(time: 6, unit: 'MINUTES') {
                              sh '''
                            echo "Can run curl to check if server is up or not in a loop. If up break the loop"
                             '''
                          }
                      }
                  }
              }
              post {

                  success {
                      script {
                          if (env.CHANGE_ID) {
                              pullRequest.comment("<h2>PR Check Point Failed!!</h2>" + "<table border=\"2\" width=35% style=\"border-collapse: collapse\">" +
                                      "<tr>" + "<th>Stage</th><th>Description</th><th>Status</th>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">1</td><td align=\"CENTER\">mvn clean install</td><td align=\"CENTER\">&#x2713;</td>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">2</td><td align=\"CENTER\">Server Deployment</td><td align=\"CENTER\">&#x2713;</td>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">3</td><td align=\"CENTER\">Web Server up check</td><td align=\"CENTER\">:x:</td>" + "</tr>" +
                                      "<tr>" + "<td colspan=\"3\">" +
                                      "<table border=\"2\" width=100% style=\"border-collapse: collapse\">" +
                                      "<tr>" + "<th>Job Details</th><th>Links</th>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">Jenkins Build</td><td align=\"CENTER\"><a href=$RUN_DISPLAY_URL>build</a></td>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">Github Pull-Request</td><td align=\"CENTER\"><a href=$CHANGE_URL>$BRANCH_NAME</a></td>" + "</tr>" +
                                      "</tr>" + "</table>" + "</td>" + "</tr>" + "</table>")
                          }
                      }
                  }

              }
          }

          stage("QA-Test") {
              /* agent { label 'qa-automation' } */
              steps{
                /*  dir('/var/jenkins/workspace/automation-code') { */
                      timeout(time: 6, unit: 'MINUTES'){
                          sh '''#!/bin/bash -l
                  echo "run shell script to run runAutomation"
                '''

                      }
              }

              post {

                  always {
                      script {
                          if (env.CHANGE_ID) {
                              pullRequest.comment("<h2>PR Check Point Failed!!</h2>" + "<table border=\"2\" width=35% style=\"border-collapse: collapse\">" +
                                      "<tr>" + "<th>Stage</th><th>Description</th><th>Status</th>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">1</td><td align=\"CENTER\">mvn clean install</td><td align=\"CENTER\">&#x2713;</td>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">2</td><td align=\"CENTER\">Server Deployment</td><td align=\"CENTER\">&#x2713;</td>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">3</td><td align=\"CENTER\">Server up check</td><td align=\"CENTER\">&#x2713;</td>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">4</td><td align=\"CENTER\">QA-Test</td><td align=\"CENTER\">&#x2713;</td>" + "</tr>" +
                                      "<tr>" + "<td colspan=\"3\">" +
                                      "<table border=\"2\" width=100% style=\"border-collapse: collapse\">" +
                                      "<tr>" + "<th>Job Details</th><th>Links</th>" + "</tr>" +
                                      "<tr>" + "<td align=\"CENTER\">Jenkins Build</td><td align=\"CENTER\"><a href=$BUILD_URL>$BUILD_ID</a></td>" + "</tr>" +
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
