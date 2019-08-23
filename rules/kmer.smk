rule kmer_stat:
    input:
        clean_list=os.path.join(config["result"]["clean"],"clean.lst")
    output:
        png=expand(os.path.join(config["result"]["kmer"],"kmer_{data}.png"),kmer=["300M","32x"]),
        svg=expand(temp(os.path.join(config["result"]["kmer"],"kmer_{data}.svg")),kmer=["300M","32x"])
    log:
        expand(os.path.join(config["result"]["kmer"],"kmer_{data}.log",kmer=["300M","32x"])
    threads:1
    shell:
        '''
        DrawKmerStat.pl -g 300 -s 50 -o {config["result"]["kmer"]}/kmer_300M -l {input} >{log[0]}
        DrawKmerStat.pl -g 60 -s 50 -o {config["result"]["kmer"]}/kmer_32x -l {input} >{log[1]}
        convert -density 64 {output.svg[0]} {output.png[0]}
        convert -density 64 {output.svg[1]} {output.png[0]}
        '''

rule sub_sample:
    input:
        clean_lst=rule.kmer_stat.input,
        log=rule.kmer_stat.log,
    output:
        read=expand(os.path.join(config["result"]["clean"],{sample}_clean_100x{read}.fq.gz),read=["_1","_2"] if config["params"]["strategy"] == "PE" else "")
    threads:1
    shell:
        '''
        python genome_size.py {input.clean_list} {input.log[0]},{input.log[1]}