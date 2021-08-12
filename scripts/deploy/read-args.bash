#!/bin/bash

# create directory if it does not exits

while getopts ":a:d:" opt; do
  case $opt in
    a)
      echo $OPTARG >> ~/docker-deploy/.deploy.env
      ;;
    d)
      echo $OPTARG >> ~/docker-deploy/.docker.env
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done


