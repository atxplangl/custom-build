def DeploytoDev(branch){
    return branch ==~ "develop"
}

def DeploytoRel(branch){
    return branch.contains('release/')
}

def SlackBuildNotify(String buildResult) {
  if ( buildResult == "SUCCESS" ) {
    slackSend channel: "#ms-platform-notif", color: "good", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was successful"
  }
  else if( buildResult == "FAILURE" ) {
    slackSend channel: "#ms-platform-notif", color: "danger", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was failed"
  }
  else if( buildResult == "UNSTABLE" ) {
    slackSend channel: "#ms-platform-notif", color: "warning", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was unstable"
  }
  else {
    slackSend channel: "#ms-platform-notif", color: "danger", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} its resulat was unclear"
  }
}

pipeline {
  agent {
      label ''
  }
  options {
    disableConcurrentBuilds()
  }
  environment {
    git_tool = tool(name: 'Default', type: 'git')
  }
  stages {
      stage('Checkout') {
        steps {
          script {
                 scmInfo = checkout scm
                 echo "scm : ${scmInfo}"
                 env.BRANCH_NAME = scmInfo.GIT_BRANCH
                 echo "${BRANCH_NAME}"
          }
        }
      }
      stage('Build') {
        steps {
          {
            sh '''
	    ### add build steps here ###'''
          }
       }
      }
      stage('deploy-dev')  {
       when {
                expression { DeploytoDev (env.BRANCH_NAME) }
            }
	       steps {
                 }
      }
      stage('deploy-rel')  {
           when {
                    expression { DeploytoRel (env.BRANCH_NAME) }
                }
    	       steps {
                     }
        }
       stage('publish-checkstyle')  {
       	steps {
       		checkstyle canComputeNew: false, defaultEncoding: '', healthy: '', pattern: 'source-code/build/checkstyle-result.xml', unHealthy: ''
       	}
       }
       stage('publish-cobertura')  {
       	steps {
       		cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'source-code/build/cobertura-coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
       	}
       }
       stage('publish-junit-test')  {
       	steps {
       		step([$class: 'JUnitResultArchiver', testResults: 'source-code/build/test-result.xml'])
       	}
       }
      }
      post {
                     always {
                         script {
                            currentBuild.result = currentBuild.result ?: 'SUCCESS'
                            notifyBitbucket commitSha1: '', considerUnstableAsSuccess: false, credentialsId: '13c82382-74b8-4c8f-872f-e05a8074617a', disableInprogressNotification: true, ignoreUnverifiedSSLPeer: true, includeBuildNumberInKey: false, prependParentProjectKey: false, projectKey: '', stashServerBaseUrl: 'https://stash.acxiom.com'
                            cleanWs()
                            SlackBuildNotify(currentBuild.currentResult)
                         }
                     }
      }
}
