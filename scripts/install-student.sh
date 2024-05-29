#!/usr/bin/env bash

if [ "$1" = "" ]
then
 echo "No student provisioning found, workstation probably empty"
 exit
fi

PROJECT=$1

ansible-pull --checkout main \
             --directory /tmp/ansible-config-student \
             --inventory=localhost, \
             --module-name=git \
             --url=https://github.com/${PROJECT} \
             --verbose \
             --only-if-changed \
             --user vagrant \
             playbook.yml