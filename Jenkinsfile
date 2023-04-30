pipeline {
  agent any
  environment {
	MONGODB_URI = credentials('mongodb-uri')
	TOKEN_KEY = credentials('token-key')
	EMAIL = credentials('email')
	PASSWORD = credentials('password')
}
  stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}
    stage('Client Tests') {
	    steps {
		    dir('client') {
			    sh 'npm install'
			    sh 'npm test'
		    }
	    }
    }

    stage('Server Tests') {
	    steps {
		    dir('server') {
			    sh 'npm install'
			    sh 'export MONGODB_URI=$MONGODB_URI'
			    sh 'export TOKEN_KEY=$TOKEN_KEY'
			    sh 'export EMAIL=$EMAIL'
			    sh 'export PASSWORD=$PASSWORD'
			    sh 'npm test'
		  }
	  }
  }
  stage('Build Images') {
	steps {
		sh 'docker build -t nilesh9/productivity-app:client-latest client'
		sh 'docker build -t nilesh9/productivity-app:server-latest server'
	}
}
stage('Push Images to DockerHub') {
	steps {
		withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
			sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
			sh 'docker push nilesh9/productivity-app:client-latest'
			sh 'docker push nilesh9/productivity-app:server-latest'
		}
	}
}
}
}