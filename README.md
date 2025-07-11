# Explaining the 5 types of database and how to choose between them

> **Note** this is a work in progress, don't expect anything sensible here yet!

Slides and notes for the talk "Explaining the 5 types of database and how to
choose between them", a talk (to be) given at
[EuroPython 2025](https://ep2025.europython.eu/)
on [Friday 18th July
2025](https://ep2025.europython.eu/session/explaining-the-5-types-of-database-and-how-to-choose-between-them)
by [Tibs](https://aiven.io/Tibs).

When the video recording is released, a link will be provided.


## Abstract

What database should you choose? Worse, what *kind* of database should you choose?

My aim is to give you enough information to make that choice, or at least be
aware of what the alternatives are.

I'd argue that there are five important database types at the moment, differing
in how they regard the "shape" of their data. I'll give a brief introduction to
each, explaining how it works, and discuss why you might want to use that
particular type of database, depending on your data and what you want to do
with it. I'll show case at least one open source example of each.

I'll cover:

* Relational (PostgreSQL®, SQLite)
* Columnar (ClickHouse®)
* Document (OpenSearch®)
* Key Value (Valkey™️)
* and as an extra, Graph (Neo4J®)

## Documents here

[slides.typ](slides.typ) is the Typst source code for the slides. The PDF for
the slides is [slides.pdf](slides.pdf). This version of the talk is aimed at 30
minutes or less.

[slides-long.ty](slides-long.typ) is a longer version of the talk, which also
mentions transactions and OLTP/OLAP.

[Notes](notes.md) are the notes I made when writing the talk.

## Creating the slides

The slides are created using [typst](https://typst.app/) and the
[polylux](https://typst.app/universe/package/polylux/) package.

They use the Libertinus fonts - see https://github.com/alerque/libertinus.
 
To build I use the command line tool `typst`. See the [installation
instructions](https://github.com/typst/typst?tab=readme-ov-file#installation)
from the [typst GitHub repostory](https://github.com/typst/typst) - on my mac
I install it with `brew install typst` - and then
```shell
typst compile -f pdf slides.typ
```
 
The provided `Makefile`
can also produce the slides
(you'll need `make`, either GNU or BSD should work).
Try
```shell
make slides
```
and `make help` for what else it can do.

--------

![CC-Attribution-ShareAlike image](images/cc-attribution-sharealike-88x31.png)

This talk and its related files are released under a [Creative Commons
Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).
