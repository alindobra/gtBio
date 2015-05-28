# Count the top 200,000 most correlated pairs
# over the entire data (1.4M X 1.4M)
# RTime: 6071s

library(gtStats)

data <- Read(GSE46691)

charts <- GroupBy(data, group=ID,
                 chart = LineChart(inputs=c(Sample$GetID(), Score), length=545), fragment.size=1024)


covariance <- BigMatrix(charts, inputs = c(ID, chart), outputs = c(x,y, covar), block=1024);

ordering <- OrderBy(covariance, dsc(covar), limit = 200000)
 
View(ordering)