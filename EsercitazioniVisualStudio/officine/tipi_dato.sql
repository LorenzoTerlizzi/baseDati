CREATE DOMAIN StringNotNull as VARCHAR(100)
    check (value is not null);

CREATE DOMAIN Civico VARCHAR 
check (value ~ '[0-9]+(/[a-z]+)?');

CREATE DOMAIN CAP as VARCHAR
    check(value ~ '[0-9]{5}' and value is not null);

CREATE TYPE Indirizzo(
    via  StringNotNull,
    civico ...,
    cap ...
);

