//SET AUTOCOMMIT OFF;

INSERT INTO tura(id_interval)
values(1);

INSERT INTO tura(id_interval)
values(2);

INSERT INTO tura(id_interval,observatii)
values(3, 'tura de seara');

INSERT INTO ANGAJAT (cnp, id_angajat, prenume, nume, nr_telefon, email, salariu, rol,id_interval)
VALUES (1234567890123, 1, 'Barry', 'Newton', '0711223344', 'b.newton@gmail.com', 7000, 'director', 1);

INSERT INTO ANGAJAT (cnp, id_angajat, prenume, nume, nr_telefon, email, salariu, rol, id_interval)
VALUES (1234567890124, 501, 'Laura', 'Higgins', '0711223349', 'l.higgins@gmail.com', 5000, 'veterinar', 2);

INSERT INTO ANGAJAT (cnp, id_angajat, prenume, nume, nr_telefon, email, salariu, rol,id_interval)
VALUES (1234567890125, 2, 'Ralph', 'Patel', '0711223340', 'r.patel@gmail.com', 7000, 'director', 2);

INSERT INTO ANGAJAT (cnp, id_angajat, prenume, nume, nr_telefon, email, salariu, rol, id_interval)
VALUES (1234567890126, 502, 'Betty', 'Dancs', '0711223341', 'b.dancs@gmail.com', 5000, 'veterinar', 1);
 
INSERT INTO ANGAJAT (cnp, id_angajat, prenume, nume, nr_telefon, email, salariu, rol,id_interval)
VALUES (1234567890127, 200, 'Ben', 'Biri', '0711223342', 'b.biri@gmail.com', 6000, 'manager', 3);

INSERT INTO ANGAJAT (cnp, id_angajat, prenume, nume, nr_telefon, email, salariu, rol, id_interval)
VALUES (1234567890128, 300, 'Chad', 'Newman', '0711223343', 'c.newman@gmail.com', 4000, 'ingrijitor', 2);


SELECT * FROM angajat;

INSERT INTO ANIMAL(nume,specie,data_sosire)
VALUES('Biscuit','pisica',sysdate);

INSERT INTO detalii_animal(animal_id,rasa,varsta)
VALUES((select animal_id from animal where nume like '%Biscuit%'),'europeana',0.6);

INSERT INTO ANIMAL(nume,specie,data_sosire)
VALUES('Lexi','caine',TO_DATE ('APRIL 10,2018', 'MON DD, YYYY'));

INSERT INTO detalii_animal(animal_id,rasa,varsta)
VALUES((select animal_id from animal where nume like '%Lexi%'),'Golden Retriever',6);

INSERT INTO ANIMAL(nume,specie,data_sosire)
VALUES('Barnie','hamster',TO_DATE ('JULY 20,2024', 'MON DD, YYYY'));

INSERT INTO detalii_animal(animal_id,rasa,varsta)
VALUES((select animal_id from animal where nume like '%Barnie%'),' ',0.9);

INSERT INTO ANIMAL(nume,specie,data_sosire)
VALUES('Pingu','pinguin',TO_DATE ('FEB 21,2020', 'MON DD, YYYY'));

INSERT INTO detalii_animal(animal_id,rasa,varsta)
VALUES((select animal_id from animal where nume like '%Pingu%'),'',8);

insert into animal(nume,data_sosire,specie)
values('Coco',sysdate,'papagal');

SELECT * FROM animal;

select * from detalii_animal;

INSERT INTO client (cnp, prenume, nume, nr_telefon, adresa,email)
VALUES (9234567890124, 'Michael', 'Harriss', '0911223344', 'Leopold St','m.harris@gmail.com');

INSERT INTO client (cnp, prenume, nume, nr_telefon, adresa,email)
VALUES (9234567890129, 'Clara', 'Mural', '0911223349', 'King St','c.mural@gmail.com');

INSERT INTO client (cnp, prenume, nume, nr_telefon, adresa,email)
VALUES (9234567890120, 'Alexander', 'Hunold', '0911223340', 'Abbey Road','a.hunold@gmail.com');

INSERT INTO client (cnp, prenume, nume, nr_telefon, adresa,email)
VALUES (9234567890121, 'Bruce', 'Ernst', '0911223341', 'Main St','b.ernst@gmail.com');

INSERT INTO client (cnp, prenume, nume, nr_telefon, adresa,email)
VALUES (9234567890122, 'Diana', 'Lorentz', '0911223342', 'Adam St','d.lorentz@gmail.com');

INSERT INTO client (cnp, prenume, nume, nr_telefon, adresa,email)
VALUES (9234567890123, 'Curtis', 'Davis', '0911223343', 'Main St','c.davis@gmail.com');


SELECT * FROM client;

INSERT INTO cusca(dimensiune)
VALUES('enorma');

INSERT INTO cusca(dimensiune)
VALUES('enorma');

INSERT INTO cusca(dimensiune)
VALUES('mare');

INSERT INTO cusca(dimensiune)
VALUES('medie');

INSERT INTO cusca(dimensiune)
VALUES('mica');

INSERT INTO cusca(dimensiune)
VALUES('mica');

INSERT INTO cusca(dimensiune)
VALUES('minuscula');

select * from cusca;

INSERT INTO lista_de_habitatie(data_inceput,animal_id,id_cusca)
VALUES (sysdate,(select animal_id from animal where nume like '%Biscuit'),(select id_cusca from cusca where dimensiune like '%mica%' and ROWNUM = 1));


