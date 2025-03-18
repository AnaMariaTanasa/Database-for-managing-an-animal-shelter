//testare constrangeri
set autocommit off
//testare PK, NN, UK, CK, FK tura

//check constraint (BD_PROIECT_INCERCARI.SHIFT_VAL) violated ->constrangere id_interval={1,2,3}
insert into tura(id_interval)
values(0);

//unique constraint (BD_PROIECT_INCERCARI.SHIFT_PK) violated -> constrangere unique pt id_interval nu este respectata atunci cand avem mai multe ture cu ac id
update tura
set id_interval=1
where id_interval=2;

//NN constraint id_interval
//Mesaj eroare: cannot insert NULL into ("BD_PROIECT_INCERCARI"."TURA"."ID_INTERVAL")

insert into tura
values(null,' ');


//testare PK, NN, UK, CK, FK  angajat

//UK nu a fost respectata pt id_angajat
//Mesaj eroare: unique constraint (BD_PROIECT_INCERCARI.EMPLOYEE_PK) violated
update angajat
set id_angajat=(select id_angajat from angajat where nume like 'Newton')

//NN nu a fost respectata pt id_angajat
//Mesaj eroare: cannot update ("BD_PROIECT_INCERCARI"."ANGAJAT"."ID_ANGAJAT") to NULL
update angajat
set id_angajat=null;

//UK pt cnp si nr de telefon 
//Mesaj eroare: unique constraint (BD_PROIECT_INCERCARI.UNIQUE_KEY_EMPLOYEE) violated
update angajat
set nr_telefon=(select nr_telefon from angajat where nume like 'Newton'),
cnp=(select cnp from angajat where nume like 'Newton');

//ck pt lungime cnp==13
//Mesaj eroare: check constraint (BD_PROIECT_INCERCARI.Employee CNP Length) violated
update angajat 
set cnp=1010

//ck pt id_angajat>=0
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Employee id min) violated
update angajat
set id_angajat=-1;

//NN prenume
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."ANGAJAT"."PRENUME") to NULL
update angajat
set prenume=null;

//ck pt continutul prenumelui: doar litere,spatii si linie
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Employee first name content) violated
update angajat
set prenume='123';

//NN nume
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."ANGAJAT"."NUME") to NULL
update angajat
set nume=null;

//ck pt continutul nume: doar litere,spatii si linie
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Employee last name content) violated
update angajat
set nume='123';

//NN email
//Mesaj de eroare:  cannot update ("BD_PROIECT_INCERCARI"."ANGAJAT"."EMAIL") to NULL
update angajat
set email=null;

//ck pt continutul de tip email
//Mesaj de eroare:check constraint (BD_PROIECT_INCERCARI.Employeee email content) violated
update angajat
set email='abcd';

//NN salariu
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."ANGAJAT"."SALARIU") to NULL
update angajat
set salariu=null;

//ck salariu>0
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Employee min salary) violated
update angajat
set salariu=-1;

//check constraint nr de telefon
//phone number constraint violated->nr de telefon trb sa aiba fix 10 cf,aici are 9
insert into angajat(cnp,id_angajat,prenume,nume,nr_telefon,email,salariu,rol,id_interval)
values(1234567890125,502,'Angela','Merkel','017998866','a.merkel@gmail.com',5000,'veterinar',3);


//NN rol
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."ANGAJAT"."ROL") to NULL
update angajat
set rol=null;

//ck valori coloana rol
//Mesaj eroare: check constraint (BD_PROIECT_INCERCARI.Employee job types) violated
update angajat
set rol='abcd';

//verificare FK Angajat
//integrity constraint (BD_PROIECT_INCERCARI.TURA_ANGAJAT_FK) violated - parent key not found ->tura cu id_interval nr 3 nu exista in baza de date
insert into angajat(cnp,id_angajat,prenume,nume,nr_telefon,email,salariu,rol,id_interval)
values(1234567890125,502,'Angela','Merkel','0799887766','a.merkel@gmail.com',5000,'veterinar',3);
select * from angajat;

//testare PK, NN, UK, CK, FK cusca
INSERT INTO cusca (id_cusca, dimensiune)
VALUES (200, 'mare');

//PK/UK pt id_cusca: nu exista duplicate
//Mesaj eroare:unique constraint (BD_PROIECT_INCERCARI.CAGE_PK) violated
INSERT INTO cusca (id_cusca, dimensiune)
VALUES (200, 'enorma');

//NN pt id_cusca :daca este null intervine autoincrement, deci nu este eronat
INSERT INTO cusca (id_cusca, dimensiune)
VALUES (null, 'enorma');

//ck p valori cusca
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Cage dim val) violated
INSERT INTO cusca (id_cusca, dimensiune)
VALUES (201, 'large');

////testare PK, NN, UK, CK, FK client
INSERT INTO client (cnp, prenume, nume, adresa, nr_telefon, email)
VALUES (9876543210987, 'Laura', 'Wilson', 'Main St', '1112223333', 'l.wilson@gmail.com');

