# Fraisty

Heuristic analysis of behavior data to give a quick characterization of variation.
Used as a sniff test for prospective collaborations.

### Codebook

- **num_performers** Number of performers
- **min_performer** Minimum number of observations from a performer  
- **max_performer** Maximum number of observations from a performer  
- **benchmark_ten** Mean performance of top 10% of performers

## Use

```sh
fraisty.sh --help
fraisty.sh --data demo-data.csv --spek demo-spek.json
fraisty.sh --spek demo-spek.json
```

Example text output to stdout from command line
```sh
bin/fraisty.sh -s inst/fixtures/spek.json -d example_data/mtx_behavior.csv -f '.'
num_performers  min_performer  max_performer  benchmark_ten
        "7458"            "1"           "10"    "0.2524514"
```
Example output image on this project's (wiki)[https://github.com/Display-Lab/fraisty/wiki/home]


## Installation
1. Install R from (CRAN)[https://cran.r-project.org/doc/manuals/R-admin.html]
2. Get package source from Github
    ```
    git clone https://github.com/Display-Lab/fraisty.git
    ```
3. Install package from source
    ```
    R CMD INSTALL --preclean --no-multiarch --with-keep.source fraisty
    ```
4. Run bin script (see above)

### Requirements
- git
- R 3.4 or above
- R packages:
  - jsonld
  - jsonlite
  - readr
  - rlang
  - dplyr
  - stats
  - ggplot2
  - cowplot
  

