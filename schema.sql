
-- create table for animals
CREATE TABLE animals (
    animal_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    id INT GENERATED ALWAYS AS IDENTITY

);

-- Add a column species of type string to your animals table. 
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- Create a table named owners: 
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Create a table named species 
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    species_name VARCHAR(100) NOT NULL
);

-- Modify animals table , set as autoincremented PRIMARY KEY

CREATE TABLE new_table (
  id SERIAL PRIMARY KEY,
  animal_name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL NOT NULL,
  species VARCHAR(100) NOT NULL
);

-- Copy data from the old table to the new table
INSERT INTO new_table (animal_name, date_of_birth, escape_attempts, neutered, weight_kg, species)
SELECT animal_name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

-- Rename the old table to a temporary name:
ALTER TABLE animals RENAME TO animals_backup;

-- Rename the new table to the original table name:
ALTER TABLE new_table RENAME TO animals;


ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
  
ALTER TABLE animals
ADD COLUMN species_id INT;

    -- Then add foreign key constraint
ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id) 
REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals
ADD COLUMN owners_id INT;

    -- Then add foreign key constraint
ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY(owners_id) 
REFERENCES owners(id);