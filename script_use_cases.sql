// use-case 1 -> adaugare animal donat de un client in adapost

ACCEPT use_case1_nume CHAR PROMPT 'Use_case_1 Introduceti numele animalului:';
ACCEPT use_case1_data DATE FORMAT 'dd/mm/yyyy' PROMPT 'Use_case_1 Introduceti data de sosire a animalului:';
ACCEPT use_case1_specie CHAR PROMPT 'Use_case_1 Introduceti specia animalului:';
BEGIN
-- se adauga animalul in sistem
SAVEPOINT use_case_1;
INSERT INTO animal(nume,data_sosire,specie)
values('&&use_case1_nume',TO_DATE('&&use_case1_data','dd/mm/yyyy'),'&&use_case1_specie');

-- se realizeaza o examinare clinica la sosirea animalului
INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(TO_DATE('&&use_case1_data','dd/mm/yyyy'),(select id_angajat from angajat where nume like '%Higgins'),(select animal_id from animal where nume='&&use_case1_nume'),'examinare sosire');

-- se muta animalul intr-o cusca libera si potrivita
INSERT INTO lista_de_habitatie(data_inceput,animal_id,id_cusca)
VALUES (TO_DATE('&&use_case1_data','dd/mm/yyyy'),(select animal_id from animal where nume='&&use_case1_nume'),(select id_cusca from cusca where dimensiune like '%mica%'  and status='libera' and ROWNUM = 1));

-- se schimba statusul custii in 'ocupata'
update cusca
set status='ocupata'
where id_cusca=(select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id where animal.nume='&&use_case1_nume' and lista_de_habitatie.data_inceput=TO_DATE('&&use_case1_data','dd/mm/yyyy'));

-- se intocmeste contractul de donatie
INSERT INTO contract(data_inregistrare,tip,animal_id,cnp)
values(TO_DATE('&&use_case1_data','dd/mm/yyyy'),'donatie',(select animal_id from animal where nume='&&use_case1_nume'),(select cnp from client where prenume like '%Michael%'));
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO use_case_1;
        -- RAISE;
END;
/
//use-case 2 -> mutare animal in alta cusca



// se elibereaza cusca in care sta animalul
update cusca
set status='libera'
where id_cusca=(select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id where animal.nume like 'Juno' and lista_de_habitatie.data_inceput=TO_DATE ('FEB 21,2020', 'MON DD, YYYY'));

//se actualizeaza lista de habitatie
update lista_de_habitatie
set data_final=sysdate
where animal_id=(select animal_id from animal where nume like 'Juno') and data_inceput=TO_DATE ('FEB 21,2020', 'MON DD, YYYY');

//se muta animalul 
INSERT INTO lista_de_habitatie(data_inceput,animal_id,id_cusca)
VALUES (sysdate,(select animal_id from animal where nume like '%Juno'),(select id_cusca from cusca where dimensiune like '%mica%'  and status='libera' and ROWNUM = 1));

//se schimba statusul custii in 'ocupata'
update cusca
set status='ocupata'
where id_cusca=(select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id where animal.nume like 'Juno' and lista_de_habitatie.data_inceput=sysdate);




-- use-case 3 -> adoptia unui animal

ACCEPT use_case3_nume CHAR PROMPT 'Use_case_3 Introduceti numele animalului:';
ACCEPT use_case3_data DATE FORMAT 'dd/mm/yyyy' PROMPT 'Use_case_3 Introduceti data adoptiei:';
ACCEPT use_case3_nume_client CHAR PROMPT 'Use_case_3 numele clientului:';
-- intocmire contract de adoptie

BEGIN
SAVEPOINT use_case_3;

-- eliberare cusca
update cusca
set status='libera'
where id_cusca=(select id_cusca from (select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id WHERE animal.nume='&&use_case3_nume' and lista_de_habitatie.data_final is null  ORDER BY lista_de_habitatie.data_inceput DESC) where ROWNUM=1);

-- actualizare lista de habitatie 
update lista_de_habitatie
set data_final=TO_DATE('&&use_case3_data','dd/mm/yyyy')
where id_habitatie=(select id_habitatie from (select id_habitatie from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id WHERE animal.nume='&&use_case3_nume' and lista_de_habitatie.data_final is null  ORDER BY lista_de_habitatie.data_inceput DESC) where ROWNUM=1);

-- intocmim contractul de adoptie
INSERT INTO contract(data_inregistrare,tip,animal_id,cnp)
values(TO_DATE('&&use_case3_data','dd/mm/yyyy'),'adoptie',(select animal_id from animal where nume='&&use_case3_nume'),(select cnp from client where nume='&&use_case3_nume_client' ));

COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO use_case_3;
END;
/

//use-case 4 Determinarea procentelor tipurilor de animale(consideram doar caini,pisici,papagali) adaugate in ultima luna

select count(*) Total,sum((case specie WHEN 'caine' THEN 1 ELSE 0 END))*100/count(*) "Procent caini", sum((case specie WHEN 'pisica' THEN 1 ELSE 0 END))*100/count(*) "Procent pisici",sum((case specie WHEN 'papagal' THEN 1 ELSE 0 END))*100/count(*) "Procent papagali"
from animal a 
join contract c on 
a.animal_id=c.animal_id 
join lista_de_habitatie l  
on l.animal_id=c.animal_id
where c.tip='donatie' 
and MONTHS_BETWEEN(c.data_inregistrare,sysdate)<2
and l.data_final is null;

// use-case 5 Determinarea  animalelor prezente in adapost la momentul curent

select a.nume, a.specie
from animal a 
join contract c on 
a.animal_id=c.animal_id 
join lista_de_habitatie l  
on l.animal_id=c.animal_id
where c.tip='donatie' 
and l.data_final is null;

// use-case 6 Determinarea custilor curente ale animalelor

select a.nume,l.data_inceput,l.id_cusca
from animal a
join lista_de_habitatie l
on a.animal_id=l.animal_id
where l.data_final is null;

//use-case 7 Determinarea clientilor care au adoptat/donat un animal in ultimele 6 luni

select cl.prenume||' '||cl.nume "Nume client",co.data_inregistrare,(select nume from animal where co.animal_id=animal_id) "Nume animal"
from client cl
join contract co
on cl.cnp=co.cnp
where months_between(sysdate,co.data_inregistrare)<7;

//use-case 8 Determinarea examinarilor clinice pentru fiecare animal 

select a.nume,e.data_inregistrare,(select prenume||' '||nume from angajat where id_angajat=e.id_angajat) "Nume veterinar"
from animal a 
join examinare_clinica e
on a.animal_id=e.animal_id;




