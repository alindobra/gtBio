# View the table (first 200,000 rows)
View(OrderBy(Read(GSE46691), dsc(Score), limit=200000))