update cusca
set status='ocupata'
where id_cusca=(select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id where animal.nume like 'Biscuit' and lista_de_habitatie.data_inceput=sysdate);

INSERT INTO lista_de_habitatie(data_inceput,data_final,animal_id,id_cusca)
VALUES (TO_DATE ('APRIL 10,2018', 'MON DD, YYYY'),sysdate-2,(select animal_id from animal where nume like '%Lexi'),(select id_cusca from cusca where dimensiune like '%mare%' and ROWNUM = 1));


INSERT INTO lista_de_habitatie(data_inceput,animal_id,id_cusca)
VALUES (sysdate-1,(select animal_id from animal where nume like '%Lexi'),(select id_cusca from cusca where dimensiune like '%enorma%' and ROWNUM = 1 ));


update cusca
set status='ocupata'
where id_cusca=(select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id where animal.nume like 'Lexi' and lista_de_habitatie.data_inceput=sysdate);

INSERT INTO lista_de_habitatie(data_inceput,data_final,animal_id,id_cusca)
VALUES (TO_DATE ('FEB 21,2020', 'MON DD, YYYY'),sysdate-1,(select animal_id from animal where nume like '%Pingu'),(select id_cusca from cusca where dimensiune like '%minuscula%' and status='libera' and ROWNUM = 1));


INSERT INTO lista_de_habitatie(data_inceput,animal_id,id_cusca)
VALUES (sysdate,(select animal_id from animal where nume like '%Pingu'),(select id_cusca from cusca where dimensiune like '%medie%' and status='libera' and ROWNUM = 1));


update cusca
set status='ocupata'
where id_cusca=(select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id where animal.nume like 'Pingu' and lista_de_habitatie.data_inceput=sysdate);


INSERT INTO lista_de_habitatie(data_inceput,animal_id,id_cusca)
VALUES (sysdate,(select animal_id from animal where nume like '%Coco'),(select id_cusca from cusca where dimensiune like '%mica%'  and status='libera' and ROWNUM = 1));

update cusca
set status='ocupata'
where id_cusca=(select id_cusca from lista_de_habitatie join animal  on lista_de_habitatie.animal_id=animal.animal_id where animal.nume like 'Coco' and lista_de_habitatie.data_inceput=sysdate);


select * from lista_de_habitatie;

INSERT INTO contract(data_inregistrare,tip,animal_id,cnp)
values(sysdate,'donatie',(select animal_id from animal where nume like '%Biscuit%'),(select cnp from client where prenume like '%Michael%'));

INSERT INTO contract(data_inregistrare,tip,animal_id,cnp)
values(sysdate-1,'adoptie',(select animal_id from animal where nume like '%Lexi%'),(select cnp from client where prenume like '%Clara%'));

INSERT INTO contract(data_inregistrare,tip,motiv,animal_id,cnp)
values(TO_DATE ('APRIL 10,2018', 'MON DD, YYYY'),'donatie','animal agitat',(select animal_id from animal where nume like '%Lexi%'),(select cnp from client where prenume like '%Clara%'));

insert into contract(data_inregistrare,tip,motiv,animal_id,cnp)
values(sysdate,'donatie','galagios',(select animal_id from animal where nume like 'Coco'),(select cnp from client where nume like 'Harriss'));
select * from contract;

insert into contract(data_inregistrare,tip,motiv,animal_id,cnp)
values(sysdate,'donatie','necesita mediu rece',(select animal_id from animal where nume like 'Pingu'),(select cnp from client where nume like 'Davis'));

insert into contract(data_inregistrare,tip,motiv,animal_id,cnp)
values(sysdate,'donatie','prea fragil',(select animal_id from animal where nume like 'Barnie'),(select cnp from client where nume like 'Lorentz'));
select * from contract;


INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(sysdate,(select id_angajat from angajat where nume like '%Higgins'),(select animal_id from animal where nume like '%Biscuit%'),'examinare sosire');

INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(sysdate,(select id_angajat from angajat where nume like '%Higgins'),(select animal_id from animal where nume like '%Lexi%'),'examinare sosire');

INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(TO_DATE ('JULY 20,2024', 'MON DD, YYYY'),(select id_angajat from angajat where nume like '%Higgins'),(select animal_id from animal where nume like '%Barnie%'),'examinare sosire');

INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(TO_DATE ('APRIL 10,2018', 'MON DD, YYYY'),(select id_angajat from angajat where nume like '%Higgins'),(select animal_id from animal where nume like '%Lexi%'),'examinare sosire');

INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(TO_DATE ('FEB 21,2020', 'MON DD, YYYY'),(select id_angajat from angajat where nume like '%Higgins'),(select animal_id from animal where nume like '%Pingu%'),'examinare sosire');

INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(sysdate,(select id_angajat from angajat where nume like '%Higgins'),(select animal_id from animal where nume like '%Coco%'),'examinare sosire');

INSERT INTO examinare_clinica(data_inregistrare,id_angajat,animal_id,observatii_clinice)
values(TO_DATE ('FEB 21,2022', 'MON DD, YYYY'),(select id_angajat from angajat where nume like '%Dancs'),(select animal_id from animal where nume like '%Lexi%'),'castrare');

select * from examinare_clinica;



select * from tura;

//ROLLBACK;
