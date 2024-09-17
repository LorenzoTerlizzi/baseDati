--creazione database--
create database Accademia
-- \c Accademia --  connetti al db

create type Strutturato as enum ('Ricercatore', 'Professore Associato','Professore Ordinario');

create type LavoroProgetto as enum ('Ricerca e Sviluppo', 'Dimostrazione', 'Management', 'Altro');

create type LavoroNonProgettuale as enum('Didattica', 'Ricerca', 'Missione', 'Incontro Dipartimentale', 'Incontro Accademico', 'Altro');

create type CausaAssenza as enum ('ChiusuraUniversitaria', 'Maternità', 'Malattia');

create domain PosInteger as integer check (value >= 0);

create domain StringaM as varchar(100);

create domain Numero_Ore as integer check (value >= 0 and value <= 8);

create domain Denaro as real check (value >= 0);



create table Persona(
    id PosInteger not null,
    nome StringaM not null,
    cognome StringaM not null,
    posizione Strutturato not null,
    stipendio Denaro not null,
    primary key (id)
);

create table Progetto(
    id PosInteger not null primary key,
    nome StringaM not null,
    inizio date not null,
    fine date not null,
    budget Denaro not null,
    unique (nome),
    check (fine>inizio)
);

create table WP(
    progetto PosInteger not null,
    id PosInteger not null,
    nome StringaM not null,
    inizio date not null,
    fine date not null,
    primary key(progetto, id),
    check(inizio<fine),
    unique(progetto, nome),
    foreign key(progetto) references Progetto(id)
);

create table AttivitaProgetto(
    id PosInteger not null primary key,
    persona PosInteger not null, 
    progetto PosInteger not null,
    wp PosInteger not null, 
    giorno date not null, 
    tipo LavoroProgetto not null, 
    oreDurata Numero_Ore not null,
    foreign key(persona) references Persona(id),
    foreign key(progetto, wp) references WP(progetto, id)
);


create table AttivitàNonProgettuale(
    id PosInteger not null primary key, 
    persona PosInteger not null, 
    tipo LavoroNonProgettuale not null, 
    giorno date not null, 
    oreDurata Numero_Ore not null,
    foreign key (persona) references Persona(id)
);


create table Assenza(
    id PosInteger not null primary key,
    persona PosInteger not null,
    tipo CausaAssenza not null,
    giorno date not null,
    unique (persona, giorno),
    foreign key (persona) references Persona(id)
);