#!/bin/bash
target="./packages"
zipFile="deploy-package.zip"

while getopts ":p:l:" opt; do
    case $opt in
        l ) lambda=$OPTARG
            echo "Target Lambda = $lambda"
            ;;
        p ) pyFile=$OPTARG
            echo "Lambda File = $pyFile" 
            ;;
        # z ) zipFile=$OPTARG
        #     echo "Zip File Name = $zipFile" 
        #     ;;
        * ) echo "Invalid option. Exiting ..."
            exit 1
    esac
done

source .venv*/bin/activate

pip3 install -r ./requirements.txt --target $target
cd $target && zip -r9 ../${zipFile} . && cd ..
zip -g ${zipFile} ${pyFile}

echo "Deploying updated zip file to AWS Lambda ..."
aws lambda update-function-code --function-name $lambda --zip-file fileb://./${zipFile}