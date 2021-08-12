#!/bin/bash

# create directory if it does not exits
mkdir -p ~/app

while getopts ":a:d:" opt; do
  case $opt in
    a)
      echo $OPTARG >> ~/app/.deploy.env
      ;;
    d)
      echo $OPTARG >> ~/app/.docker.env
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


