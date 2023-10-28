USE master
GO
DROP DATABASE project

CREATE DATABASE project
GO
USE project

CREATE TABLE projects (
id			INT         NOT NULL IDENTITY (10001,1),
name        VARCHAR(45) NOT NULL,
description VARCHAR(45) NOT NULL UNIQUE,
date        DATE        NOT NULL CHECK (date > '2014-09-01')
PRIMARY KEY (id)
)
GO

CREATE TABLE users (
id			INT				NOT NULL IDENTITY (1,1),
name		VARCHAR(45)		NOT NULL,
username	VARCHAR(45)		NOT NULL,
password	VARCHAR(45)		NOT NULL DEFAULT ('123mudar'),
email		VARCHAR(45)		NOT NULL 
PRIMARY kEY	(id)
)
GO

CREATE TABLE users_has_projects(
id_users			INT				NOT NULL,
id_projects         INT				NOT NULL
PRIMARY KEY (id_users, id_projects)
FOREIGN KEY (id_users)    REFERENCES users(id),
FOREIGN KEY (id_projects) REFERENCES projects(id)
)
GO

ALTER TABLE projects
ADD CONSTRAINT UQ_description UNIQUE (description);

--Altera os campos da Tabela
ALTER TABLE users ALTER COLUMN username VARCHAR(10)
ALTER TABLE users ALTER COLUMN password VARCHAR(08)

/*--BULK INSERT
INSERT INTO users VALUES
('Maria', 'Rh_maria', '123@mudar', 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', '123@mudar', 'ana@empresa.com'),
('Clara', 'Ti_clara', '123@mudar', 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')
*/

INSERT INTO users (name, username, email)
VALUES ('Maria', 'Rh_maria', 'maria@empresa.com')

INSERT INTO users (name, username, password,email)
VALUES ('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')

INSERT INTO users (name, username, email)
VALUES ('Ana', 'Rh_ana', 'ana@empresa.com')

INSERT INTO users (name, username, email)
VALUES ('Clara', 'Ti_clara', 'clara@empresa.com')

INSERT INTO users (name, username, password,email)
VALUES ('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')
/*
--BULK INSERT
INSERT INTO projects VALUES
('Re-folha', 'Refatora��o das Folhas', '2014-09-05'),
('Manuten��o PC�s', 'Manuten��o PC�s', '2014-09-06'),
('Auditoria', Null, '2014-09-07')
*/
INSERT INTO projects (name, description, date)
VALUES ('Re-folha', 'Refatora��o das Folhas', '2014-09-05')

INSERT INTO projects (name, description, date)
VALUES ('Manuten��o PC�s', 'Manuten��o PC�s', '2014-09-06')

ALTER TABLE projects
ALTER COLUMN description VARCHAR(45) NULL;

INSERT INTO projects (name, description, date)
VALUES ('Auditoria', Null, '2014-09-07')


INSERT INTO users_has_projects VALUES
(1,10001),
(5,10001),
(3,10003),
(4,10002),
(2,10002)

-- O projeto de Manuten��o atrasou, mudar a data para 12/09/2014
UPDATE projects
SET date = '2014-09-12'
WHERE id = 10002;

-- O username de aparecido (usar o nome como condi��o de mudan�a) est� feio, mudar para Rh_cido
UPDATE users
SET username = 'Rh_cido'
WHERE id = 5;


-- Mudar o password do username Rh_maria (usar o username como condi��o de mudan�a) para 888@*, mas a condi��o deve verificar se o password dela ainda � 123mudar
UPDATE users
SET password = '888@*'
WHERE username = 'Rh_maria' AND password = '123mudar' ;

-- O user de id 2 n�o participa mais do projeto 10002, remov�-lo da associativa
DELETE FROM users_has_projects
WHERE id_users =2;
/* teste para alterar o campo
UPDATE projects
SET description = 'Auditoria'
WHERE id = 10003;
*/
SELECT * from users
SELECT * from projects
SELECT * from users_has_projects