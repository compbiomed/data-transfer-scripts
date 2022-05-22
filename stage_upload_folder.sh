#!/bin/bash

# Stage a folder of symlinks to local files to facilitate an upload
# Adam Gower

# Parse command-line arguments
eval set -- "$(
  getopt --options=i:o: \
         --longoptions=input-file:,output-path: \
         --name "$0" -- "$@"
)"

while true
do
  case "$1" in
    -i|--input-file)
      inputFile="$(readlink --canonicalize "$2")"
      shift 2 ;;
    -o|--output-path)
      outputPath="$(readlink --canonicalize "$2")"
      shift 2 ;;
    --)
      shift
      break ;;
    *)
      echo "Internal error"
      exit 1 ;;
  esac
done

# If S3 bucket is not specified, print a usage statement and exit
if [[ "${inputFile}" == "" || "${outputPath}" == "" ]]
then
  echo    "Usage:"
  echo    "  bash stage_upload_folder.sh [options]"
  echo    "       -i|--input-file [Path to input file]"
  echo    "       -o|--output-path [Path to write output]"
  echo    "Options:"
  echo    "  -i, --input-file    Path to two-column TSV input file:"
  echo    "                      column 1 = full paths to local files/folders"
  echo    "                      column 2 = full path of remote copy"
  echo    "  -o, --output-path   Path where output will be written"
  echo    "                      (will be created if it does not exist)"
else
  if [[ ! -e "${inputFile}" ]]
  then
    echo "File '${inputFile}' does not exist; terminating."
  else
    # Create output path
    mkdir --verbose --parents --mode=2750 "${outputPath}"/
    # Iterate over each row of the input file, staging a symlink to each target
    # Note: any CR characters (i.e., in files created in Windows)
    #       are removed from input file if present
    while IFS=$'\t' read -a input
    do
      localPath="$(readlink --canonicalize "${input[0]}")"
      remotePath="${input[1]}"
      symlinkPath="${outputPath}/${remotePath}"
      mkdir --verbose --parents --mode=2750 "$(dirname "${symlinkPath}")"
      ln -sv "${localPath}" "${symlinkPath}"
    done < <(cat "${inputFile}" | tr -d '\r')
  fi
fi
