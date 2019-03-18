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

DATA_DIR=${SCRIPT_DIR}/../example_data

if [[ ! -d $DATA_DIR ]]; then
	mkdir $DATA_DIR
fi

# Download data from 10 months.

## Use -nc to avoid downloading the data multiple times
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/96/A7878A/2018_11_Nov.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/33/3EE982/2018_10_Oct.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/5C/FE61C4/2018_09_Sep.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/43/C6644B/2018_08_Aug.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/07/697711/2018_06_Jun.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/B0/B15E0B/2018_05_May.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/E3/801EA5/2018_04_Apr.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/6F/CE775A/2018_03_Mar.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/35/292E2A/2018_02_Feb.zip
wget -nc --directory-prefix=${DATA_DIR} https://files.digital.nhs.uk/11/1E8A59/2018_01_Jan.zip

## unzip ${DATA_DIR}/data.zip -d ${DATA_DIR}
unzip -n "${DATA_DIR}/*.zip" -d "${DATA_DIR}"

# Extract Methotrexatate tablet perscribing data.
MTX_FILE="${DATA_DIR}/mtx_pdpi_bnft.csv"

## (Over)write mtx file with write header
### Header is same as the raw data files
BNFT_HEADER=" SHA,PCT,PRACTICE,BNF CODE,BNF NAME                                    ,ITEMS  ,NIC        ,ACT COST   ,QUANTITY,PERIOD,"
echo "${BNFT_HEADER}" > ${MTX_FILE}

## Extract relevant rows and append to mtx file
echo "Extracting rows"
grep --no-filename -e 'Methotrexate_Tab' ${DATA_DIR}/*BNFT.CSV >> ${MTX_FILE}


# Synthesize Behavior Data
BEHAVIOR_FILE="${DATA_DIR}/mtx_behavior.csv"
echo "Processing Data"
Rscript --vanilla "${SCRIPT_DIR}/munge_mtx_behavior.R" "${MTX_FILE}" > "${BEHAVIOR_FILE}"

echo "End of Line."

