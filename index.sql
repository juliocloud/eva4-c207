drop database if exists bd;
create database bd;
use bd;

-- Exercicio 1

create table mundo (
    id int not null primary key,
    nome varchar(45) not null,
    descricao varchar(200) not null
);

create table pagina (
    id int not null primary key,
    titulo varchar(45) not null,
    descricao varchar(200) not null,
    id_mundo int,
    constraint fk1 
        foreign key(id_mundo)
        references mundo(id)
);

insert into mundo values 
(1, "Maygïk", "Uma teocracia aliada aos magnatas exploradores regem esse mundo. Os desafios vão muito além do que você espera.");

insert into mundo values 
(2, "Lucinera", "O mundo é dominado por dragões. Como você vai trilhar o seu caminho:  Para livrar o seu povo ou para ascender como um senhor dos dragões?");

insert into pagina values 
(1, "O Culto do Heroi", "Uma sociedade religiosa que segue os passos do Heroi que salvou Granjaran dos sombrios.", 1),
(2, "Uanteji", "Uma organização secreta de mercenários, espiões e assassinos.", 1);

select p.titulo, p.descricao, m.nome from pagina as p join mundo as m on m.id = p.id_mundo;
