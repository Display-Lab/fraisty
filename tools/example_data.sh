#!/usr/bin/env bash

# Determine where this script resides.
# Start by assuming it was the path invoked.
THIS_SCRIPT="$0"

# Handle resolving symlinks to this script.
# Using ls instead of readlink.
while [ -h "$THIS_SCRIPT" ] ; do
  ls=`ls -ld "$THIS_SCRIPT"`
  # Drop everything prior to ->
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    THIS_SCRIPT="$link"
  else
    THIS_SCRIPT=`dirname "$THIS_SCRIPT"`/"$link"
  fi
done

# Get path to the scripts directory.
SCRIPT_DIR=$(dirname "${THIS_SCRIPT}")

DATA_DIR=${SCRIPT_DIR}/../data

if [[ ! -d $DATA_DIR ]]; then
	mkdir $DATA_DIR
fi

# Ensure data isn't already downloaded
if [ -f "${DATA_DIR}/data.zip" ]; then
	echo >&2 "The zip already exists. Skipping download.";
else
	#Download spending data as example_data.json
	wget -O ${DATA_DIR}/data.zip "https://files.digital.nhs.uk/96/A7878A/2018_11_Nov.zip"
fi

unzip ${DATA_DIR}/data.zip -d ${DATA_DIR}


