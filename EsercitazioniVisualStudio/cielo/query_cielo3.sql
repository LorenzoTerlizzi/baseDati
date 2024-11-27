--qual'è la durata media, per ogni compagnia, dei voli che partono da un aeroporto situato in italia

select v.comp, avg(v.durataMinuti)
from Volo v, ArrPart ap, LuogoAeroporto la
where ap.codice = v.codice and v.comp = ap.comp and ap.codice = la.aereoporto
and la.nazione = 'Italia'
group by v.comp;

      
