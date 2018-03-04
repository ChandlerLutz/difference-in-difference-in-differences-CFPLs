## c:/Dropbox/PublicData/differences-in-differences-in-differences/index_render.R

##    Chandler Lutz
##    Questions/comments: cl.eco@cbs.dk
##    $Revisions:      1.0.0     $Date:  2018-03-04

##Render index.Rmd into both html and pdf documents
rmarkdown::render("index.Rmd",
                  output_format = "html_document",
                  output_file = "index.html")
rmarkdown::render("index.Rmd",
                  output_format = "pdf_document",
                  output_file = "CFPLs_DDD.pdf")
knitr::knit("index.Rmd",
            tangle = TRUE,
            output = "CFPLs_DDD.R")
##Delete knitr and rmarkdown output from .R file
R_file <- readLines("CFPLs_DDD.R")
R_file <- R_file[3:length(R_file)]
write(R_file, file = "CFPLs_DDD.R")
