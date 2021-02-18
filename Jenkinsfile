import hudson.model.*
import hudson.console.HyperlinkNote
import hudson.AbortException
import groovy.xml.MarkupBuilder
import groovy.xml.*
import groovy.util.*
import groovy.json.*

pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
	tools {
		//maven 'maven-3.2.5'
		git 'Default'
	}
 environment {
    PATH = "C:\\Program Files\\Git\\usr\\bin;C:\\Program Files\\Git\\bin;C:\\Users\\adhabale.TS\\AppData\\Local\\Git\\cmd\\git.exe;C:\\Program Files\\Git\\cmd\\git.exe"
	   // echo 'path successed'
 }
 stages {
        stage('Checkout') {
            
		steps {
		  
                echo 'Run Flyway Github'
                git 'https://github.com/adhabale-incomm/PayrollAuto.git'
		checkout scm
              // stash includes: '*.sql', name: 'db' 
		//sh 'cd /Users/adhabale/.jenkins/workspace/flyway_pipeline_oracle'
		//sh 'cd /var/lib/jenkins/workspace/flyway_pipeline_oracle'
		bat  "cd c:/Program Files (x86)/Jenkins/workspace/flyway_pipeline_oracle"
		    }
        }
	       stage('Build - DB Migration') {
            environment {
		FLYWAY_LOCATIONS='filesystem:/${WORKSPACE}/flyway_pipeline_oracle/flyway'
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
                bat "$FLYWAY_PATH/flyway -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url=$FLYWAY_URL -locations=$FLYWAY_LOCATIONS migrate"
	    	}
        }
}
}
//}
