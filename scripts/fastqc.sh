#!/bin/bash
#BATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --job-name get_chip
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

	#Extract SRR ids
	#cat runinfo.csv | cut -f 1 -d , | grep SRR > runids.txt
	sra_list=$(tr "\n" " " < runids.txt)
	
	for sra in $sra_list
	do
		#Run fastqc quality testing
		fastqc -o ../../fastqc/raw_fastqc ${sra}.fastq
	done

	cd ..

done
