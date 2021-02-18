pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    environment {
    PATH = "C:\\Program Files\\Git\\usr\\bin;C:\\Program Files\\Git\\bin;${env.PATH}"
    
   
    stages {
        stage('Checkout') {
            steps {
                echo 'Run Flyway Github'
                git 'https://github.com/adhabale-incomm/PayrollAuto.git'
		checkout scm
                //stash includes: '*.sql', name: 'db' 
		//sh 'cd /Users/adhabale/.jenkins/workspace/flyway_pipeline_oracle'
		//sh 'cd /var/lib/jenkins/workspace/flyway_pipeline_oracle'
		sh 'cd /Program Files (x86)/Jenkins/workspace/flyway_pipeline_oracle'
            }
        }
        stage('Build - DB Migration') {
            environment {
		FLYWAY_LOCATIONS=filesystem:/${WORKSPACE}/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2/sql
                FLYWAY_URL='jdbc:oracle:thin:@//sdmdmora01v.unx.incommtech.net:1521/PDEVMDM'
                FLYWAY_USER='flyway_test'
                FLYWAY_PASSWORD='flywaytest'
                FLYWAY_SCHEMAS='PDEVMDM'
		FLYWAY_PATH='/usr/bin'
            }
            steps {
                echo 'Run Flyway Migration'
		echo "${WORKSPACE}"
		sh 'whereis flyway'
		sh 'flyway info'
		sh 'ls -ltr /usr/bin'
		//unstash 'db'
		//flywayrunner installationName: 'flywaytool', flywayCommand: 'migrate', credentialsId: $FLYWAY_USER/$FLYWAY_PASSWORD, url: $FLYWAY_URL', locations: $FLYWAY_LOCATIONS
                sh '$FLYWAY_PATH/flyway -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url=$FLYWAY_URL -locations=$FLYWAY_LOCATIONS info'
	    	}
        }
        stage('Parallel - Dev Delivery') {
            failFast true // first to fail abort parallel execution
            parallel {
		stage('DEVA - DB Delivery') {
			input {
               			message "Should we continue?"
                		ok "Yes, we should."
                		submitter "Developer,DBA"
                		parameters {
                    			string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                		}
            		}				
		        environment {
				
				FLYWAY_LOCATIONS='filesystem:/${WORKSPACE}/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2/sql'
                FLYWAY_URL='jdbc:oracle:thin:@//sdmdmora01v.unx.incommtech.net:1521/PDEVMDM'
                FLYWAY_USER='flyway_test'
                FLYWAY_PASSWORD='flywaytest'
                FLYWAY_SCHEMAS='PDEVMDM'
				FLYWAY_PATH='/Users/adhabale/.jenkins/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2'
		        }
		        steps {
		                echo 'Run Flyway Migration'
				//        unstash 'db'
		                sh '$FLYWAY_PATH/flyway -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url=$FLYWAY_URL -locations=$FLYWAY_LOCATIONS migrate'
			    }
		 }
		 stage('DEVB - DB Delivery') {
		            environment {
				       FLYWAY_LOCATIONS='filesystem:/${WORKSPACE}/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2/sql'
                FLYWAY_URL='jdbc:oracle:thin:@//sdmdmora01v.unx.incommtech.net:1521/PDEVMDM'
                FLYWAY_USER='flyway_test'
                FLYWAY_PASSWORD='flywaytest'
                FLYWAY_SCHEMAS='PDEVMDM'
						FLYWAY_PATH='/Users/adhabale/.jenkins/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2'
		            }
		            steps {
		                echo 'Run Flyway Migration'
				        //unstash 'db'
		                sh '$FLYWAY_PATH/flyway -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url=$FLYWAY_URL -locations=$FLYWAY_LOCATIONS migrate'            
			    }
		        }
		    }
		}
	    stage('Results - Development') {
		steps {
                 	script {
                    			timeout(time: 1, unit: 'DAYS') {
                        			def userInput = input message: 'Approve Delivery on Development or Rollback?'
                                }
                                def userInput = input(
                                id: 'userInput', message: 'Approve Delivery on Development or Rollback ?', 
                                parameters: [
                                [$class: 'TextParameterDefinition', defaultValue: 'None', description: 'Approve Development Delivery', name: 'Commit'],
                                [$class: 'TextParameterDefinition', defaultValue: 'None', description: 'Undo Development Delivery', name: 'Rollback']
                                ])
                                node {
                                    if (userInput == 'Commit') {
                                        // do something
                                        echo "this was successful"
                                    } else {
                                        // do something else
                                        echo "this was not successful"
                                        currentBuild.result = 'FAILURE'
                                    } 
                                }
                                 
                                echo ("Approve Development Delivery: "+userInput['Commit'])
                                echo ("Undo Development Delivery: "+userInput['Rollback'])
                		}
		}
   	   }

	stage('Parallel - Stage Delivery') {
            	failFast true // first to fail abort parallel execution
            	parallel {
			stage('STA - DB Delivery') {
		            environment {
				    FLYWAY_LOCATIONS='filesystem:/${WORKSPACE}/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2/sql'
                FLYWAY_URL='jdbc:oracle:thin:@//sqmdmora01v.unx.incommtech.net:1521/PQEVMDM'
                FLYWAY_USER='mdm'
                FLYWAY_PASSWORD='mdm'
                FLYWAY_SCHEMAS='PQEVMDM'
					FLYWAY_PATH='/Users/adhabale/.jenkins/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2'
		            }
		            steps {
		                echo 'Run Flyway Migration'
				        //unstash 'db'
		                sh '$FLYWAY_PATH/flyway -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url=$FLYWAY_URL -locations=$FLYWAY_LOCATIONS migrate'            
			    }
		        }
		        stage('STB - DB Delivery') {
		            environment {
				         FLYWAY_LOCATIONS='filesystem:/${WORKSPACE}/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2/sql'
                FLYWAY_URL='jdbc:oracle:thin:@//sqmdmora01v.unx.incommtech.net:1521/PQEVMDM'
                FLYWAY_USER='mdm'
                FLYWAY_PASSWORD='mdm'
                FLYWAY_SCHEMAS='PQEVMDM'
						FLYWAY_PATH='/Users/abderrahim.boussetta/.jenkins/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2'
		            }
		            steps {
		                echo 'Run Flyway Migration'
				        //unstash 'db'
		                sh '$FLYWAY_PATH/flyway -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url=$FLYWAY_URL -locations=$FLYWAY_LOCATIONS migrate'            
			
			    }
		        }
		}   
	}
	stage('Results - Staging') {
		steps {
                 	script {
                    			timeout(time: 1, unit: 'DAYS') {
                        			input message: 'Approve Delivery on Staging?'
                    			}
                		}
		}
   	}
    stage('PRODB - DB Deployment') {
        environment {
            FLYWAY_LOCATIONS='filesystem:/Users/abderrahim.boussetta/.jenkins/workspace/flyway_pipeline_oracle/flyway'
            FLYWAY_URL='jdbc:oracle:thin:@//stmdmora01v.unx.incommtech.net/PINTMDM'
            FLYWAY_USER='mdm'
            FLYWAY_PASSWORD='mdm'
            FLYWAY_SCHEMAS='PINTMDM'
			FLYWAY_PATH='/Users/adhabale/.jenkins/tools/sp.sd.flywayrunner.installation.FlywayInstallation/flyway-6.2.2'
        }
        steps {
            echo 'Run Flyway Migration'
            //unstash 'db'
            sh '$FLYWAY_PATH/flyway -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url=$FLYWAY_URL -locations=$FLYWAY_LOCATIONS migrate'
        }
    }
    stage('Results - Production') {
		steps {
                 	script {
                    			timeout(time: 1, unit: 'DAYS') {
                        			input message: 'Approve Delivery on Production?'
                    			}
                		}
		}
   	}
}
 post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }

}
}
