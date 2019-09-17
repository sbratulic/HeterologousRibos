# HeterologousRibos
## Phylogenetic tree pruning for the "Orthogonal Translation Enables Heterologous Ribosome Engineering in *E. coli*" manuscript

To run the script, first download and install [R](https://cran.r-project.org/mirrors.html). The script uses the [Ape](https://cran.r-project.org/web/packages/ape/index.html) package for tree prunning and [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) to wrangle the inputs/results packages. These libraries can be installed from `R` with:

```R
install.packages(c("ape", "dplyr"))
```

The script is run from the terminal:

```bash
Rscript --vanilla trimTree.R bac120_r86.1.tree SpeciesReduced_final.csv out
```

-the first argument (`bac120_r86.1.tree`) is the original tree for pruning. The tree was downloaded from [here](https://data.ace.uq.edu.au/public/gtdb/data/releases/release86/86.1/)

-the second argument (`SpeciesReduced_final.csv`)is the list of species you to keep in the tree

-the third argument is the output file prefix. The default prefix value is `out`. In this case the output files would be `out.tree` and `out_distances.csv`.
