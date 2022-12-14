#!/bin/bash

#Change to current working directory
cd ${HOME}/Hsu-Rotation/data

#Add conda environment to the path
export PATH="${HOME}/miniconda3/envs/plb812/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/miniconda3/envs/plb812/lib:${LD_LIBRARY_PATH}"

#papers="cell-2016 pnas-2022"
papers="pnas-2022"

for paper in $papers
do

	cd ${paper}

	#Extract SRR ids
	#cat runinfo.csv | cut -f 1 -d , | grep SRR > runids.txt
	sra_list=$(tr "\n" " " < runids.txt)
	
	for sra in $sra_list
	do
		cd $sra
		mv *.fastq ../raw/
		rm *.sra
		cd ..
		rmdir $sra
	done

	cd ..

done
