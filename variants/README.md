# A directory for variants

For Diversity Outbred (DO) mice, or mice that segregate similar variation,
you need to download a database of variation in the 
Collaborative Cross/DO founders. Such a database has been 
compiled by Karl Broman for the case of SNP association mapping
in his `R/qtl2` package 
(see [this link](https://kbroman.org/qtl2/assets/vignettes/user_guide.html)). 
You can download the file `cc_variants.sqlite`
[here](https://doi.org/10.6084/m9.figshare.5280229.v3). Note that 
this is approximately 3GB in size. To download this file automatically
within R you can execute the command
`download.file("https://ndownloader.figshare.com/files/18533342", "cc_variants.sqlite")`.

