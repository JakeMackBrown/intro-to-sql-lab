-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed, so find the least populated country in Southern Europe, and we'll start looking for her there.
 
-- world=# SELECT name, population
-- world-# FROM countries
-- world-# WHERE region = 'Southern Europe'
-- world-# ORDER BY population ASC
-- world-# LIMIT 1;
--              name              | population
-- -------------------------------+------------
--  Holy See (Vatican City State) |       1000
-- (1 row)


-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in this country's officially recognized language. Check our databases and find out what language is spoken in this country, so we can call in a translator to work with you.

-- world=# SELECT language
-- world-# FROM countrylanguages
-- world-# WHERE countrycode = (SELECT code FROM countries WHERE name = 'Holy See (Vatican City State)')
-- world-# AND isofficial = true;
--  language
-- ----------
--  Italian
-- (1 row)


-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on to a different country, a country where people speak only the language she was learning. Find out which nearby country speaks nothing but that language.

-- world=# SELECT countrycode
-- world-# FROM countrylanguages
-- world-# WHERE language = 'Italian'
-- world-# AND isofficial = true;
--  countrycode
-- -------------
--  CHE
--  ITA
--  SMR
--  VAT
-- (4 rows)

-- It has to be San Morino...


-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time. There are only two cities she could be flying to in the country. One is named the same as the country – that would be too obvious. We're following our gut on this one; find out what other city in that country she might be flying to.

-- world=# SELECT name
-- world-# FROM cities
-- world-# WHERE countrycode = (SELECT code FROM countries WHERE name = 'San Marino')
-- world-# AND name != 'San Marino';
--     name
-- ------------
--  Serravalle
-- (1 row)


-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

-- world=# SELECT name, countrycode
-- world-# FROM cities
-- world-# WHERE name LIKE 'Serr%'
-- world-# AND countrycode IN (SELECT code FROM countries WHERE continent = 'South America');
--  name  | countrycode
-- -------+-------------
--  Serra | BRA
-- (1 row)

-- world=# SELECT name
-- M countworld-# FROM countries
-- world-# WHERE code = 'BRA';
--   name
-- --------
--  Brazil
-- (1 row)


-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
-- follow right behind you!


-- world=# SELECT capital
-- world-# FROM countries
-- WHERworld-# WHERE name = 'Brazil';
--  capital
-- ---------
--      211
-- (1 row)

-- world=# SELECT cities.name
-- world-# FROM countries
-- world-# JOIN cities ON countries.capital = cities.id
-- world-# WHERE countries.name = 'Brazil';
--    name
-- ----------
--  Brasília
-- (1 row)


-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the landing dock. Lucky for us, she's getting cocky. She left us a note (below), and I'm sure she thinks she's very clever, but if we can crack it, we can finally put her where she belongs – behind bars.


--               Our playdate of late has been unusually fun –
--               As an agent, I'll say, you've been a joy to outrun.
--               And while the food here is great, and the people – so nice!
--               I need a little more sunshine with my slice of life.
--               So I'm off to add one to the population I find
--               In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.


-- world=# SELECT name, countrycode
-- world-# FROM cities
-- world-# WHERE population = 91085;
--  name | countrycode
-- ------+-------------
-- (0 rows)

-- world=# SELECT name, population
-- world-# FROM cities
-- HEREworld-# WHERE population BETWEEN 91000 AND 92000;
--          name          | population
-- -----------------------+------------
--  Tandil                |      91101
--  São Lourenço da Mata  |      91999
--  Santana do Livramento |      91779
--  Votorantim            |      91777
--  Campo Largo           |      91203
--  Gillingham            |      92000
--  Hartlepool            |      92000
--  Halifax               |      91069
--  Woking/Byfleet        |      92000
--  San Pedro de la Paz   |      91684
--  Melipilla             |      91056
--  al-Hawamidiya         |      91700
--  Disuq                 |      91300
--  Batam                 |      91871
--  Padang Sidempuan      |      91200
--  Sawangan              |      91100
--  Semnan                |      91045
--  Barletta              |      91904
--  Arezzo                |      91729
--  Klagenfurt            |      91141
--  Mobara                |      91664
--  Narita                |      91470
--  Kashiwazaki           |      91229
--  Tsuyama               |      91170
--  Nyeri                 |      91258
--  Kaiyuan               |      91999
--  Tumen                 |      91471
--  Putian                |      91030
--  Matamoros             |      91858
--  Düren                 |      91092
--  Unayza                |      91100
--  Najran                |      91000
--  Idlib                 |      91081
--  Ilan                  |      92000
--  Pardubice             |      91309
--  Kirovo-Tšepetsk       |      91600
--  Krasnogorsk           |      91000
--  San Mateo             |      91799
--  Visalia               |      91762
--  Boulder               |      91238
--  Cary                  |      91213
--  Santa Monica          |      91084
-- (42 rows)

-- world=# SELECT name
-- world-# FROM countries
-- world-# WHERE code = (SELECT countrycode FROM cities WHERE name = 'Tandil');
--    name
-- -----------
--  Argentina
-- (1 row)
