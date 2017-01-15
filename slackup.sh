#!/bin/sh

API_URL=https://slack.com/api/files.upload
TOKEN= #YOUR SLACK API TOKEN
FNAME=$1
CHANNEL=#upload
FTYPE=shell #!!!!!
FTITLE=$2

curl -S -s -F file=@${FNAME} -F channels=${CHANNEL} -F filetype=${FTYPE} -F filename=${FTITLE} -F token=${T\
OKEN} ${API_URL}
