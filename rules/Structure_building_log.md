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

## Software Requirement and Install

Most softwares of the pipelien could be installed by conda (BioConda)  
Including the following:  

```{text}
fastp (Trimmomatic/OAs1)
SPAdes
sspace
QUAST

```
  
Those softwares which could not be installed by conda are stored in the script/software, including:  
cOMG/OAs1
GeneMark-S2  

### Quality Control Process

OAs1 is an excutive script for quality control developed for metafgenomic sequencing data. Since the bacterial genomes are using the same library-generating strategy as metagenomes, OAs1 here is to be used as a QC tools.  
Trimmomatic is a software used to do the quality control job for Illumina sequencing data. However, as a general QC tool for NGS data, Trimmomatic here is to be used as a handy tool for filtering. Please Notice that adaptors of BGISEQ sequencing data have been already removed before data delievery.  
fastp with fastx toolkit and seqtk is able to reproduce the original unpublished readfq quality filter software. Besides, it's quick and able to simulate the function of Trimmomatic. The most attractive place is that it's super quick because it is written by C++. Therefore, It will be the final choice of the premier QC programe of the pipeline.

Here is a consideration about the problem of Kmer analysis. When using Jellyfish as the tool to analyse the kmer composition of the sequencing reads, it seems that the peak is difficult to locate. The same as the GCE. I noticed the original KmerStat, writen by a former colleague of BGI, allows to use certain part of the data to create a kmer frequency figure.  
Kmergenie is much easier to use. However, I will say that KmerStat is more suitable for my circumstance. Also because I already had the source code of the kmerstat.
Well, maybe it's time to upload it to the github.  

### Assembler  

SPAdes will be the assembler used in this pipeline. We used to use SOAPdenovo(63mer) as the assembler in our pipeline, but the iteration of kmer needed to be done manually. Therefore, SPAdes, idba-un and megahit became our alternative options. SPAdes seems to be more outstanding in small genomes according to several papers. And here is our choice.  
Well, I will say idba is similar to SPAdes. Auto selection of the k value is much quicker.  
Here will import 3 assemblers: the traditional SOAPdenovo2 and two automatic iterative assemblers, idba and SPAdes.

### Scaffolding  

SSPACE is a widely used software in scaffolding and gap filling. I am not knowing if I have to use this program with SPAdes since SPAdes has already a great pipeline with read correction and scaffolding.  

### Gene Prediction

GeneMark-S2 is a handful software for gene prediction. It's a newer version compared to the original pipeline. Since the variety of research demands, this pipeline only provides to functions including rRNA and gene prediction for quick service. For other functions, it's better to do it on your own instead of using a general one.  
Specify your own Research Purpose before taking the next step.  

Wish you all have a wonderful journey in the world of Bacteria.  
