USE sakila_pt;
UNLOCK TABLES;
SET SQL_SAFE_UPDATES = 0;


-- 1. Usando o id_cidade criado para 'Rio de Janeiro', insira um endereco (logradouro 'Rua Copacabana, 10', bairro 'Copacabana', cep '22000111', telefone '2199998888').

SELECT * FROM cidades;
SELECT * FROM paises WHERE pais = 'Brasil';

INSERT INTO cidades (cidade, pais_id) VALUES ('Rio de Janeiro', (SELECT id_pais FROM paises WHERE pais = 'Brasil'));


-- 2. Atualize a classificacao do filme 'ACE GOLDFINGER' (id 2) para 'PG-13'.

SELECT * FROM filmes WHERE id_filme = 2;
UPDATE filmes SET classificacao = 'PG-13' WHERE id_filme = 2;
-- nao tem ace goldfinger


-- 3. Remover do nº1

DELETE FROM cidades WHERE cidade = 'Rio de Janeiro';


-- 4. Conte quantos filmes existem para cada classificacao.

SELECT * FROM filmes;

SELECT classificacao, COUNT(*) AS count_classificacao
FROM filmes GROUP BY classificacao;


-- 5. Exiba o nome completo de todos os clientes em uma única coluna (use CONCAT()).

SELECT CONCAT(primeiro_nome, ' ', ultimo_nome) AS nome_completo FROM clientes;


-- 6. Liste o titulo do filme e o nome da categoria a que ele pertence (requer 3 tabelas).

SELECT f.titulo, c.nome 
FROM filmes f
INNER JOIN filmes_categorias fc ON fc.filme_id = f.id_filme
INNER JOIN categorias c ON c.id_categoria = fc.categoria_id;


-- 7. Encontre clientes que nunca fizeram um aluguel.

SELECT * FROM clientes;
SELECT * FROM alugueis;
SELECT COUNT(*) FROM clientes c INNER JOIN alugueis a ON a.cliente_id = c.id_cliente;

SELECT c.* FROM clientes c
LEFT JOIN alugueis a ON a.cliente_id = c.id_cliente 
WHERE a.cliente_id = NULL;
-- nao tem clientes sem aluguel (eu acho)


-- 8. (Na cláusula SELECT) Liste cada filme e, em uma segunda coluna, mostre a taxa_aluguel média de todos os filmes.

SELECT * FROM filmes;

SELECT id_filme, titulo, (SELECT AVG(taxa_aluguel) FROM filmes) AS media_taxa_aluguel FROM filmes;


-- 9. Liste o nome completo (CONCAT) dos clientes (JOIN enderecos, cidades) que moram na cidade 'London' (WHERE).

SELECT CONCAT(c.primeiro_nome, ' ', c.ultimo_nome) AS nome_completo, e.logradouro, ci.cidade FROM clientes c 
INNER JOIN enderecos e ON e.id_endereco = c.endereco_id
INNER JOIN cidades ci ON ci.id_cidade = e.cidade_id
WHERE id_cidade = (SELECT id_cidade FROM cidades WHERE cidade = 'London');


SELECT * FROM cidades WHERE cidade = 'London';
-- nao tem london

-- teste do codigo
SELECT CONCAT(c.primeiro_nome, ' ', c.ultimo_nome) AS nome_completo, ci.cidade FROM clientes c 
INNER JOIN enderecos e ON e.id_endereco = c.endereco_id
INNER JOIN cidades ci ON ci.id_cidade = e.cidade_id
WHERE id_cidade = (SELECT id_cidade FROM cidades WHERE cidade = 'Alvorada');

SET SQL_SAFE_UPDATES = 1;