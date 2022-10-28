#!/bin/bash
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --job-name ik_trim
#SBATCH --output=%x-%j.SLURMout
#SBATCH --mail-type=ALL
#SBATCH --mail-user=kaufm202@msu.edu

#Change to current working directory
cd ${HOME}/Hsu-Rotation/data

#Add conda environment to the path
export PATH="${HOME}/miniconda3/envs/plb812/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/miniconda3/envs/plb812/lib:${LD_LIBRARY_PATH}"

papers="cell-2016 pnas-2022"

for paper in $papers
do

	cd ${paper}
	#mkdir trimmed
	
	#Extract SRR ids
	#cat runinfo.csv | cut -f 1 -d , | grep SRR > runids.txt
	sra_list=$(tr "\n" " " < runids.txt)
	
	for sra in $sra_list
	do
		#Trim the raw fastq files
		trimmomatic SE -phred33 ${sra}.fastq trimmed/${sra}_trimmed.fq.gz ILLUMINACLIP:/mnt/home/kaufm202/miniconda3/envs/plb812/share/trimmomatic-0.39-2/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:36
	done

	cd ..

done
