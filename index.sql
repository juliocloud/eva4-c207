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

-- Exercicio 2 

create table item (
    id int not null primary key,
    nome varchar(25),
    preco int,
    peso float,
    vol float
);

create table item_magico (
    id_item int not null primary key,
    efeito varchar(100),
    constraint fk2 foreign key(id_item) references item(id)
);

create table item_inventario (
    id_item int not null primary key,
    cap_peso float,
    cap_volume float,
    constraint fk3
        foreign key(id_item)
        references item(id)
);

create table item_arma (
    id_item int not null primary key,
    classe varchar(25),
    dano varchar(10),
    constraint fk4
        foreign key(id_item)
        references item(id)
);

insert into item values (1, "Ungento restaurador", 80, 0.2, 0.25);
insert into item values (2, "Poção de regeneração", 200, 0.2, 0.35);
insert into item values (3, "Bolsa de explorador", 20, 0.6, 1.2);
insert into item values (4, "Bolsa encantada", 500, 0.7, 1.1);
insert into item values (5, "Machado de guerra", 50, 15.5, 10.1);

insert into item_magico values (2, "Cicatriza ferimentos profundos (1d4+2 PV)");
insert into item_magico values (4, "Tem uma dimensão de bolso para armazenar itens");

insert into item_inventario values (3, 50, 23.6);
insert into item_inventario values (4, 1850, 1020);

insert into item_arma values (5, "Corpo-a-corpo pesada", "1d8");

select * from item as i left join item_magico as im 
on i.id = im.id_item 
left join item_inventario as ii on ii.id_item = i.id
left join item_arma as ia on ia.id_item = i.id;



