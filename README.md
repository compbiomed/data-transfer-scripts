# Scripts for facilitating or carrying out data transfers

### `stage_upload_folder.sh`

Usage:
```
  bash stage_upload_folder.sh [options]
       -i|--input-file [Path to input file]
       -o|--output-path [Path to write output]
```
Options:
```
  -i, --input-file    Path to two-column TSV input file:
                      column 1 = full paths to local files/folders
                      column 2 = full path of remote copy
  -o, --output-path   Path where output will be written
                      (will be created if it does not exist)
```
