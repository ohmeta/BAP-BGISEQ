def raw_seq(wildcards,strategy):
    if strategy == "PE":
        return [sp.get_sample_id(sam_mat,wildcards,"fq1"),sp.get_sample_id(sam_mat,wildcards,"fq2")]
    elif strategy == "SE":
        return [sp.get_sample_id(sam_mat,wildcards,"fq")]




if config["params"]["qc"] == "fastp":
    rule fastp-qc:
        input:
            unpack(raw_seq)

        output:
            reads=expand(temp(os.path.join(config["results"]["clean"], "{{sample}}.clean{read}.fq.gz")),read=['_1','_2'] if config['strategy'] == "PE" else ""),
            fqcheck=expand(temp(os.path.join(config["results"]["clean"], "{{sample}}.clean{read}.fqcheck")),read=['_1','_2'] if config['strategy'] == "PE" else "")
        temp:
            tmp=expand(temp(os.path.join(config["results"]["clean"], "{{sample}}.tmp{read}.fq.gz")),read=['_1','_2'] if config['strategy'] == "PE" else "")
        params:

        run:
            if config["params"]["strategy"] == "PE":
                shell("zcat {input[0]}|fastx_trimmer -f 1 -l 100 -z -o {temp.tmp[0]}")
                shell("zcat {input[1]}|fastx_trimmer -f 1 -l 100 -z -o {temp.tmp[1]}")
                shell("fastp -i {temp.tmp[0]} -o {output.reads[0]} -I {temp.tmp[1]} -O {output.reads[1]} -u 40 -n 10 -q 20 -w 1")
                shell("seqtk fqchk -q 20 {output.reads[0]} > {output.fqcheck[0]; seqtk fqchk -q 20 {output.reads[1]} >{output.fqcheck[1]}")
            elif config["params"]["strategy"] == "SE":
                shell("zcat {input[0]}|fastx_trimmer -f 1 -l 100 -z -o {tmp[0]}")
                shell("fastp -i {tmp[0]} -o {reads[0]}-u 40 -n 10 -q 20 -w 1")
                shell("seqtk fqchk -q 20 {output.reads[0]} >{output.fqcheck[0]}")

rule kmer_stat:
    input:
        
            

