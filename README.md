# Bacteria Genome Assembly

New Pipeline for Bacteria Genome Assembly based on snakemake.
This Pipeline is currently designed for BGISEQ PE100 WGS data. As for other platforms or strategies, please write me an issue and I will try to adjust the pipeline for more.hi

## Software being used

- cOMG/OAs1 
- spades
- sspace
- Barrnap
- GeneMark-S 2

## Outline for the Pipe

- Data Quality Control with cOMG (Based on the raw data sequenced by BGISEQ)
- Efficient Assembly by SPAdes
- Gap Closer by SSPACE
- Barrnap to predict rRNA gene
- Gene Prediction by GeneMark-S 2

## Reference Article

- Fang, C., et al. (2018). "Assessment of the cPAS-based BGISEQ-500 platform for metagenomic sequencing." Gigascience 7(3): gix133-gix133.
- Lapidus A., Antipov D., Bankevich A., Gurevich A., Korobeynikov A., Nurk S., Prjibelski A., Safonova Y., Vasilinetc I., Pevzner P. A. New Frontiers of Genome Assembly with SPAdes 3.0.    (poster), 2014
- Bankevich A., Nurk S., Antipov D., Gurevich A., Dvorkin M., Kulikov A. S., Lesin V., Nikolenko S., Pham S., Prjibelski A., Pyshkin A., Sirotkin A., Vyahhi N., Tesler G., Alekseyev M. A., Pevzner P. A. SPAdes: A New Genome Assembly Algorithm and Its Applications to Single-Cell Sequencing.    Journal of Computational Biology, 2012
- Boetzer, M., et al. (2011). "Scaffolding pre-assembled contigs using SSPACE." Bioinformatics 27(4): 578-579.
- Barrnap: Manuscript under preparation.
- Lomsadze, A., et al. (2018). "Modeling leaderless transcription and atypical genes results in more accurate gene prediction in prokaryotes." Genome Res 28(7): 1079-1089.
