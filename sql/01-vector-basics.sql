CREATE TABLE vector_demo (
    id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description text,
    embedding   vector(3)
);

INSERT INTO vector_demo (description, embedding)
VALUES
    ('Vector A', '[1,2,3]'),
    ('Vector B', '[4,5,6]'),
    ('Vector C', '[1,2,4]');

SELECT id, description, embedding, embedding <-> '[1,2,3.5]'::vector AS distance
FROM vector_demo
ORDER BY embedding <-> '[1,2,3.5]'::vector;

SELECT id, description, embedding
FROM vector_demo
ORDER BY embedding <-> '[1,2,3.5]'::vector
LIMIT 2;

SELECT
    description,
    embedding <-> '[1,2,3.5]'::vector AS l2_distance,
    embedding <#> '[1,2,3.5]'::vector AS negative_inner_product,
    embedding <=> '[1,2,3.5]'::vector AS cosine_distance
FROM vector_demo;

EXPLAIN (ANALYZE, BUFFERS)
SELECT id, description, embedding
FROM vector_demo
ORDER BY embedding <-> '[1,2,3.5]'::vector
LIMIT 2;

ANALYZE vector_demo;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    id,
    description,
    embedding
FROM vector_demo
ORDER BY embedding <-> '[1,2,3.5]'::vector
LIMIT 2;
