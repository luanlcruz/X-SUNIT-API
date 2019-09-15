# README
# SUNIT (Extraterrestrial Survival Unit) Gocase Test
Versions
- ruby '2.6.3'

- rails '6.0.0'

All others gems and versions on Gemfile.

This api will:

- Add survivors to the database
 A survivor must have a name, age, gender and last location (latitude, longitude).

- Update survivor location

 A survivor must have the ability to update their last location, storing the new latitude/longitude pair in the base (no need to track      locations, just replacing the previous one is enough).

- Flag survivor as abducted

In a chaotic situation like that, it's inevitable that a survivor may get abducted. When this happens, we need to flag the survivor was abducted.

A survivor is marked as abducted when at least three other survivors report their abduction.

- Reports

The API must offer the following reports:

Percentage of abducted survivors.

Percentage of non-abducted survivors.

List of all survivors names, by alphabetic order, with an identification to know who was abducted.


# All the documentation here:
https://documenter.getpostman.com/view/8803343/SVmtxerU?version=latest
