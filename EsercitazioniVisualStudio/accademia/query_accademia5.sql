--1--
select WP.nome, WP.inizio, WP.fine
from WP, Progetto
where WP.progetto = Progetto.id
and Progetto.nome = 'Pegasus';

--2--
select distinct Persona.nome, Persona.cognome, Persona.posizione
from Persona, AttivitaProgetto, Progetto
where Persona.id = AttivitaProgetto.persona and AttivitaProgetto.progetto = Progetto.id
and Progetto.nome = 'Pegasus'
ORDER BY Persona.cognome DESC;

--3--
select Persona.nome, Persona.cognome, Persona.posizione
from Persona, AttivitaProgetto, Progetto
where Persona.id = AttivitaProgetto.persona and AttivitaProgetto.progetto = Progetto.id
and Progetto.nome = 'Pegasus'
group by Persona.nome, Persona.cognome, Persona.posizione
having count(AttivitaProgetto.id) > 1;

--3 alternativa senza usare having count()--
select distinct s.id, s.nome, s.cognome, s.posizione
from AttivitaProgetto a1, AttivitaProgetto A2, Persona s, Progetto persona
where a1.id, <> a2.id
and a1.progetto = a2.progetto
and a1.persona = a2.persona
and a1.persona = s.id
and a1.persona = p.id
and p.nome = 'Pegasus'  

--4--
select distinct Persona.nome, Persona.cognome, Persona.posizione
from Persona, Assenza
where Persona.id = Assenza.persona
and Persona.posizione = 'Professore Ordinario' and Assenza.tipo = 'Malattia';


--5--
select Persona.nome, Persona.cognome, Persona.posizione
from Persona, Assenza
where Persona.id = Assenza.persona
and Persona.posizione = 'Professore Ordinario' and Assenza.tipo = 'Malattia'
group by Persona.nome, Persona.cognome, Persona.posizione
having count(Assenza.id) > 1;
--5 alternativa senza usare having count()--
select *
from persona s, assenza a1, assenza a2
where a1.persona = s.id
and a2.persona = s.id
and a1.id <> a2.id
and a1.tipo = 'Malattia'
and a2.tipo = 'Malattia'
and s.posizione = 'Professore Ordinario';


--6--
select distinct Persona.nome, Persona.cognome, Persona.posizione
from Persona, AttivitaNonProgettuale
where Persona.id = AttivitaNonProgettuale.persona
and Persona.posizione = 'Ricercatore'
and AttivitaNonProgettuale.tipo = 'Didattica';


--7--
select Persona.nome, Persona.cognome, Persona.posizione
from Persona, AttivitaNonProgettuale a1, AttivitaNonProgettuale a2
where Persona.id = AttivitaNonProgettuale.persona
and Persona.posizione = 'Ricercatore' and AttivitaNonProgettuale.tipo = 'Didattica'
group by Persona.nome, Persona.cognome, Persona.posizione
having count(AttivitaNonProgettuale.id) > 1;
-- 7--
select distinct p.nome, p.cognome, p.posizione
from persona p, AttivitaNonProgettuale an1, AttivitaNonProgettuale an2
where an1.id <> an2.id
and an1.tipo = 'Didattica'
and an2.tipo = 'Didattica'
and an1.persona = p.id
and an2 = p.id
and p.posizione = 'Ricercatore';


--8--
select distinct Persona.nome, Persona.cognome
from Persona, AttivitaProgetto, AttivitaNonProgettuale
where Persona.id = AttivitaProgetto.persona and Persona.id = AttivitaNonProgettuale.persona
and AttivitaProgetto.giorno = AttivitaNonProgettuale.giorno;


--9--
select s.nome, s.cognome, ap.giorno, p.nome,
       anp.tipo, ap.oreDurata oreProg, anp.oreDurata oreNonProg
from Persona s, AttivitaProgetto ap, AttivitaNonProgettuale anp, Progetto p
where s.id = ap.persona
and s.id = anp.persona
and ap.progetto = p.id
and ap.giorno = anp.giorno;



--10--
select distinct s.id, s.nome, s.cognome
from Persona s, AttivitaProgetto ap, Assenza a
where s.id = ap.persona 
and s.id = a.persona
and ap.giorno = a.giorno;


--11--
select distinct s.nome, s.cognome, ap.giorno, p.nome,
       a.tipo, ap.oreDurata
from Persona s, AttivitaProgetto ap, Assenza a, Progetto p
where s.id = ap.persona and s.id = a.persona
and ap.progetto = p.id
and ap.giorno = a.giorno;



--12--
select distinct WP1.nome, p1.nome, p2.nome
from WP WP1, Progetto p1, WP WP2, Progetto p2
where WP1.progetto = p1.id
and WP1.nome = WP2.nome 
and WP1.progetto <> WP2.progetto
and WP2.progetto = p2.id;
