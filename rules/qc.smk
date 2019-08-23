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
            reads=expand(os.path.join(config["results"]["clean"], "{{sample}}.clean{read}.fq.gz"),read=['_1','_2'] if config['strategy'] == "PE" else ""),
            fqcheck=expand(os.path.join(config["results"]["clean"], "{{sample}}.clean{read}.fqcheck"),read=['_1','_2'] if config['strategy'] == "PE" else ""),
            clean_list=os.path.join(config["results"]["clean"],"clean.lst"),
            tmp=expand(temp(os.path.join(config["results"]["clean"], "{{sample}}.tmp{read}.fq.gz")),read=['_1','_2'] if config['strategy'] == "PE" else "")
        
        threads:1
        run:
            if config["params"]["strategy"] == "PE":
                shell("zcat {input[0]}|fastx_trimmer -f 1 -l 100 -z -o {output.tmp[0]}")
                shell("zcat {input[1]}|fastx_trimmer -f 1 -l 100 -z -o {output.tmp[1]}")
                shell("fastp -i {output.tmp[0]} -o {output.reads[0]} -I {output.tmp[1]} -O {output.reads[1]} -u 40 -n 10 -q 20 -w 1")
                shell("seqtk fqchk -q 20 {output.reads[0]} > {output.fqcheck[0]; seqtk fqchk -q 20 {output.reads[1]} >{output.fqcheck[1]}")
                shell("echo -e \"{output.reads[0]}\n{output.reads[1]}\n\" > {output.clean_list}")
            elif config["params"]["strategy"] == "SE":
                shell("zcat {input[0]}|fastx_trimmer -f 1 -l 100 -z -o {output.tmp[0]}")
                shell("fastp -i {output.tmp[0]} -o {reads[0]}-u 40 -n 10 -q 20 -w 1")
                shell("seqtk fqchk -q 20 {output.reads[0]} >{output.fqcheck[0]}")
                shell("echo -e \"{output.reads[0]}\n\" > {output.clean_list}")

elif config["params"]["qc"] == "trimmomatic":
    rule trimmomatic-qc:
        input:
            unpack(raw_seq)
        output:
            reads=expand(os.path.join(config["results"]["clean"], "{{sample}}.clean{read}.fq.gz"),read=['_1','_2','_single'] if config["params]["strategy"] == "PE" else ""),
            fqcheck=expand(os.path.join(config["results"]["clean"], "{{sample}}.clean{read}.fqcheck"),read=['_1','_2'] if config['strategy'] == "PE" else ""),
            clean_list=os.path.join(config["results"]["clean"],"clean.lst"),
            tmp=expand(temp(os.path.join(config["result"]["clean"],"{{sample}}.clean_single{read}.fq.gz")).read=['_1','_2'] if config["params"]["strategy"] ==PE else ""),
            tmp_fq=temp(os.path.join(config["results"]["clean"],"{{sample}}.clean_single.fq"))
        threads:1
        run:
            if config["params"]["strategy"] == "PE":
                shell("trimmomatic PE -threads 1 -phred33 {input[0]} {input[1]} {output.reads[0]} {output.reads[1]} {output.tmp[0]} {output.tmp[1]} SLIDINGWINDOW:10:20 MINLEN:30 CROP:100 TRAILING:20")
                shell("zcat {output.tmp[0]} {output.tmp[1]} >{output.tmp_fq} && gzip {output.tmp_fq}")
                shell("seqtk fqchk -q 20 {output.reads[0]} > {output.fqcheck[0]; seqtk fqchk -q 20 {output.reads[1]} >{output.fqcheck[1]}")
                shell('echo -e "{output.reads[0]}\n{output.reads[1]}\n{output.reads[2]\n" > {output.clean_list}')
            elif config["params"]["strategy"] == "SE":
                shell("trimmomatic SE -threads 1 -phred33 {input[0]} {output.reads[0]} SLIDINGWINDOW:10:20 MINLEN:30 CROP:100 TRAILING:20")
                shell("seqtk fqchk -q 20 {output.reads[0]} > {output.fqcheck[0]")
                shell('echo -e \"{output.reads[0]}\n\" > {output.clean_list}')

elif config["params"]["qc"] == "OAs1":

