#!/bin/sh

API_URL=https://slack.com/api/files.upload
TOKEN=xoxp-83595193201-83601516066-120918001521-08317032b05c056bd776697a0ad2b57e
FNAME=$1
CHANNEL=#upload
FTYPE=shell #!!!!!
FTITLE=$2

curl -F file=@${FNAME} -F channels=${CHANNEL} -F filetype=${FTYPE} -F filename=${FTITLE} -F token=${TOKEN} -Ss ${API_URL}
