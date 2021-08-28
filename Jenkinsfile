#!/usr/bin/env groovy

pipeline {
  agent any
  environment {
       ALLURE = 'allure'
   }
          stages {

          stage('Build') {
              parallel {
                  stage('micro service 1') {
                    tools {
                      nodejs "nodejs"
                    }
                      steps {
                        echo path
                        dir('/Users/rohitkumar/eclipse-workspace/cashgramwebapp'){
                          sh '''
                          pwd
                          '''
                          }
                      }

                  }
                  stage('micro service 2') {
                    tools {
                        maven 'M3'
                    }     
                      steps {
                          echo 'any other service running ..'
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
                              sh serverCheck.sh cashgram
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

          }

          stage("QA-Test") {
              /* agent { label 'qa-automation' } */
              steps{
                /*  dir('/var/jenkins/workspace/automation-code')  */
                      timeout(time: 6, unit: 'MINUTES'){

                  sh '''#!/bin/bash -l
                  echo "run shell script to run runAutomation"
                    '''

                      } }

              post {

                  always {
                      script {
                          if (env.CHANGE_ID) {
                            mail to: 'rohit.kumar@cashfree.com', 
                            body: ("Hello dfhfjkfgkjfg",readFile("emailDemo.html")),
                            replyTo: 'qa-bots@cashfree.com', 
                            from: '', 
                            subject: "PR-Check Failed | Pull-Request: $BRANCH_NAME | Job-No: $BUILD_ID", 
                            mimeType: 'text/html'
                              }
                      }
                  }
              }
              }


              stage("Report-Generation") {
                /*  agent { label 'qa-automation' } */
                  steps {
                  slackSend baseUrl: 'https://hooks.slack.com/services/',
                  channel: 'pr-notification-demo',
                  color: '#ff0000',
                  message: "PR Check Point Failed: Stage 'QA-TEST [${env.BRANCH_NAME}]'  ❌ (${env.BUILD_URL})",
                  notifyCommitters: true,
                  teamDomain: 'cashfreepayments',
                  tokenCredentialId: 'slack-ID'

                  /*    dir('/var/jenkins/workspace/QA-smoke/automation') { */
                          timeout(time: 3, unit: 'MINUTES') {
                              script {
                                  println("*** Generating Report For QA-TEST ... ***")
                                  if (fileExists('allure-results')) {
                                      allure([
                                              includeProperties: false,
                                              jdk              : '',
                                              properties       : [],
                                              reportBuildPolicy: 'ALWAYS',
                                              results          : [[path: 'allure-results']]
                                      ])
                                  }
                              }
                          }
                    /*  } */
                  }
                  post {
                      always {
                          script {
                              if (env.CHANGE_ID) {
                              pullRequest.comment("<h2>PR Check Point Passed!!</h2>" + "<table border=\"2\" width=35% style=\"border-collapse: collapse\">" +
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
                                      "<tr>" + "<td colspan=\"2\">" +
                                    "<table border=\"3\" width=100% style=\"border-collapse: collapse\">" +
                                    "<tr>" + "<th colspan=\"3\">Reports</th>" + "</tr>" +
                                    "<tr>" +
                                    "<td align=\"CENTER\"><a href=$BUILD_URL$ALLURE>Allure</a></td>" +
                                    "</tr>" +
                                    "</tr>" + "</table>" + "</tr>" + "</table>" + "</td>" + "</tr>" + "</table>")

                                  slackSend baseUrl: 'https://hooks.slack.com/services/',
                                  channel: 'pr-notification-demo',
                                  color: '#00FF00',
                                  message: "PR Check Point Passed: [${env.BRANCH_NAME}]'  ✓ (${env.CHANGE_URL})",
                                  notifyCommitters: true,
                                  teamDomain: 'cashfreepayments',
                                  tokenCredentialId: 'slack-ID'
                              }

                          }
                      }

                  }
              }
          }
            }
