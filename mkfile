MKSHELL=/bin/bash

#Generate plot in .pdf format
results/%.coverage.pdf:: results/%.tsv.coverage
	set -x
        mkdir -p $(dirname $target)
	Rscript --vanilla bin/plotter.R $prereq $target.build \
	&& mv $target.build $target

## Ejecutar mk-coverage_calculator
results/%.tsv.coverage:: data/%.tsv results/%.regions_of_interest.txt
	set -x
	mkdir -p $(dirname $target)
	{
	#Calculate the parameters needed to obtain breadth of coverage and mean depth of coverage, for each region of interest.
	echo "REGIONS OF INTEREST	bcov	mdcov"
	while  read REGION ;
	do
	COVB=$(grep $REGION data/$stem.tsv | awk '$6 > 0 {print ;}' | wc -l)
	REGL=$(grep $REGION data/$stem.tsv  | wc -l)
	BCOV=$(echo "scale=3;$COVB/$REGL*100" | bc)
	SEQB=$(grep $REGION data/$stem.tsv  | awk '$6 > 0 {sum += $6} END {print sum}')
	MDCOV=$(echo "scale=3;$SEQB/$COVB" | bc)
	echo "$REGION	$BCOV	$MDCOV";
	done < results/$stem.regions_of_interest.txt
	#Calculate panel's breadth of coverage (bcov) for all the loci of interest (Golden Genes)
	#COVBG=$(grep ".*GENE.*" data/$stem.tsv  | awk '$6 > 0 {print ;}' | wc -l)
	#REGLG=$(grep ".*GENE.*" data/$stem.tsv  | wc -l)
	#BCOVG=$(echo "scale=3;$COVBG/$REGLG*100" | bc)
	#Calculate panel's mean depth of coverage (mdcov) for all the loci of interest (Golden Genes)
	#SEQBG=$(grep ".*GENE.*" data/$stem.tsv  | awk '$6 > 0 {sum += $6} END {print sum}')
	#MDCOVG=$(echo "scale=3;$SEQBG/$COVBG" | bc)
	#echo "The panel's breath of coverage (bcov) is $BCOVG and the panel's mean depth of coverage (mdcov) is $MDCOVG"
	} > $target.build \
	&& mv $target.build $target

##Commands to identify regions of interest.
results/%.regions_of_interest.txt:: data/%.tsv
        set -x
        mkdir -p $(dirname $target)
	#Determine the regions of interest
	cut -f4 $prereq | sed -n '1!p' |sort -u > $target.build \
        && mv $target.build $target

all:V:
	bin/create_targets | xargs mk

clean:V:
	rm results/*.regions_of_interest.txt

