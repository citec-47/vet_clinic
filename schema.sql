/* Database schema to keep the structure of entire database. */


-- create a table animals

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

-- Modify animals table
-- Make sure that id is set as autoincremented PRIMARY KEY
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

-- Rename the old table to animals_backup
ALTER TABLE animals RENAME TO animals_backup;

-- Rename the new table to the original table name:
ALTER TABLE new_table RENAME TO animals;

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
    -- first add a species_id column to animals table
ALTER TABLE animals
ADD COLUMN species_id INT;

    -- Then add foreign key constraint
ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id) 
REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
 -- first add a owner_id column to animals table
ALTER TABLE animals
ADD COLUMN owners_id INT;

    -- Then add foreign key constraint
ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY(owners_id) 
REFERENCES owners(id);

-- Create a table named vets
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  vet_name VARCHAR(100) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE NOT NULL
);

-- There is a many-to-many relationship between the tables species and vets:
--  a vet can specialize in multiple species, and a species can have multiple vets specialized in it. 
-- Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
  id SERIAL PRIMARY KEY,
  vet_id INT NOT NULL,
  species_id INT NOT NULL,
  FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE,
  FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE
);

-- There is a many-to-many relationship between the tables animals and vets: 
-- an animal can visit multiple vets and one vet can be visited by multiple animals.
--  Create a "join table" called visits to handle this relationship,
--  it should also keep track of the date of the visit.
CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  animal_id INT NOT NULL,
  vet_id INT NOT NULL,
  visit_date DATE NOT NULL,
  FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE,
  FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE
);
*/