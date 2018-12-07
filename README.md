# SVAC-LVM-tutorial

This repository provides the material for a workshop on latent variable modeling (LVM) applied to human-coded data of reports on sexual violence in armed conflict ([SVAC](http://www.sexualviolencedata.org/)). This empirical work forms part of  ongoing research by [Ragnhild Nordås](https://ragnhildnordas.wordpress.com/) and [Jule Krüger](http://julekrueger.net/), with advice from [Christopher Fariss](http://cfariss.com/).

The LVM approach we follow here builds on [Schnakenberg and Fariss (2014)](https://www.cambridge.org/core/journals/political-science-research-and-methods/article/dynamic-patterns-of-human-rights-practices/40FCA9B94AD6A616FB15EA04B8EB1997), whose model is an extension of [Treier and Jackman (2008)](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1540-5907.2007.00308.x).

We will be using the free and open-source [R programming language](https://www.r-project.org/) in this workshop. To actively follow the workshop, edit R scripts, and compute the models, you need to have installed [R](https://cran.r-project.org/mirrors.html) and the [RStan R package](http://mc-stan.org/rstan/) on your machine. Check out this [RStan Getting Started Guide](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started), as well as the [RStan documentation](http://www.et.bs.ehu.es/cran/web/packages/rstan/rstan.pdf). These two vignettes are also very useful for understanding RStan: (1) [RStan: the R interface to Stan
](http://mc-stan.org/rstan/articles/rstan.html) and (2) [Accessing the contents of a stanfit object
](http://mc-stan.org/rstan/articles/stanfit_objects.html). The free and open-source [RStudio Desktop](https://www.rstudio.com/products/RStudio/)  interface is recommended for editing and testing R scripts before they are run from the command line.

The organization of this repository follows [HRDAG](https://hrdag.org)'s [principled data processing guidelines](https://hrdag.org/2016/06/14/the-task-is-a-quantum-of-workflow/). This includes the organization of tasks into separate directories (e.g., import/, estimate/, visualize/, present/, etc.), the division of task directories into input/, src/, and output/ directories, and the use of [GNU Make](https://www.gnu.org/software/make/) to achieve a self-documenting workflow. To run a Makefile from your command line, navigate to the relevant task repository (e.g., "$: cd ~/git/SVAC-LVM-tutorial/import/") and execute "$: make -f Makefile". To run Makefiles on Mac OS,  install the XCode Command Line Tools.


