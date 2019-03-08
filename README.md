# AWS-Lambda-Dev-Framework

I created this framework to facilitate the development of AWS Lambda Functions (Python 3.6) which require third-party dependencies to function. It contains two scripts for initializing the workspace and conveniently deploying your function code to AWS Lambda. It also contains an empty Lambda function template.

## init.sh
Creates a virtualenv in the present working directory, installs any specified python packages and freezes these dependencies to a requirements.txt file.

#### Flags
Both flags are optional.

-v : the name of the virtualenv to be created (defaults to '.venv-default' if option not specified)

-p : a list of comma-separated values specifying the desired python packages to install in the virtualenv

#### Example Execution
This command creates a virutalenv named .venv-test and installs the praw and tweepy libraries into .venv-test: 

`bash init.sh -v .venv-test -p praw,tweepy`

Virtual environments can be turned on by running:

`source ${virtualEnvName}/bin/activate`

and subsequently disabled by running:

`deactivate`

## deploy.sh
This script assumes that you have already configured the awscli for your AWS account. It will install every dependency specified in the requirements.txt file into a packages directory, create a zip file of these dependencies called 'deploy-package.zip', and add the specified python file (your lambda function code) into this zip file. It will then use the awscli to upload your deployment package to an existing Lambda in AWS. 

#### Flags
*Both of these flags are required for the script to function properly.*

-l : the name of the AWS Lambda function to deploy your code to

-p : the name of your python file containing your lambda handler

#### Example Execution
This command packages any dependencies specified in the requirements.txt folder, adds 'lambda_function.py' to the package, and deploys that package to 'TheNameOfTheLambdaFunction' Lambda function in AWS.

`bash deploy.sh -l TheNameOfTheLambdaFunction -p lambda_function.py`
