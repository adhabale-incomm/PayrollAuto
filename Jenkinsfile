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
		sh 'cd /Users/adhabale/.jenkins/workspace/flyway_pipeline_oracle'
		//sh 'cd /var/lib/jenkins/workspace/flyway_pipeline_oracle'
		//sh 'cd /Program Files (x86)/Jenkins/workspace/flyway_pipeline_oracle'
		    }
        }
}
}
//}
