#Create the data frame
a <- c("Golden Gene1", "Unwanted region1", "Golden Gene2", "Unwanted region2", "Golden Gene3")
b <- c(82, 100, 91, 97.5, 64.6)
c <- c( 3.707, 53.142, 4.274, 72.666, 2.474)
coverage <- data.frame(type=a,
                       breadth=b,
                       meandepth=c)
coverage

plot(b,c, main="Sequencing Coverage for the target pane",
     xlab="Breadth of coverage (%)", ylab="Mean Depth of coverage (X)",
     col=c("blue","red"), las=1)
legend("topleft", legend=c("Golden Gene", "Unwanted Region"), col=c("blue", "red"), pch=19, cex=0.8)
