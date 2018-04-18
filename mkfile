MKSHELL=/bin/bash

## Ejecutar mk-coverage_calculator
results/%.tsv.coverage:: data/%.tsv
	set -x
	mkdir -p $(dirname $target)
	{
	#Determine the regions of interest
	cut -f4 $prereq | sed -n '1!p' |sort -u > regions_of_interest.txt
	while  read REGION ;
	do
	COVB=$(grep $REGION $prereq | awk '$6 > 0 {print ;}' | wc -l)
	REGL=$(grep $REGION $prereq | wc -l)
	BCOV=$(echo "scale=3;$COVB/$REGL*100" | bc)
	SEQB=$(grep $REGION $prereq | awk '$6 > 0 {sum += $6} END {print sum}')
	MDCOV=$(echo "scale=3;$SEQB/$COVB" | bc)
	echo "$REGION $COVB $REGL $BCOV $MDCOV";
	done < regions_of_interest.txt
	#Calculate panel's mean depth of coverage (mdcov) for all the loci of interest (Golden Genes)
	COVBG=$(grep ".*GENE.*" $prereq | awk '$6 > 0 {print ;}' | wc -l)
	#Calculate regl for all the loci of interest (Golden Genes)
	REGLG=$(grep ".*GENE.*" $prereq | wc -l)
	#Calculate bcov for all the loci of interest (Golden Genes)
	BCOVG=$(echo "scale=3;$COVBG/$REGLG*100" | bc)
	#Calculate panel's mean depth of coverage (mdcov) for all the loci of interest (Golden Genes)
	#Calculate seqb for all the loci of interest (Golden Genes)
	SEQBG=$(grep ".*GENE.*" $prereq | awk '$6 > 0 {sum += $6} END {print sum}')
	#Calculate mdcov for all the loci of interest (Golden Genes)
	MDCOVG=$(echo "scale=3;$SEQBG/$COVBG" | bc)
	echo "The panel's breath of coverage (bcov) is $BCOVG and the panel's mean depth of coverage (mdcov) is $MDCOVG"
	} > $target.build \
	&& mv $target.build $target
