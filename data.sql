-- Insert data to animals table
INSERT INTO animals (animal_name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8),
('Pikachu', '2021-01-07', 1, false, 15.04),
('Devimon', '2017-05-12', 5, true, 11);


-- Insert new data to animals table
INSERT INTO animals (animal_name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, 11),
('Plantmon', '2021-11-15', 2, true, -5.7),
('Squirtle', '1993-04-02', 3, false, -12.13),
('Angemon', '2005-06-12', 1, true, -45),
('Boarmon', '2005-06-07', 7, true, 20.4),
('Blossom', '1998-10-13', 3, true, 17),
('Ditto', '2022-05-14', 4, true, 22);

-- Insert data to owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Insert data to species table
INSERT INTO species (species_name)
VALUES ('Pokemon'),
('Digimon');

-- Modify your inserted animals so it includes the species_id value:
--   If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals
SET species_id = CASE
WHEN animal_name LIKE '%mon' THEN 2
ELSE 1
END;

-- Modify your inserted animals to include owner information (owner_id):
  -- Sam Smith owns Agumon.
UPDATE animals
SET owners_id = 1
WHERE animal_name = 'Agumon';

  -- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owners_id = 2
WHERE animal_name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
UPDATE animals
SET owners_id = 3
WHERE animal_name IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals
SET owners_id = 4
WHERE animal_name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals
SET owners_id = 5
WHERE animal_name IN ('Angemon', 'Boarmon');

-- Insert data to vets table: 
INSERT INTO vets (vet_name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Insert data to specializations table
INSERT INTO specializations ( vet_id, species_id)
VALUES (1, 1),
(3, 2),
(3, 1),
(4, 2);

-- Insert data to visits table
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(5, 2, '2020-01-05'),
(5, 2, '2020-03-08'),
(5, 2, '2020-05-14'),
(3, 3, '2021-05-04'),
(6, 4, '2021-02-24'),
(8, 2, '2019-12-21'),
(8, 1, '2020-08-10'),
(8, 2, '2021-04-7'),
(10, 3, '2019-09-29'),
(9, 4, '2020-10-03'),
(9, 4, '2020-11-04'),
(4, 2, '2019-01-24'),
(4, 2, '2019-05-15'),
(4, 2, '2020-02-27'),
(4, 2, '2020-08-03'),
(7, 3, '2020-05-24'),
(7, 1, '2021-01-11');