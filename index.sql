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

-- Exercicio 3

create table habilidade (
	id int not null primary key,
    atributo_base varchar(30)
);

insert into habilidade values (1, "Constituição"),
(2, "Força"),
(3, "Destreza"),
(4, "Destreza");

select atributo_base, count(*) as quantidade from habilidade group by atributo_base;

-- Exercicio 4

create table personagem (
	id int not null primary key,
    nome varchar(45),
    idade int,
    profissao varchar(45),
    data_criacao date,
    id_mundo int,
    constraint fk5 foreign key(id_mundo) references mundo(id)
);

create table habilidades_personagem (
	id_habilidade int not null,
    id_personagem int not null,
    modificador int,
    primary key(id_habilidade, id_personagem),
    constraint fk6 foreign key (id_habilidade) references habilidade(id),
    constraint fk7 foreign key (id_personagem) references personagem(id)
);

create table personagem_item (
	id_item int not null,
    id_personagem int not null,
    quantidade int,
    primary key(id_item, id_personagem),
    constraint fk8 foreign key (id_item) references item(id),
    constraint fk9 foreign key (id_personagem) references personagem(id)
);

insert into personagem () values 
(1, "Ann`aurora", 21, "Clériga", "2024-06-05", 1),
(2, "Zurendownr Narrwack", 652, "Diplomata", "2024-06-05", 1);

insert into habilidade () values
(5, "Corrida de arrancada"),
(6, "Corrida longa");

insert into habilidades_personagem () values 
(5, 1, 2),
(6, 1, 1);

insert into personagem_item () values 
(1, 1, 3),
(2, 1, 2),
(3, 1, 1);

delete from habilidades_personagem where id_habilidade = 6 and id_personagem = 1;

insert into habilidade values 
(7, "Acrobacia");

insert into habilidades_personagem () values 
(7, 2, 2);

select p.*, count(hp.id_habilidade) as quantidade_habilidade , count(pi.id_item) as quantidade_item from personagem as p 
 join habilidades_personagem as hp on p.id = hp.id_personagem
left join personagem_item as pi on p.id = pi.id_personagem group by p.id;

-- Exercicio 5

create table personagem_pagina (
	id_personagem int,
    id_pagina int,
    primary key(id_personagem, id_pagina),
    constraint fk10 foreign key (id_personagem) references personagem(id),
    constraint fk11 foreign key (id_pagina) references pagina(id)
);

select * from personagem as p where profissao = "Acólito" 
or profissao = "Acólita" 
or profissao = "Paladino" 
or profissao = "Paladina" 
or profissao = "Clérigo" 
or profissao = "Clériga" ;

create view receber_pag_1 as select p.id from personagem as p where profissao = "Acólito" 
or profissao = "Acólita" 
or profissao = "Paladino" 
or profissao = "Paladina" 
or profissao = "Clérigo" 
or profissao = "Clériga" ;


insert into personagem_pagina ()
select p.id, 1
from receber_pag_1 AS p;

select p.nome from personagem as p 
join personagem_pagina as pp on p.id = pp.id_personagem where pp.id_pagina = 1;

-- Exercicio 6

create table profissao_pagina (
    id_pagina int,
	profissao varchar(45),
    constraint fk12 foreign key (id_pagina) references pagina(id)
);

insert into profissao_pagina () values 
(1, "Clérigo"),
(1, "Clériga"),
(1, "Acólito"),
(1, "Acólita"),
(1, "Paladino"),
(1, "Paladina"),
(1, "Diplomata"),
(2, "Ladino"),
(2, "Ladina"),
(2, "Diplomata");

select  p.nome, group_concat(pag.titulo) from personagem as p
join profissao_pagina as pp on p.profissao = pp.profissao
join pagina as pag on pag.id = pp.id_pagina group by p.nome;

