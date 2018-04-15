# From Microfiche to Dataset?

This is an attempt to document the triumphs and frustrations of wrangling a dataset from [Federal Communication Commission](https://www.fcc.gov/) (dead tree captured on small film) archives. 

No promises, but you might find things I have made/tweaked/broke, and some useful learnings for anyone else involved in creating custom datasets. 

**TASK**: Take 26GB (and counting) of scanned microfiche documents (.jpg images), and extract dates, involved parties, and transaction details for every mobile spectrum license sale or transfer contained in these images.

**PURPOSE**: The transactions extracted from the microfiche will form part of a larger chronology of mobile spectrum licence trading up to the present day. This history is of particular interest in reflecting on Ronald Coase's seminal article from 1959 [The Federal Communications Commission](http://www.jstor.org/stable/724927), and to examine the allocative efficiency of auctions and lotteries.

Everything below is a work in progress. 

Maybe follow me on twitter if you want to know when a new readable chunks is completed: [@cynthiahqy](https://twitter.com/cynthiahqy)

## [The Journey so Far](journal.md)

A journal of things I've thought/did/learnt in chronological-ish order.   

## [Process Snippets](experiments.ipynb)

A (yet to be created) notebook documenting scripts, tools and code snippets I've written to do various things like:

- file management
- image transformation
- progress tracking
- logging data transformations
- meta-tag and filter images before data encoding
- explore the feasiblity of using optical character recognition (OCR) 

## [Lessons for future data wrangling](learnings.md)

A summary of things that I wish I'd known before trying to wrangle a dataset from the wild. The TL;DR version of my journal. 
