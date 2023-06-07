/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

\c vet_clinic;

CREATE TABLE animals (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
date_of_birth date,
escape_attempts integer,
neutered boolean,
weight_kg decimal
);

-- Second Project

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

-- Third Project
CREATE TABLE owners(
    id serial PRIMARY KEY,
    full_name text,
    age int
);

CREATE TABLE species(
    id serial PRIMARY KEY,
    name text
);

ALTER TABLE animals
DROP COLUMN species;
