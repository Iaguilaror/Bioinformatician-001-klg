#Reading arguments from shell
args = commandArgs(trailingOnly=TRUE)
#FOR DEBBUGGING ONLY
#Reading the entry values for the paths to input file and output file.
#args[1] is the path to the input file with the calculations .tsv
#args[2] is the path to the output file with the .pdf file.
#args[1] <- "results/raw_coverages_by_base.tsv.coverage"
#args[2] <- "results/raw_coverages_by_base.tsv.coverage.pdf"
#Import .tsv file as dataset 
coverage_calculations <- read.table(file= args[1], sep= '\t', header = TRUE)
#Plot coverage calculations saved as a .pdf file
pdf(file= args[2])
with(coverage_calculations,plot(bcov,mdcov, main="Sequencing Coverage for the target panel", xlab="Breadth of coverage (%)", ylab="Mean Depth of coverage (x)", col=c("blue","red"), las=1))
legend("topleft", legend=c("Golden Gene", "Unwanted Region"), col=c("blue", "red"), pch=19, cex=0.6)
dev.off()
