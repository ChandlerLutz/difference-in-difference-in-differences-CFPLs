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
