# This program computes the top most interesting
# IDs and then compare them using the Pearson correlation
# The interestingness measure is Variance

library(gtStats);

# find the interesting IDs
data <- Read(GSE46691)
gby <- GroupBy(data, 
               group=ID, 
               mean=Mean(Score),
               mean2=Mean(Score*Score)
              );
gnr <- Generate(gby, var=mean2-mean*mean);

#interesting <- OrderBy(gnr, dsc(var), limit=100000)
interesting <- gnr[var >= 1.0]; ## keep only IDs with variance over 1

# form the histories of the interesting data and 
# find the most corrlated pairs

jn <- Join(Read(GSE46691), ID, interesting, ID)

charts <- GroupBy(jn, group=ID,
                 chart = LineChart(inputs=c(Sample$GetID(), Score), length=545), fragment.size=1024)


covariance <- BigMatrix(charts, inputs = c(ID, chart), outputs = c(x,y, covar), block=1024, diag=FALSE);

ordering <- OrderBy(covariance, dsc(covar), limit = 200000)
 
View(ordering)