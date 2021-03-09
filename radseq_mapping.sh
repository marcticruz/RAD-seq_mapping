#!/bin/bash

cd /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/  

bwa index -p /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/bwa/gac /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/pika_genome.fasta &> /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/bwa/bwa_index.oe

cd /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/  

for file in *UAM*
do 
	bwa mem -M /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/bwa/gac $file -o /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/raw/stacks.ref/teste.ref/$file.sam
done 

cd /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/raw/stacks.ref/teste.ref/

for sam_file in *.sam 
do 
	samtools view -b $sam_file -o ./alignments.bwa/$sam_file.bam 
done  

cd /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/raw/stacks.ref/teste.ref/alignments.bwa/
 

rename 's/\.sam\.bam/\.bam/' * 

for bam_file in *.bam
do     
	num=${bam_file//[^0-9]/} 
	pstacks -f /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/raw/stacks.ref/teste.ref/alignments.bwa/$bam_file -p 14 -i $num -o ./ &> $bam_file.log 
done    
  
for bam_file in *.bam  
do 
        samtools sort $bam_file -o ./bam_sorted/$bam_file.sorted --reference /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/pika_genome.fasta  --threads 20
done  

cd /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/raw/stacks.ref/teste.ref/alignments.bwa/bam_sorted/

rename 's/.bam.sorted/.bam/' *  

ref_map.pl --samples /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/raw/stacks.ref/teste.ref/alignments.bwa/bam_sorted/ --popmap /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/popmap.tsv -o /mnt/1f047a13-d132-4034-8d0e-b99fe08752cb/marcos/eaglesummit_radsaq/alignments/cleaned/genome/info/raw/stacks.ref/teste.ref/alignments.bwa/stacks.bwa/ -T 20
