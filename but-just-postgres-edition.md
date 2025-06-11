# Explaining the 5 types of database and how to choose between them (PostgreSQL edition)

Because obviously we could just use Postgres for all of them...

> **Note** see the appendix [But Postgres!](notes.md#appendix-but-postgres)
> in the main talk [notes](notes.md)
>
> **Note** that this talk does not exist :)

**Summary:** There are five important database types at the moment, differing
in how they regard the "shape" of your data. In this talk, I'll describe all
five, why you might want to use them, and why, luckily for us, you could use
PostgreSQL for each.

## Abstract for this potential other talk

I'm giving a talk at another conference on how to choose which *type* of
database to use, depending on your data and what you want to do with it, and
showcasing an open source example of each of the five types. But this is a
PostgreSQL conference, and so this is the PostgreSQL edition of that talk,
where the answer can always be "but, actually, use PostgreSQL".

As in the other talk, I'll give a brief introduction to each type of database,
each "shape" of data, and why you might want to use it. I'll still mention an
"obvious" open source example of each, but I'll also explain what solutions
are available in PostgreSQL, and why that makes the "obvious" choice less so.

I'll cover:

* Relational (PostgreSQL® itself of course!)
* Columnar
* Document
* Key Value
* and as an extra, Graph

Finally, as part of that last, I'll explain why I helped write an object
oriented database in the 1990s, and why nowadays we'd just start with PostGIS :)