//PK pt cnp
//Mesaj eroare:unique constraint (BD_PROIECT_INCERCARI.CLIENT_PK) violated
INSERT INTO client (cnp, prenume, nume, adresa, nr_telefon, email)
VALUES (9876543210987, 'Tom', 'Taylor', 'Elm St', '4445556666', 't.taylor@example.com');

//UK pt nr_telefon
//Mesaj eroare: unique constraint (BD_PROIECT_INCERCARI.CLIENT_UNIQUE) violated
update client
set nr_telefon='1112223333';

//NN nr_telefon
//Mesaj eroare: cannot update ("BD_PROIECT_INCERCARI"."CLIENT"."NR_TELEFON") to NULL
update client
set nr_telefon=null;

//ck pt lungime cnp==13
//Mesaj eroare: check constraint (BD_PROIECT_INCERCARI.Client CNP Length) violated
update client 
set cnp=1010;

//NN prenume
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."CLIENT"."PRENUME") to NULL
update client
set prenume=null;

//ck pt continutul prenumelui: doar litere,spatii si linie
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Client first name content) violated
update client
set prenume='123';

//NN nume
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."CLIENT"."NUME") to NULL
update client
set nume=null;

//ck pt continutul nume: doar litere,spatii si linie
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Client last name content) violated
update client
set nume='123';

//ck pt continutul de tip email
//Mesaj de eroare:check constraint (BD_PROIECT_INCERCARI.Client email content) violated
update client
set email='abcd';

//NN adresa
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."CLIENT"."ADRESA") to NULL
update client
set adresa=null;

//ck continut adresa
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Client address content) violated
update client
set adresa='asdas???';

//testare PK, NN, UK, CK, FK  animal


//PK animal_id
//Mesaj eroare: unique constraint (BD_PROIECT_INCERCARI.ANIMAL_PK) violated
INSERT INTO animal (animal_id, nume, specie, data_sosire)
VALUES (1, 'Leo', 'pisica', SYSDATE - 1);

INSERT INTO animal (animal_id, nume, specie, data_sosire)
VALUES (1, 'Milo', 'caine', SYSDATE);

//NN animal_id
//Mesaj eroare: cannot update ("BD_PROIECT_INCERCARI"."ANIMAL"."ANIMAL_ID") to NULL
update animal
set animal_id=null;

//ck pt continut specie
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Species name content) violated
INSERT INTO animal (animal_id, nume, specie, data_sosire)
VALUES (2, 'Bella', '12345', SYSDATE);

//NN specie
//Mesaj eroare: cannot update ("BD_PROIECT_INCERCARI"."ANIMAL"."SPECIE") to NULL
update animal
set specie=null;

//ck pt continut nume
//Mesaj eroare:ccheck constraint (BD_PROIECT_INCERCARI.Animal name content) violated
INSERT INTO animal (animal_id, nume, specie, data_sosire)
VALUES (2, '1234', 'caine', SYSDATE);

//NN nume
//Mesaj eroare: caannot update ("BD_PROIECT_INCERCARI"."ANIMAL"."NUME") to NULL
update animal
set nume=null;

//ck pt continut data_sosire
//Mesaj eroare: Data invalida: 09.12.2024 16:51:16trebuie sa fie mai mic decat data curenta.
INSERT INTO animal (animal_id, nume, specie, data_sosire)
VALUES (2, 'Bella', 'caine', sysdate+1);

//NN data_sosire
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."ANIMAL"."DATA_SOSIRE") to NULL
update animal
set data_sosire=null;

//testare PK, NN, UK, CK, FK lista_de_habitatie

//PK 
//Mesaj eroare: unique constraint (BD_PROIECT_INCERCARI.HABITATION_LIST_PK) violated
INSERT INTO lista_de_habitatie (id_habitatie, data_inceput, animal_id, id_cusca)
VALUES (150, SYSDATE - 1, (select animal_id from animal where nume like 'Benny'), (select id_cusca from cusca where dimensiune like 'mare'));


INSERT INTO lista_de_habitatie (id_habitatie, data_inceput,  animal_id, id_cusca)
VALUES (150, SYSDATE, (select animal_id from animal where nume like 'Benny'), (select id_cusca from cusca where dimensiune like 'mare'));

//nn lista_de_habitatie
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."LISTA_DE_HABITATIE"."ID_HABITATIE") to NULL
update lista_de_habitatie
set id_habitatie=null;

//nn animal_id
//Mesaj eroare:  cannot update ("BD_PROIECT_INCERCARI"."LISTA_DE_HABITATIE"."ANIMAL_ID") to NULL

update lista_de_habitatie
set animal_id=null;

//nn id_cusca
//Mesaj eroare: cannot update ("BD_PROIECT_INCERCARI"."LISTA_DE_HABITATIE"."ID_CUSCA") to NULL
update lista_de_habitatie
set id_cusca=null;

//fk animal_id
//Mesaj eroare:  integrity constraint (BD_PROIECT_INCERCARI.ANIMAL_LISTA_DE_HABITATIE_FK) violated - parent key not found

