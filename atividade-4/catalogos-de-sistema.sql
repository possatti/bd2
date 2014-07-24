-- 1) Crie as tabelas:
/*
create table Pessoa (
    codigo serial primary key,
    nome varchar(15) not null,
    cidade varchar(10) null default 'Vitoria');

create table Empresa (
    codigo serial primary key,
    nome varchar(15) not null,
    cidade varchar(10) null default 'Vitoria');

create table Trabalha (
    codigo serial primary key,
    id_empresa int not null REFERENCES empresa(codigo),
    id_pessoa int not null REFERENCES pessoa(codigo),
    salario numeric(12,2) null default 700,
    unique(id_empresa, id_pessoa));
*/

-- Pega o nome das colunas que são chaves primárias ou estrangeiras.
SELECT relname "Nome da Tabela", attname "Nome da Coluna", contype "Tipo"
FROM pg_constraint
INNER JOIN pg_class ON conrelid = pg_class.oid
INNER JOIN pg_attribute ON attrelid = pg_class.oid
WHERE
	(contype = 'p' OR contype = 'f')
	AND attnum = ANY (conkey);
