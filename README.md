
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidysigs

<!-- badges: start -->
<!-- badges: end -->

The goal of tidysigs is to simplify visualisation of basic mutational
signature profiles in tidy format

## Installation

You can install the development version of tidysigs from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("selkamand/tidysigs")
```

## Input Format

### Decompositions

Must be data.frames with 3 columns

Example

1)  channel

How many example for SNV mutsigs this would be A\[A\>T\]A A\[A\>C\]A
A\[A\>G\]A … etc

2)  percentage

3)  type

4)  ‘counts’ (optional)

How many times has such an observation occured

What broader class of mutations does this ‘channel’ belong to (used to
colour plots)

For example A\[A\>T\]A, A\[A\>T\]T and C\[A\>T\]G mutations belong to
the ‘A\>T’ mutation class
