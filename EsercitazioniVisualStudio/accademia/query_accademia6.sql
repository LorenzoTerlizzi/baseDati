-- 1. Quanti sono gli strutturati di ogni fascia?
-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?
-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?
-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto
-- ‘Pegasus’ ?
-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto
-- ‘Pegasus’ da ogni singolo docente?
-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?
-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?
-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori
-- associati e dei professori ordinari?
-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?
-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?-
-1--
select distinct posizione, count(*) numeroStrutturati
from Persona
group by posizione;

--2--
select count(*) numeroStrutturati
from Persona
where stipendio >= 40000;

--3--
select count(distinct id) numeroProgetti
from Progetto
where fine < current_date
and budget > 50000;

--4--
select avg(ap.oreDurata) media, max(ap.oreDurata) massimo, min(ap.oreDurata) minimo
from Progetto p, AttivitaProgetto ap
where p.id = ap.progetto
and p.nome = 'Pegasus';

--5--
select s.id, s.nome, s.cognome, avg(ap.oreDurata) media, max(ap.oreDurata) massimo, min(ap.oreDurata) minimo
from Progetto p, AttivitaProgetto ap, Persona s
where p.id = ap.progetto and ap.persona = s.id
and p.nome = 'Pegasus'
group by (stinct s.id, s.nome, s.cognome);

--6--
select distinct s.id, s.nome, s.cognome, sum(oreDurata) oreDidattica
from AttivitaNonProgettuale anp, Persona s
where anp.persona = s.id
and tipo = 'Didattica'
group by (s.id, s.nome, s.cognome);

--7--
select avg(distinct stipendio) mediaStipendio, max(distinct stipendio) maxStipendio, min(distinct stipendio) minStipendio
from Persona
where posizione = 'Ricercatore';

--8--
select distinct posizione, avg(stipendio) mediaStipendio, max(stipendio) maxStipendio, min(stipendio) minStipendio
from Persona
group by posizione;

--9--
select distinct p.id, p.nome, sum(ap.oreDurata) totaleOre
from AttivitaProgetto ap, Persona s, Progetto p
where ap.persona = s.id and ap.progetto = p.id
and s.nome = 'Ginevra' and s.cognome = 'Riva'
group by p.id, p.nome;


--10--
select distinct p.id, p.nome
from AttivitaProgetto ap, Progetto p
where ap.progetto = p.id
group by (p.id, p.nome)
having count(distinct ap.persona) > 2;


--11--
select distinct s.id, s.nome, s.cognome
from AttivitaProgetto ap, Persona s
where ap.persona = s.id
and s.posizione = 'Professore Associato'
group by (s.id, s.nome, s.cognome)
having count(distinct ap.progetto) > 1;

