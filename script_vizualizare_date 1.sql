// Script vizualizare date

//pt angajati se retin: tura lucrata, examinarile clinice efectuate(daca sunt veterinari),rolul lor in cadrul adapostului si alte date corespunzatoare statutului
// de asemenea se evidentiaza atributia speciala a veterinarului de a conduce examinari clinice
select a.id_angajat as ID, a.nume||' '||a.prenume Nume,a.nr_telefon Telefon,a.email,a.salariu,a.rol,e.id_examinare,animal.nume,t.observatii
from angajat a 
left outer join tura t on a.id_interval=t.id_interval
left outer join examinare_clinica e
on a.id_angajat=e.id_angajat
left join animal
on e.animal_id=animal.animal_id;


//pt fiecare animal se retin: detalii precum rasa/varsta, datele calendaristice in care a fost adoptat/donat, motivul donatiei catre adapost,cat si clientii responsabil de acestia, examinarile clinice la care a fost supus si veterinarul care le-a efectuat si custile in care a locuit pe parcursul sederii in adapost
select a.animal_id,a.nume,a.specie,d.rasa,d.varsta,contract.data_inregistrare "Data adoptie/donatie",contract.tip "Adoptie/donatie",contract.motiv "Motiv" ,client.nume||' '||client.prenume "Nume client",e.data_inregistrare "Data examinare clinica",angajat.nume||' '||angajat.prenume "Nume veterinar",l.data_inceput "Inceputul sederii",cusca.id_cusca,cusca.dimensiune
from animal a
left outer join detalii_animal d
on a.animal_id=d.animal_id
left outer join contract
on a.animal_id=contract.animal_id
left outer join client on contract.cnp=client.cnp
left outer join examinare_clinica e on a.animal_id=e.animal_id
left outer join angajat on e.id_angajat=angajat.id_angajat
left outer join lista_de_habitatie l on a.animal_id=l.animal_id
left outer join cusca on l.id_cusca=cusca.id_cusca;


//pt fiecare client se retine istoricul de adoptii/donatii si alte date specifice statului
select c.cnp "CNP client",c.nume||' '||c.prenume "Nume cleint",c.adresa "Adresa client", '+4'||c.nr_telefon "Nr tel client",c.email,contract.tip "Adoptie/donatie",contract.motiv "Motiv",contract.data_inregistrare "Data",animal.nume "Nume animal"
from client c
left outer join contract on c.cnp=contract.cnp
left outer join animal on contract.animal_id=animal.animal_id;

//listele de habitație sunt folosite pentru a ști în ce cușcă este plasat fiecare animal, precum și perioada în care cușca este ocupată
select c.id_cusca,l.data_inceput,l.data_final,a.nume
from lista_de_habitatie l 
inner join cusca c on l.id_cusca=c.id_cusca
left outer join  animal a on a.animal_id=l.animal_id;


