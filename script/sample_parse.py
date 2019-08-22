import sys,os
import pandas as pd

def parse_sample(sample_file,strategy):
    sam=pd.read_csv(sample_file,sep='\t').set_index('sample',drop=False)
    #sample_count=sam.shape()[0]
    sam_index=list(sam.index)
    if strategy == "PE":
        sam_fq=pd.DataFrame({'fq1':[],'fq2':[]})
        for sam_id in sam_index:
            r1=sam['path'][sam_id]+'/'+sam['library'][sam_id]+'_1.fq.gz'
            r2=sam['path'][sam_id]+'/'+sam['library'][sam_id]+'_2.fq.gz'
            if os.path.exists(r1) and os.path.exists(r2):
                tmp=pd.DataFrame({'fq1':[r1],'fq2':[r2]},index=[sam_id])
                sam_fq=sam_fq.append(tmp)
            else:
                print("%s\t Sequencing Data does not exsit." % sam_id)
    elif strategy=="SE":
        sam_fq=pd.DataFrame({'fq':[]})
        for sam_id in sam_index:
            r=sam['path'][sam_id]+'/'+sam['library'][sam_id]+'.fq.gz'
            if os.path.exists(r):
                tmp=pd.DataFrame({'fq':[r]})
                sam_fq=sam_fq.append(tmp)
            else:
                print("%s\t Sequencing Data does not exsit." % sam_id)
    else:
        print("Input Error!")
        sys.exit(0)
    return sam_fq

def get_sample_id(sample_df, wildcards, col): ##Copy from Jie Zhu's METAPI
    return sample_df.loc[wildcards.sample, [col]].dropna()[0]
    
file1=sys.argv[1]
print(parse_sample(file1,"PE"))

