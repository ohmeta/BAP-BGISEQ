# Bacteria Genome Assembly

New Pipeline for Bacteria Genome Assembly based on snakemake.

## Software being used

- cOMG/OAs1 <\br>
- spades  <\br>
- sspace  <\br>
- Barrnap <\br>
- GeneMark-S 2 <\br>

## Outline for the Pipe

- Data Quality Control with cOMG (Based on the raw data sequenced by BGISEQ) <\br>
- Efficient Assembly by SPAdes <\br>
- Gap Closer by SSPACE <\br>
- Barrnap to predict rRNA gene <\br>
- Gene Prediction by GeneMark-S 2 <\br>

## Reference Article

- Fang, C., et al. (2018). "Assessment of the cPAS-based BGISEQ-500 platform for metagenomic sequencing." Gigascience 7(3): gix133-gix133. <\br>
- Lapidus A., Antipov D., Bankevich A., Gurevich A., Korobeynikov A., Nurk S., Prjibelski A., Safonova Y., Vasilinetc I., Pevzner P. A. New Frontiers of Genome Assembly with SPAdes 3.0.    (poster), 2014 <\br>
- Bankevich A., Nurk S., Antipov D., Gurevich A., Dvorkin M., Kulikov A. S., Lesin V., Nikolenko S., Pham S., Prjibelski A., Pyshkin A., Sirotkin A., Vyahhi N., Tesler G., Alekseyev M. A., Pevzner P. A. SPAdes: A New Genome Assembly Algorithm and Its Applications to Single-Cell Sequencing.    Journal of Computational Biology, 2012 <\br>
- Boetzer, M., et al. (2011). "Scaffolding pre-assembled contigs using SSPACE." Bioinformatics 27(4): 578-579. <\br>
- Barrnap: Manuscript under preparation. <\br>
- Lomsadze, A., et al. (2018). "Modeling leaderless transcription and atypical genes results in more accurate gene prediction in prokaryotes." Genome Res 28(7): 1079-1089. <\br>
