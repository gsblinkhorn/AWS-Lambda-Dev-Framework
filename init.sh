#!/bin/bash

venvName=".venv-default"

while getopts ":p:v:" opt; do
    case $opt in
        v ) venvName=$OPTARG
            echo "VirtualEnv Name = $venvName" 
            ;;
        p ) set -f # disable glob
            IFS=',' # split on comma characters
            array=($OPTARG) # use the split+glob operator
            echo "Python Packages to Install = $OPTARG "
            ;; 
        * ) echo "Invalid option. Exiting ..."
            exit 1
    esac
done

# Create Virtualenv
python3 -m venv $venvName
source $venvName/bin/activate

# Install packages
for i in "${array[@]}"; do
    yes | pip3 install ${i}
done

pip3 freeze > requirements.txt