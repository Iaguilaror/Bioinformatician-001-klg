MKSHELL=/bin/bash

## Ejecutar mk-coverage_calculator
results/%.tsv.coverage:Q: data/%.tsv
	set -x
	mkdir -p $(dirname $target)
	{
	#Calculate breadth  of coverage (bcov) for every requested locus
        #Calculate covb for each genomic region
	awk '{ print $4 }' $prereq | sed -n '1!p' | sort -u
	set -- $(awk '{ print $4 }' $prereq | sed -n '1!p' | sort -u)
	covbGG1=$(grep $1 $prereq | awk '$6 > 1 {print ;}' | wc -l)
	covbUR1=$(grep $2 $prereq | awk '$6 > 1 {print ;}' | wc -l)
	covbGG2=$(grep $3 $prereq | awk '$6 > 1 {print ;}' | wc -l) 
	covbUR2=$(grep $4 $prereq | awk '$6 > 1 {print ;}' | wc -l)
	covbGG3=$(grep $5 $prereq | awk '$6 > 1 {print ;}' | wc -l)
	#Calculate regl for each genomic region
        reglGG1=$(grep $1 $prereq | wc -l)
        reglUR1=$(grep $2 $prereq | wc -l)
        reglGG2=$(grep $3 $prereq | wc -l)
        reglUR2=$(grep $4 $prereq | wc -l)
        reglGG3=$(grep $5 $prereq | wc -l)
        #Calculate bcov for each genomic region
        bcovGG1=$(echo "scale=3;$covbGG1/$reglGG1*100" | bc)
        bcovUR1=$(echo "scale=3;$covbUR1/$reglUR1*100" | bc)
        bcovGG2=$(echo "scale=3;$covbGG2/$reglGG2*100" | bc)
        bcovUR2=$(echo "scale=3;$covbUR2/$reglUR2*100" | bc)
        bcovGG3=$(echo "scale=3;$covbGG3/$reglGG3*100" | bc)
        echo "The bcov for the locus $1 is $bcovGG1"
        echo "The bcov for the locus $2 is $bcovUR1"
        echo "The bcov for the locus $3 is $bcovGG2"
        echo "The bcov for the locus $4 is $bcovUR2"
        echo "The bcov for the locus $5 is $bcovGG3"
	#Calculate mean depth of coverage (mdcov) for every requested locus
	#Calculate seqb for each genomic region
        seqbGG1=$(grep $1 $prereq | awk '$6 > 1 {sum += $6} END {print sum}')
        seqbUR1=$(grep $2 $prereq | awk '$6 > 1 {sum += $6} END {print sum}')
        seqbGG2=$(grep $3 $prereq | awk '$6 > 1 {sum += $6} END {print sum}')
        seqbUR2=$(grep $4 $prereq | awk '$6 > 1 {sum += $6} END {print sum}')
        seqbGG3=$(grep $5 $prereq | awk '$6 > 1 {sum += $6} END {print sum}')
        #Calculate mdcov for each genomic region
        mdcovGG1=$(echo "scale=3;$seqbGG1/$covbGG1" | bc)
        mdcovUR1=$(echo "scale=3;$seqbUR1/$covbUR1" | bc)
        mdcovGG2=$(echo "scale=3;$seqbGG2/$covbGG2" | bc)
        mdcovUR2=$(echo "scale=3;$seqbUR2/$covbUR2" | bc)
        mdcovGG3=$(echo "scale=3;$seqbGG3/$covbGG3" | bc)
        echo "The mdcov for the locus GOLDEN_GENE1 is $mdcovGG1"
        echo "The mdcov for the locus UNWANTED_REGION1 is $mdcovUR1"
        echo "The mdcov for the locus GOLDEN_GENE2 is $mdcovGG2"
        echo "The mdcov for the locus UNWANTED_REGION2 is $mdcovUR2"
        echo "The mdcov for the locus GOLDEN_GENE3 is $mdcovGG3"
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
	} > $target.build \
	&& mv $target.build $target
