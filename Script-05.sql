create database db_academia;

use db_academia;

create table planos(
	id int auto_increment primary key,
	nome varchar(50) not null,
	valor_mensal decimal(10,2) not null,
	duracao_meses tinyint not null
);


create table alunos(
	id int auto_increment primary key,
	nome varchar(100) not null,
	cpf char(11) unique not null,
	data_nasciment date,
	email varchar(100),
	peso decimal(5,2),
	altura decimal(3,2),
	id_plano int,
	constraint fk_aluno_plano foreign key(id_plano)references planos(id)
);
create table instrutores(
	id int auto_increment primary key,
	nome varchar(100) not null,
	especialidades varchar(50),
	data_contratacao date
);

create table treinos (
	id int auto_increment primary key,
	id_aluno int not null,
	id_instrutor int not null,
	data_criacao date not null,
	objetivo varchar(100),
	constraint fk_treino_aluno foreign key(id_aluno)
	references alunos(id),
	constraint fk_treino_instrutor foreign key(id_instrutor)
	references instrutores(id)
);
create table exercicios(
	id int auto_increment primary key,
	nome_exercicio varchar(50) not null,
	equipamento varchar(50)
);
create table itens_treino(
	id_treino int,
	id_exercicio int,
	series tinyint,
	repeticoes tinyint,
	primary key (id_treino, id_exercicio),
	constraint fk_item_treino foreign key(id_treino)
	references treinos(id),
	constraint fk_item_exercicio foreign key(id_exercicio)
	references exercicios(id)
);
INSERT INTO planos (nome, valor_mensal, duracao_meses) VALUES 
('Plano Mensal Bronze', 90.00, 1),
('Plano Trimestral Prata', 150.00, 3),
('Plano Semestral Ouro', 250.00, 6),
('Plano Anual Black', 1200.00, 12),
('Plano de Teste', 0.00, 1);

INSERT INTO alunos (nome, cpf, data_nasciment, email, peso, altura, id_plano) VALUES 
('Carlos Silva', '12345678901', '1960-05-15', 'carlos@email.com', 95.50, 1.68, 4),
('Ana Souza', '23456789012', '2009-10-20', 'ana.souza@email.com', 55.00, 1.62, 1),
('Ricardo Oliveira', '34567890123', '1995-03-10', 'ricardo@email.com', 110.00, 1.85, 2),
('Mariana Costa', '45678901234', '1985-08-25', 'mariana@gmail.com', 62.00, 1.70, 3),
('Pedro Santos', '56789012345', '1965-12-30', 'pedro@email.com', 88.00, 1.75, 4),
('Julia Lima', '87192753917', '2010-01-05', 'julia@email.com', 48.00, 1.55, 1);

INSERT INTO instrutores (nome, especialidades, data_contratacao) VALUES 
('Renato Personal', 'Musculação', '2024-06-01'),
('Fabiana Zen', 'Yoga', '2025-02-15'),
('Marcos Iron', 'Crossfit', '2026-01-10'),
('Cláudia Dance', 'Zumba', '2025-11-20');

INSERT INTO treinos (id_aluno, id_instrutor, data_criacao, objetivo) VALUES 
(1, 1, '2026-04-01', 'Perda de Peso'),
(3, 3, '2026-04-10', 'Hipertrofia'),
(2, 1, '2026-04-12', 'Condicionamento'),
(5, 4, '2025-12-15', 'Fisioterapia');

INSERT INTO exercicios (nome_exercicio, equipamento) VALUES 
('Supino Reto', 'Barra'),
('Supino Inclinado', 'Haltere'),
('Agachamento Hack', 'Máquina'),
('Rosca Direta', 'Halter'),
('Leg Press 45', 'Máquina'),
('Desenvolvimento Articulado', 'Máquina'),
('Remada Curvada', 'Barra');

INSERT INTO itens_treino (id_treino, id_exercicio, series, repeticoes) VALUES 
(1, 1, 3, 12),
(2, 3, 4, 15),
(3, 4, 4, 8),
(4, 7, 3, 10);
-- seleção de tabela especifica--
-- select * from nome_da_tabela --
-- where coluna da tabela 
-- or nome de outra coluna.. 

/*DATE FORMAT(data_nascimento, "%d/%m/%y") as "data de Nascimento
from alunos; formatação de data para colocala na sequencia escolhida*/

/*select max(peso) from alunos; seleciona o maio valor da coluna da tabela ou da tabela escolhida*/

/*select * from exercicios; seleciona todas as informaçoes que estão dentro da tabela*/

/*date format formatação de dados*/

-- inner join--
/*select a.nome as "Nome do Aluno",
p.nome as "Nome do Plano"
from alunos as a 
inner join planos as p on a.id_plano=p.id;*/

