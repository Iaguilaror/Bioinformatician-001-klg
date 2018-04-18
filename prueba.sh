#!/bin/bash

#Determine the regions of interest
	cut -f4 data/raw_coverages_by_base.tsv | sed -n '1!p' |sort -u > regions_of_interest.txt
	while  read REGION ;
	do
	echo "I'm calculating the coverage values for $REGION";
	done < regions_of_interest.txt
        #Calculate breadth  of coverage (bcov) for every requested locus
        #Calculate covb for each genomic region
	while read REGION ;
	do
	grep $REGION data/raw_coverages_by_base.tsv | awk '$6 > 1 {print ;}' | wc -l
	done < regions_of_interest.txt
	#Calculate regl for each genomic region
        while read REGION ;
	do
	grep $REGION data/raw_coverages_by_base.tsv | wc -l
	done < regions_of_interest.txt
	#Calculate bcov for each genomic region
	bcovGG1=$(echo "scale=3;$covbGG1/$reglGG1*100" | bc)
        #Calculate mean depth of coverage (mdcov) for every requested locus
        #Calculate seqb for each genomic region
        seqbGG1=$(grep $1 $prereq | awk '$6 > 1 {sum += $6} END {print sum}')
        #Calculate mdcov for each genomic region
        mdcovGG1=$(echo "scale=3;$seqbGG1/$covbGG1" | bc)
        #Calculate panel's breadth  of coverage (bcov) for all the loci of interest (Golden Genes)
        #Calculate covb for all the loci of interest (Golden Genes)
        covbGGs=$(grep ".*GENE.*" $prereq | awk '$6 > 1 {print ;}' | wc -l)
        #Calculate regl for all the loci of interest (Golden Genes)
        reglGGs=$(grep ".*GENE.*" $prereq | wc -l)
        #Calculate bcov for all the loci of interest (Golden Genes)
        bcovGGs=$(echo "scale=3;$covbGGs/$reglGGs*100" | bc)
        echo "The bcov for the loci of interes (Golden Genes) is $bcovGGs"
        #Calculate panel's mean depth of coverage (mdcov) for all the loci of interest (Golden Genes)
        #Calculate covb for all the loci of interest (Golden Genes)
        covbGGs=$(grep ".*GENE.*" $prereq | awk '$6 > 1 {print ;}' | wc -l)
        #Calculate regl for all the loci of interest (Golden Genes)
        reglGGs=$(grep ".*GENE.*" $prereq | wc -l)
        #Calculate bcov for all the loci of interest (Golden Genes)
        bcovGGs=$(echo "scale=3;$covbGGs/$reglGGs*100" | bc)
        echo "The bcov for the loci of interest (Golden Genes) is $bcovGGs"
        #Calculate panel's mean depth of coverage (mdcov) for all the loci of interest (Golden Genes)
        #Calculate seqb for all the loci of interest (Golden Genes)
        seqbGGs=$(grep ".*GENE.*" $prereq | awk '$6 > 1 {sum += $6} END {print sum}')
        #Calculate mdcob for all the loci of interest (Golden Genes)
        mdcovGGs=$(echo "scale=3;$seqbGGs/$covbGGs" | bc)
        #Calculate bcov for all the loci of interest (Golden Genes)
        bcovGGs=$(echo "scale=3;$covbGGs/$reglGGs*100" | bc)
        echo "The mdcov for the loci of interest (Golden Genes) is $mdcovGGs"
