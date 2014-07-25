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

-- 3) Pega o nome das colunas que são chaves primárias ou estrangeiras.
SELECT relname "Nome da Tabela", attname "Nome da Coluna", contype "Tipo"
FROM pg_constraint
INNER JOIN pg_class ON conrelid = pg_class.oid
INNER JOIN pg_attribute ON attrelid = pg_class.oid
WHERE
	(contype = 'p' OR contype = 'f')
	AND attnum = ANY (conkey);


-- 2)
SELECT relname "Tabela", attname "Coluna", typname "Tipo",
	attlen "Tamanho do Tipo", attnotnull "É not null?",
	atthasdef "Tem default?", adsrc "Default",
	(contype IS NOT NULL AND contype = 'f') "É fkey?",
	(SELECT relname FROM pg_class WHERE pg_class.oid = confrelid) "Tabela referenciada"
FROM pg_class
INNER JOIN pg_attribute ON attrelid = pg_class.oid
INNER JOIN pg_type ON atttypid = pg_type.oid
LEFT JOIN pg_attrdef ON pg_class.oid = adrelid AND adnum = attnum
LEFT JOIN pg_constraint ON pg_class.oid = conrelid AND attnum = ANY (conkey)
WHERE
(
	relname = 'pessoa'
	OR relname = 'empresa'
	OR relname = 'trabalha'
)
AND
(
	attname != 'cmax'
	AND attname != 'cmin'
	AND attname != 'xmin'
	AND attname != 'xmax'
	AND attname != 'ctid'
	AND attname != 'tableoid'
)
AND
(
	contype IS NULL
	OR contype = 'p'
	OR contype = 'f'
)
ORDER BY relname, attname;
