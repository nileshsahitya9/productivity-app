pipeline {
  agent any
  environment {
	MONGODB_URI = credentials('mongodb-uri')
  AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
  AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
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
stage('Integrate Jenkins with EKS Cluster and Deploy App') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh """
                    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                    aws configure set region ap-south-1
                    """
                    sh 'aws eks update-kubeconfig --name my-eks-cluster --region ap-south-1'
                    sh "kubectl apply -f eks_deploy_k8.yaml"

                }
        }
    }
}
}