docker run -d -e PASSWORD=1234 -v ~/Documents/:/home/rstudio/projects/ -p 3838:3838 -p 8787:8787 -p 80:80 -p 4321:4321 -p 4870:4870 randomnik_blog:latest