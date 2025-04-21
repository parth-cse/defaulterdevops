pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                echo 'Assuming WAR file is already built by Eclipse and present in the repository.'
                echo 'Please ensure your .gitignore file includes the Eclipse build output directories'
                echo '(e.g., .settings/, .classpath, bin/, WebContent/WEB-INF/classes/).'
                echo 'We will look for the WAR file directly.'
                script {
                    // Attempt to find a single WAR file in the repository root or WebContent directory
                    def warFiles = findFiles(glob: '*.war') + findFiles(glob: 'WebContent/*.war')

                    if (warFiles.size() == 1) {
                        env.WAR_FILE_PATH = warFiles[0].path
                        echo "Found WAR file: ${env.WAR_FILE_PATH}"
                    } else if (warFiles.size() > 1) {
                        error "Multiple WAR files found. Please ensure only one WAR file exists in the repository root or WebContent directory."
                    } else {
                        error "No WAR file found in the repository root or WebContent directory. Ensure your project build process (in Eclipse) generates a WAR file and it is committed to the repository."
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (env.WAR_FILE_PATH) {
                        deploy adapters: [tomcat9(credentialsId: 'tomcat-credentials', url: 'http://localhost:8080/')],
                               contextPath: 'my-servlet-app',
                               war: "${env.WAR_FILE_PATH}"
                    } else {
                        echo "Skipping deployment as the WAR file path was not determined."
                    }
                }
            }
        }
    }
}