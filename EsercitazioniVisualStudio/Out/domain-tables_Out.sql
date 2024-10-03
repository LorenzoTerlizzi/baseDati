create table Nazione(
    nome varchar not null,
    primary key(nome)
);

create table Regione(
    nome varchar not null,
    nazione varchar not null,
    primary key(nome, nazione),
    foreign key(nazione) references Nazione(nome)
);

create table Citta(
    nome varchar not null,
    regione varchar not null,
    nazione varchar not null,
    primary key(nome, regione, nazione),
    foreign key(regione, nazione) references Regione(nome, nazione)
);

create table Sede(
    indirizzo Indirizzo not null,
    nome varchar not null,
    id_sede serial primary key not null,
    citta varchar not null,
    regione varchar not null,
    nazione varchar not null,
    foreign key(citta, regione, nazione) 
        references Citta(nome, regione, nazione)
);

create table Sala(
    nome varchar not null,
    sede integer not null,
    primary key(nome, sede),
    foreign key(sede) references Sede(id_sede)
);

create table Settore(
    nome varchar not null,
    id_settore serial primary key not null,
    sala varchar not null,
    sede integer not null,
    unique(nome, sala, sede),
    foreign key(sala, sede) references Sala(nome, sede)
);

create table Posto(
    fila integer not null,
    colonna integer not null,
    settore integer not null,
    primary key(fila, colonna, settore),
    foreign key(settore) references Settore(id_settore)
);

create table Artista(
    nome varchar not null,
    cognome varchar not null,
    nome_arte varchar,
    id_artista serial primary key not null,
);

create table TpologiaSpettacolo(
    nome varchar primary key not null
);

create table Genere(
    nome varchar primary key not null
);

create table Spettacolo(
    nome varchar not null,
    durata_min integer not null,
    id_spettacolo serial primary key not null,
    tipologiaSpettacolo varchar not null,
    genere varchar not null,
    foreign key(tipologiaSpettacolo) 
        references TpologiaSpettacolo(nome),
    foreign key(genere) 
        references Genere(nome)
    -- v.incl id_artista occore in Partecipa(spettacolo)
);

create table Partecipa(
    spettacolo integer not null,
    artista integer not null,
    primary key(spettacolo, artista),
    foreign key(spettacolo) 
        references Spettacolo(id_spettacolo),
    foreign key(artista)
        references Artista(id_artista)
);


create table Evento(
    data Data not null,
    orario time not null,
    id_evento serial primary key not null,
    spettacolo integer not null,
    sala varchar not null,
    sede varchar not null,
    foreign key(spettacolo)
        references Spettacolo(id_spettacolo),
    foreign key(sala, sede)
        references Sala(nome, sede)
);

create table Utente(
    nome varchar not null,
    cognome varchar not null,
    cf CF primary key not null
);

create table Prenotazione(
    istante data not null,
    id_prenotazione serial primary key not null,
    utente CF not null,
    evento integer not null,
    foreign key(utente) references Utente(cf),
    foreign key(evento) references Evento(id_evento)
);

create table TipoTariffa(
    nome varchar primary key not null
);

create table Tariffa(
    prezzo Denaro not null,
    tipo_tariffa varchar not null,
    settore integer not null,
    evento integer not null,
    primary key(tipo_tariffa, settore, evento),
    foreign key(tipo_tariffa) references TipoTariffa(nome),
    foreign key(settore) references Settore(id_settore),
    foreign key(evento) references Evento(id_evento)
);

create table PrePosto(
    prenotazione integer not null,
    fila integer not null,
    colonna integer not null,
    settore integer not null,
    tipo_tariffa varchar not null,
    primary key(prenotazione, fila, colonna, settore)
    foreign key(prenotazione)
        references Prenotazione(id_prenotazione),
    foreign key(fila, colonna, settore)
        references Posto(fila, colonna, settore),
    foreign key(tipo_tariffa) references TipoTariffa(nome)
);

