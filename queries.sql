/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth >='2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts  FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.3 AND weight_kg <= 17.3;

/* Day 2. */

SELECT * FROM animals

BEGIN;
UPDATE animals SET species = 'unspecified';

UPDATE animals SET species = 'digimon' WHERE name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species NOT LIKE '%mon%';

COMMIT;

SELECT * FROM animals WHERE species = 'digimon';
SELECT * FROM animals

BEGIN;

DELETE FROM animals;

ROLLBACK;

DELETE FROM animals WHERE date_of_birth >= '2022-01-01';

BEGIN;

UPDATE animals 
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SAVEPOINT SP1;

SELECT * FROM animals
ROLLBACK TO SP1;
COMMIT;

-- Answer for the quary

SELECT * FROM animals
SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT COUNT(animals) FROM animals WHERE escape_attempts <= 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts), neutered FROM animals GROUP BY neutered;
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-12-31' AND date_of_birth <= '2000-01-01' GROUP BY species;