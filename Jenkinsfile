pipeline {
  agent any
  options {
    skipStagesAfterUnstable()
  }
  
  stages {
    stage('Clonar repositorio') {
      steps {
        script{
          checkout scm
        }
      }
    }

    stage('Analise com o SonarQube') {
      steps {
        script {
          def scannerHome = tool 'SonarScanner';
          withSonarQubeEnv() {
            sh "${scannerHome}/bin/sonar-scanner"
          }
        }
      }
    }
        
    stage('Build da imagem') {
      steps {
        script {
          app = docker.build("producao-aluraflix:latest")
        }
      }
    }

    stage('Derrubando o container antigo') {
      steps {
        script {
          try {
            sh 'docker rm -f aluraflix'
          } catch (Exception e) {
              sh "echo $e"
            }
        }
      }
    }

    stage('Subindo o novo container') {
      steps {
        script {
          try {
            sh 'docker run -d -p 81:8000 --name aluraflix producao-aluraflix:latest '
          } catch (Exception e) {
              slackSend (color: 'error', message: "[ FALHA ] Não foi possivel subir o container - ${BUILD_URL} em ${currentBuild.duration}s", tokenCredentialId: 'slack_auth')
              sh "echo $e"
              currentBuild.result = 'ABORTED'
              error('Erro')
            }
        }
      }
    }

    stage('Notificando os usuarios') {
      steps {
        slackSend (color: 'good', message: '[ Sucesso ] O novo build esta disponivel em: http://localhost:81/ ', tokenCredentialId: 'slack_auth')
      }
    }        

    
    stage ('Fazer o deploy para a producao?') {
      steps {
        script {
          slackSend (color: 'warning', message: "Para aplicar a mudança para a produção, acesse [Janela de 30 minutos]: ${JOB_URL}", tokenCredentialId: 'slack_auth')
          timeout(time: 30, unit: 'MINUTES') {
            input(id: "Deploy Gate", message: "Deploy para a produção?", ok: 'Deploy')
          }
        }
      }
    }

    stage (deploy) {
      steps {
        script {
          try {
            build job: 'Aluraflix_Job_Prod'
          } catch (Exception e) {
            slackSend (color: 'error', message: "[ FALHA ] Não foi possivel subir o container em producao - ${BUILD_URL}", tokenCredentialId: 'slack_auth')
            sh "echo $e"
            currentBuild.result = 'ABORTED'
            error('Erro')
            }
        }
      }
    }
  }
}










