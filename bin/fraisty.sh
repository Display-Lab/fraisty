#!/usr/bin/env bash

# Check if R is installed
command -v Rscript 1> /dev/null 2>&1 || \
  { echo >&2 "Rscript required but it's not installed.  Aborting."; exit 1; }

# Usage message
read -r -d '' USE_MSG <<'HEREDOC'
Usage:
  fraisty.sh --help
  fraisty.sh --data demo-data.csv --spek demo-spek.json
  fraisty.sh --spek demo-spek.json

Fraisty reads the data from stdin or provided file path.  Unless output file
is specified, it prints a report to stdout.

Options:
  -h | --help   print help and exit
  -s | --spek   path to spek file (default to stdin)
  -d | --data   path to data file
HEREDOC

# Parse args
PARAMS=()
while (( "$#" )); do
  case "$1" in
    -h|--help)
      echo "${USE_MSG}"
      exit 0
      ;;
    -d|--data)
      DATA_FILE="'${2}'"
      shift
      shift
      ;;
    -s|--spek)
      SPEK_FILE="'${2}'"
      shift
      shift
      ;;
    --) # end argument parsing if no argument is left
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Aborting: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS+=("${1}")
      shift
      ;;
  esac
done

INPUT_ARGS="spek_path=${SPEK_FILE:-NULL},\
  data_path=${DATA_FILE:-NULL}"

EXPR="fraisty::main(${INPUT_ARGS})"
Rscript --vanilla --default-packages=fraisty -e "${EXPR}"