update lista_de_habitatie
set animal_id=99999;

//fk id_cusca
//Mesaj eroare: integrity constraint (BD_PROIECT_INCERCARI.CUSCA_LISTA_DE_HABITATIE_FK) violated - parent key not found
update lista_de_habitatie
set id_cusca=1;

//nn data_inceput
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."LISTA_DE_HABITATIE"."DATA_INCEPUT") to NULL

update lista_de_habitatie
set data_inceput=null;

//ck data de inceput
//Mesaj eroare:Data invalida: 13.12.2024 16:59:47trebuie sa fie mai mic decat data curenta.

update lista_de_habitatie
set data_inceput=sysdate+5;

//testare PK, NN, UK, CK, FK detalii_animal
//PK animal_id
//Mesaj eroare:unique constraint (BD_PROIECT_INCERCARI.DETALII_ANIMAL_PK) violated
INSERT INTO detalii_animal (rasa, varsta, (select animal_id from animal where nume like 'Benny'))
VALUES ('', 2.5, 1);

INSERT INTO detalii_animal (rasa, varsta, animal_id)
VALUES ('', 3.0, (select animal_id from animal where nume like 'Benny'));

//Fk
//Mesaj eroare:integrity constraint (BD_PROIECT_INCERCARI.ANIMAL_DETALII_ANIMAL_FK) violated - parent key not found
update detalii_animal
set animal_id=999;

////testare PK, NN, UK, CK, FK contract

//pk
//Mesaj eroare:
INSERT INTO contract (id_contract, data_inregistrare, tip, animal_id, cnp)
VALUES (100, SYSDATE - 1, 'adoptie', (select animal_id from animal where nume like 'Benny'),(select cnp from client where nume like 'Harriss') );


INSERT INTO contract (id_contract, data_inregistrare, tip, animal_id, cnp)
VALUES (100, SYSDATE, 'donatie', (select animal_id from animal where nume like 'Benny'),(select cnp from client where nume like 'Harriss'));
//fk animal_id
//Mesaj eroare:integrity constraint (BD_PROIECT_INCERCARI.ANIMAL_CONTRACT_FK) violated - parent key not found
update contract
set animal_id=999;

//nn animal_id
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."CONTRACT"."ANIMAL_ID") to NULL
update contract
set animal_id=null;

//fk cnp
//Mesaj eroare:integrity constraint (BD_PROIECT_INCERCARI.CLIENT_CONTRACT_FK) violated - parent key not found
update contract
set cnp=0000967890123;

//nn cnp
//Mesaj eroare: cannot update ("BD_PROIECT_INCERCARI"."CONTRACT"."CNP") to NULL
update contract
set cnp=null;

//nn data_inregistrare
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."CONTRACT"."DATA_INREGISTRARE") to NULL
update contract
set data_inregistrare=null;

//ck valoare data_inregistrare
//Mesaj eroare:Data invalida: 13.12.2024 17:11:31trebuie sa fie mai mic decat data curenta.
update contract
set data_inregistrare=sysdate+5;

//nn tip
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."CONTRACT"."TIP") to NULL
update contract
set tip=null;

//ck valoare tip
//Mesaj eroare:check constraint (BD_PROIECT_INCERCARI.Contract type) violated
update contract
set tip='abc';

//testare PK, NN, UK, CK, FK examinare_clinica

//pk
//mesaj eroare: unique constraint (BD_PROIECT_INCERCARI.CLINICAL_EXAMINATION_PK) violated
INSERT INTO examinare_clinica (id_examinare, data_inregistrare, observatii_clinice, id_angajat, animal_id)
VALUES (50, SYSDATE - 2, 'Routine checkup', (select id_angajat from angajat where nume like 'Higgins'), (select animal_id from animal where nume like 'Benny'));


INSERT INTO examinare_clinica (id_examinare, data_inregistrare, observatii_clinice, id_angajat, animal_id)
VALUES (50, SYSDATE, 'Follow-up exam',  (select id_angajat from angajat where nume like 'Higgins'), (select animal_id from animal where nume like 'Lexi'));

//fk animal_id
//Mesaj eroare:integrity constraint (BD_PROIECT_INCERCARI.ANIMAL_EXAMINARE_CLINICA_FK) violated - parent key not found
update examinare_clinica
set animal_id=9999;

//fk id_angajat
//Mesaj eroare:integrity constraint (BD_PROIECT_INCERCARI.ANGAJAT_EXAMINARE_CLINICA_FK) violated - parent key not found
update examinare_clinica
set id_angajat=9999;

//nn data_inregistrare
//Mesaj eroare:cannot update ("BD_PROIECT_INCERCARI"."EXAMINARE_CLINICA"."DATA_INREGISTRARE") to NULL
update examinare_clinica
set data_inregistrare=null;

//ck val data_inregistrare
//Mesaj eroare:Data invalida: 13.12.2024 17:18:27trebuie sa fie mai mic decat data curenta.
update examinare_clinica
set data_inregistrare=sysdate+5;


rollback;