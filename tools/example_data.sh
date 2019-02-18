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

# Ensure data isn't already downloaded
if [ -f "${DATA_DIR}/example_data.json" ]; then
	echo >&2 "example_data.csv already exists.  Aborting.";
	exit 1;
fi

if [[ ! -d $DATA_DIR ]]; then
	mkdir $DATA_DIR
fi

# Download spending data as example_data.json
curl "https://openprescribing.net/api/1.0/spending/?code=0212/&format=json" > $DATA_DIR/example_data.json
