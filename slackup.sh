#!/bin/sh

API_URL=https://slack.com/api/files.upload
TOKEN= #your slack API TOKEN
FNAME=$1
CHANNEL=#upload
FTYPE=shell #!!!!!
FTITLE=$2

curl -F file=@${FNAME} -F channels=${CHANNEL} -F filetype=${FTYPE} -F filename=${FTITLE} -F token=${TOKEN} -Ss ${API_URL}
