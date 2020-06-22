CREATE DATABASE peliculas;
\c peliculas;

CREATE TABLE peliculas(
    id_pelicula SERIAL,
    nombre_pelicula VARCHAR(300),
    año_estreno INT,
    director VARCHAR(50), 
    PRIMARY KEY (id_pelicula)
);

CREATE TABLE reparto(
    id_reparto SERIAL,
    pelicula_relacionada INT,
    nombre_persona VARCHAR(50),
    FOREIGN KEY(pelicula_relacionada) REFERENCES peliculas(id_pelicula)
);

\copy peliculas FROM '/home/system/Escritorio/BBDD/Desafio_2/peliculas.csv' CSV HEADER;
\copy reparto(pelicula_relacionada, nombre_persona) FROM '/home/system/Escritorio/BBDD/Desafio_2/reparto.csv' DELIMITERS ',';

SELECT nombre_pelicula, año_estreno, director, nombre_persona
FROM peliculas, reparto 
WHERE nombre_pelicula = 'Titanic' AND id_pelicula = pelicula_relacionada;

SELECT nombre_pelicula 
FROM peliculas, reparto 
WHERE id_pelicula = pelicula_relacionada and nombre_persona = 'Harrison Ford';

SELECT director, COUNT(nombre_pelicula) AS Q_peliculas 
FROM peliculas 
GROUP BY director 
ORDER BY Q_peliculas 
DESC LIMIT 10;

SELECT COUNT(*) AS Q_actores FROM 
(SELECT nombre_persona, COUNT(nombre_persona) 
FROM reparto 
GROUP BY nombre_persona) AS TBL_AUX;

SELECT nombre_pelicula
FROM peliculas
WHERE año_estreno >=1990 and año_estreno <= 1999
ORDER BY nombre_pelicula ASC;

SELECT * FROM reparto WHERE pelicula_relacionada IN (SELECT id_pelicula
FROM peliculas
WHERE año_estreno = 2001);

SELECT nombre_persona FROM reparto WHERE pelicula_relacionada IN 
(SELECT id_pelicula FROM peliculas ORDER BY año_estreno DESC LIMIT 1);