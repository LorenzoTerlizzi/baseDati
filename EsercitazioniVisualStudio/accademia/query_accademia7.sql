-- 1
select posizione, avg(stipendio) media_stipendio, stddev(stipendio) deviazione_standard
from persona
group by posizione;

-- 2
with stipendioMedio as (
    select posizione, avg(stipendio) media_stipendio
    from persona
    where posizione = 'Ricercatore'
    group by posizione
)
select p.*
from persona p
join stipendioMedio m on p.posizione = m.posizione
where p.stipendio > m.media_stipendio and p.posizione = 'Ricercatore';

-- 3
with statistiche as (
    select posizione, avg(stipendio) media_stipendio, stddev(stipendio) deviazione_standard
    from persona
    group by posizione
),
filtro as (
    select p.*, s.media_stipendio, s.deviazione_standard
    from persona p
    join statistiche s on p.posizione = s.posizione
    where abs(p.stipendio - s.media_stipendio) <= s.deviazione_standard
)
select posizione, count(*) numero_persone
from filtro
group by posizione;

-- 4
select p.*, sum(ap.oreDurata) ore_lavorate
from persona p
join attivitaProgetto ap on p.id = ap.persona
group by p.id
having sum(ap.oreDurata) >= 20;

-- 5
with durateProgetti as(
    select id, nome, fine - inizio durata
    from progetto
),
mediaDurata as (
    select avg(durata) media_durata
    from durateProgetti
)
select nome, durata
from durateProgetti
join mediaDurata md on durata > md.media_durata;

-- 6
select p.nome, sum(ap.oreDurata) ore_dimostrazione
from progetto p
join attivitaProgetto ap on p.id = ap.progetto
where p.fine <= current_date and ap.tipo = 'Dimostrazione'
group by p.nome;

-- 7
with assenzeMalattia as (
    select p.id, p.nome, p.cognome, count(*) num_giorni_assenza
    from persona p
    join assenza a on p.id = a.persona
    where a.tipo = 'Malattia'
    group by p.id
),
mediaAssenzeMalattia as (
    select avg(num_giorni_assenza) media_assenze
    from assenzeMalattia a
    join persona p on p.id = a.id
    where p.posizione = 'Professore Associato'
)
select p.id, p.nome, p.cognome, a.num_giorni_assenza
from persona p
join assenzeMalattia a on p.id = a.id
join mediaAssenzeMalattia md on a.num_giorni_assenza > md.media_assenze
where p.posizione = 'Professore Ordinario';