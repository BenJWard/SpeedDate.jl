---
title: 'SpeedDate.jl: Rapid DNA sequence divergence-time estimation'
tags:
  - Julia
  - biology
  - bioinformatics
  - sequences
  - evolution
  - date
  - divergence time
authors:
  - name: Ben J. Ward
    orcid: 0000-0003-0872-7098
    affiliation: 1
  - name: Cock van Oosterhout
    affiliation: 2
affiliations:
 - name: Earlham Institute, Norwich Research Park, Norwich, NR4 7UZ, UK
   index: 1
 - name: School of Environmental Sciences, Norwich Research Park, University of East Anglia, Norwich, NR4 7TJ, UK
   index: 2
date: 15 August 2020
bibliography: paper.bib
---

# Summary

In evolutionary biology and population genetics, it is common to look at gene or
genome sequences from two or more individuals, and want to know the divergence
time between the sequences. That is, for how long have the two sequences been
diverging from their common ancestor? There are many different ways to trying
to estimate the divergence time. Simple methods extrapolate a divergence time
from how many differences the sequences have, by assuming that mutations occur
at a constant rate through time. Other methods for inferring the divergence time
involve simulation and modelling more complex evolutionary histories.

# Statement of need 

`SpeedDate` is a method of estimating a divergence time between two DNA sequences.
It was first implemented in the R package `HybridCheck`. It was specifically used
to date regions of introgression between homologous contigs of assembled genomes.
Because it was designed for a study involving whole genome sequencing data of multiple
individuals from a population. As such it was designed to give rapid reasonable
estimates, rather than precise estimates that methods that are far more computationally
intensive. The SpeedDate method then is simple and quick to run for example on
a sliding window over entire genomes, making it more useful for exploratory and
broad stroke assesments of evolutionary dynamics across a genome. It is then 
complimentary with other more intensive methods used in the field.

The `SpeedDate.jl` package implements the very same algorithm in Julia, making it
faster than the original implementation in R. It is also
built on top of packages in the `BioJulia` framework, including `BioSequences.jl`.
The divergence time is estimated using the number of mutations that have occurred
between two aligned sequences. The calculation uses a strict molecular clock
which assumes a constant substitution rate, both through time and across taxa, and
models the mutation accumulation process as a Bernoulli trial. More details about
the model are in the SpeedDate.jl online manual.

`Gala` was designed to be used by both astronomical researchers and by
students in courses on gravitational dynamics or astronomy. It has already been
used in a number of scientific publications [@Pearson:2017] and has also been
used in graduate courses on Galactic dynamics to, e.g., provide interactive
visualizations of textbook material [@Binney:2008]. The combination of speed,
design, and support for Astropy functionality in `Gala` will enable exciting
scientific explorations of forthcoming data releases from the *Gaia* mission
[@gaia] by students and experts alike.

# Mathematics

Single dollars ($) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left\{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$

You can also use plain \LaTeX for equations
\begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation}
and refer to \autoref{eq:fourier} from text.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Fenced code blocks are rendered with syntax highlighting:
```python
for n in range(10):
    yield f(n)
```	

# Acknowledgements

We acknowledge contributions from Brigitta Sipocz, Syrtis Major, and Semyeong
Oh, and support from Kathryn Johnston during the genesis of this project.

# References