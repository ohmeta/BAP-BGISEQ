# The Idea of the Structure of the Entire Pipeline

## Sample File

For parallel working of the assembly, the sample file will be designed as the following:

Strain | Path | Library Name
--- | --- | ---
strain1 | /path/to/the/chip/ | library_name

One should be noted that the strategy of the sequencing (PE/SE) and the insert size will be needed in config.yaml  

The sample file will be better if saved as a tsv file.  

## Config.yaml

The following config will be needed in config.yaml:  
Take BGISEQ-500 PE100 as an example:  

```{text}
samples: samples.tsv  
params:  
    strategy:"PE"
    insert_size:"230"
    phred: 33
    qc:
        mlen: 30
        seedOA: 0.9
        fragOA: 0.8
    spades:
        threads: 4
        max_mem: 10
        kmer: "21,33,49,55"
        careful: "y"  
    barrnap:
        threads: 1
    genemark:
        threads: 1


```
