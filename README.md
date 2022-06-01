# Scripts for facilitating or carrying out data transfers

### `stage_upload_folder.sh`

This script creates a staging folder of symlinks that point to local files in order to facilitate an upload of those files with a given directory structure / file naming convention.

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

### `retrieve_SRR_fastq_files.qsub`

This script is a wrapper for the [`fastq-dump`](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc&f=fastq-dump) utility of the [SRA Toolkit](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc). It retrieves sequencing reads in FASTQ format (gzipped) from the NCBI Sequencing Read Archive (SRA) for a given set of SRR accession numbers, provided in a newline-delimited input file.  It creates files named with the SRR accession and the sequence (read/mate) number (e.g., `SRRnnnnnnnn_1.fastq.gz`, `SRRnnnnnnnn_2.fastq.gz`, etc.)

It is intended for use with a cluster running [Grid Engine](https://en.wikipedia.org/wiki/Oracle_Grid_Engine) and [Environment Modules](http://modules.sourceforge.net/).  It may also be run as a standalone bash script using `bash` instead of `qsub`.

Usage:
```
  qsub [qsub flags] retrieve_SRR_fastq_files.qsub
       -i|--input-file [input filename]
       -o|--output-path [path to FASTQ files]
```
Options:
```
  -i, --input-file      Path to newline-separated file containing SRR accessions
                        (e.g., download from 'Accession List' in SRA Run Selector)
  -o, --output-path     Path where FASTQ files will be written 
                        (will be created if it does not exist)
```
