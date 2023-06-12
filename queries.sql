/*Queries that provide answers to the questions from all projects.*/

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

-- Create a savepoint for the transaction.
SAVEPOINT animals_savepoint;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO animals_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(animal_name) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(animal_name) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts)
FROM animals
GROUP BY neutered
ORDER BY SUM(escape_attempts) DESC;
-- Neutered animals escape the most

-- What is the minimum and maximum weight of each type of animal?
SELECT Min(weight_kg), MAX(weight_kg) FROM animals;

-- Min-Weight is 5.kg and Max-weight is 45kg

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


-- Who was the last animal seen by William Tatcher?
SELECT animals.animal_name
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.vet_name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.id)
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.vet_name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.vet_name, species.species_name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id
ORDER BY vets.vet_name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.animal_name
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.vet_name = 'Stephanie Mendez'
AND visits.visit_date >= '2020-04-01'
AND visits.visit_date <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.animal_name, COUNT(*) AS visit_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.animal_name
ORDER BY visit_count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.animal_name, visits.visit_date
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.vet_name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.animal_name, animals.date_of_birth, animals.escape_attempts, animals.neutered,
animals.weight_kg,  visits.visit_date, vets.vet_name, vets.age, vets.date_of_graduation
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS number_of_visits
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.species_name, COUNT(*) AS number_of_visits
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE vets.vet_name = 'Maisy Smith'
GROUP BY species.species_name
ORDER BY number_of_visits DESC
LIMIT 1;


-------optimization
WHERE visits.vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') 
GROUP BY species.name 
ORDER BY COUNT(visits.animals_id) DESC LIMIT 1;


explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

SELECT COUNT(*) FROM visits where animal_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';

--create the indexes to reduce the time
CREATE INDEX animals_ids_asc ON visits( animal_id ASC);
CREATE INDEX vets_ids_asc ON visits( vet_id ASC);
CREATE INDEX emails_asc ON owner( email ASC);