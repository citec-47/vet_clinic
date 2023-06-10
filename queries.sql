/*Queries that provide answers to the questions from all projects.

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE animal_name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT animal_name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT animal_name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE animal_name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT animal_name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE animal_name Not IN ('Gabumon');

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that 
-- equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3


-- Transactions

-- Inside a transaction update the animals table by setting the species column to unspecified
BEGIN TRANSACTION;
UPDATE animals
SET species ='unspecified';

-- To Rollback
ROLLBACK;

-- Update the animals table by setting the species column to digimon for all 
-- animals that have a name ending in mon.
BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE animal_name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all 
-- animals that don't have species already set.
UPDATE animals
SET species = 'pokemon'
WHERE animal_name NOT LIKE '%mon';

-- Commit the transaction
COMMIT;

-- Inside a transaction delete all records in the animals table
BEGIN TRANSACTION;
DELETE from animals;

-- To Rollback
ROLLBACK;

-- Inside a transaction: 
-- Delete all animals born after Jan 1st, 2022.
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for this transactions.
SAVEPOINT animals_savepoint;

-- Updating all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback or save to the savepoint
ROLLBACK TO animals_savepoint;

-- Updating all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

-- Amount of animals there?
SELECT COUNT(animal_name) FROM animals;

-- animals which have never tried to escape?
SELECT COUNT(animal_name) FROM animals WHERE escape_attempts = 0;

-- average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Which records the most escapes, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts)
FROM animals
GROUP BY neutered
ORDER BY SUM(escape_attempts) DESC;
-- Neutered animals that escaped the most

-- What is the minimum and maximum weight of animals?
SELECT Min(weight_kg), MAX(weight_kg) FROM animals;


-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT animals.animal_name
FROM animals
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.animal_name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.species_name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.animal_name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;

-- How many animals are there per species?
SELECT species_name, COUNT(*)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species_name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.animal_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.species_name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.animal_name
FROM animals
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' And animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(*) AS animals_count
FROM animals
JOIN owners ON animals.owners_id = owners.id
GROUP BY full_name
ORDER BY animals_count DESC
LIMIT 1;