/*select t.nome as "Nome do treino",
i.nome as "Nome do instrutor"
from treinos as t
inner join instrutores as t.id_instrutor=i.id;*/

/*select i.nome "Nome do instrutor", t.objetivo "Objetivo do treino", t.data_criacao "Data de Criação do treino"
from instrutores i
join treinos t on t.id_instrutor= i.id
where i.nome = 'Renato Personal';
*/

/*select objetivo,
(select nome from instrutores i where id= t.id_instrutor) as nome_professor from treinos t;
*/
/*select id_exercicio from itens_treino;
1,3,4,7
*/
/*select nome_exercicio from exercicios
where id in (1,3,4,7);
*/
/*
select nome_exercicio from exercicios
where id not in (select id_exercicio from itens_treino);
*/
/*
select * from alunos;
select 1 from alunos where id_plano = 4 and nome='carlos silva';*/

/*select nome, especialidades from instrutores i
where exists (select 1 from treinos t 
where t.id_instrutor = i.id);*/

/*select nome, valor_mensal from planos p
where  exists (select 1 from alunos a
where a.id_plano = p.id);

select nome, valor_mensal from planos p
where  not exists (select 1 from alunos a
where a.id_plano = p.id);
*/
/*CREATE TABLE resumo_planos AS 
SELECT 
    p.nome, 
    COUNT(a.id_aluno) AS total_alunos
FROM planos p
LEFT JOIN alunos a 
    ON p.id_plano = a.id_plano
GROUP BY p.nome;*/
/*
insert into planos (nome, valor, duracao_meses)
select 'plano vip gold', MAX(valor) * 1.5, 12 
from planos;
select * from planos;*/
/*length*/

use db_academia;

create function calcular_imc (peso decimal(5,2), altura decimal(3,2))
returns varchar(30)
deterministic
begin
	 declare imc DECIMAL(10,2);
	declare status varchar(30);

    SET imc = peso / (altura * altura);
    
	 if imc < 18.5 then
	  set status = 'Abaixo do peso';
    elseif imc >= 18.5 and imc < 25 then
    set status ='peso normal';
    else set status ='sobrepeso';
	end if;
    
    RETURN status;
    
    end

    
select
	nome,
	peso,
	calcular_imc(peso, altura) imc
from
	alunos;

create function perfil_plano (valor_mensal decimal(10,2))
returns varchat(30)
deterministic
begin 
	declare valor_mensal decimal(10,2);
	if valor_mensal decimal(10,2)

end

use db_academia;
select * from alunos;

create trigger trg_padroniza_nome
before insert on alunos
for each row
begin
	set new.nome = upper(new.nome);
end


insert into  alunos (nome, cpf, data_nasciment, email, peso, altura)
values('Jonathan santos','00202309499', curdate(), 'Jonathan@gmail.com',80,1.94);
select * from alunos;

create trigger trg_valor_mensal
before update on planos
for each row
begin
	if new.valor_mensal < 50.00 then
		set new.valor_mensal = 50.00;
	end if;
end

create table auditoria_precos (
id int auto_increment primary key,
id_plano int not null,
valor_antigo decimal (10,2),
valor_novo decimal (10,2),
data_auditoria timestamp default current_timestamp,
constraint fk_plano_auditoria foreign key (id_plano)
references planos(id)
);
select * from auditoria_precos;

create trigger trg_auditoria_preco
after update on planos
for each row
begin
	if old.valor_mensal <> new.valor_mensal then 
		insert into auditoria_precos
		(id_plano, valor_antigo, valor_novo, data_auditoria)
		values (old.id, old. valor_mensal, new. valor_mensal, now());
	end if;	
end

update planos set valor_mensal = 50.00
where id = 5;

select * from auditoria_precos;
create table log_sistema(
id int auto_increment primary key,
mensagem varchar(255),
data_sistema datetime
);
create trigger trg_log_novo_treino
after insert on treinos for each row
begin
		insert into log_sistema (mensagem, data_sistema)
		values(concat('Novo treino criado para aluno id' , new.id_aluno), now());
end

show triggers;

create table log_instrutores(
id int auto_increment primary key,
id_instrutor int,
campo_alterado varchar(50),
data_alteracao datetime
);

create trigger trg_log_instrutores
after update on instrutores
for each row
begin
	if old.nome <> new.nome then
	insert into log_instrutores(id_instrutor, campo_alterado, data_alteracao)
	values(old.id, 'nome', now());
	end if;
	if old.especialidades <> new. especialidades then 
	insert into log_instrutores(id_instrutor, campo_alteracao, data_alteracao)
	values(old.id,'especialidades',now());
	end if;
end

create trigger trg_proibicao_exclusao
before delete on exercicio
for each row
begin
	if old.nome = 'supino reto' then 
	signal sqlstate '45000'
	set messager_text = 'Erro: Não é permitido excluir supino Reto!';
	end if;
end
