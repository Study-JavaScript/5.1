-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-08-2024 a las 02:04:13
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `youtube`
--
CREATE DATABASE IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `youtube`;

--
-- Volcado de datos para la tabla `canales`
--

INSERT INTO `canales` (`id_canal`, `id_usuario`, `nombre`, `descripcion`, `fecha`) VALUES
(1, 1, 'Guerra Segura', 'Canal dedicado a lorem iasjdaks adisajidask adjsiajdaihak', '2024-07-31'),
(2, 2, 'Canal Dos', 'Descripción del canal dos', '2023-02-02');

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentario`, `id_usuario`, `id_video`, `texto`, `fecha_hora`) VALUES
(1, 1, 1, 'Este es un comentario en el video uno', '2023-01-16 09:00:00'),
(2, 2, 2, 'Este es un comentario en el video dos', '2023-02-16 10:00:00'),
(3, 4, 1, 'Comentario de Usuario Cuatro en Video Uno', '2024-07-31 17:10:45'),
(4, 5, 2, 'Comentario de Usuario Cinco en Video Dos', '2024-07-31 17:10:45'),
(5, 6, 1, 'Comentario de Usuario Seis en Video Uno', '2024-07-31 17:12:08');

--
-- Volcado de datos para la tabla `dislikevideo`
--

INSERT INTO `dislikevideo` (`id_dislike_video`, `dislike`, `id_usuario`, `id_video`, `fecha`) VALUES
(4, 1, 4, 1, '2024-07-31 23:48:02'),
(5, 1, 8, 2, '2024-07-31 23:48:02'),
(6, 1, 9, 2, '2024-07-31 23:48:02'),
(7, 1, 6, 2, '2024-07-31 23:48:02');

--
-- Volcado de datos para la tabla `etiquetas`
--

INSERT INTO `etiquetas` (`id_etiqueta`, `nombre`) VALUES
(1, 'Cocina'),
(2, 'Videotutorial'),
(3, 'Callof'),
(4, 'Callofdutty'),
(5, 'Cars'),
(6, 'Dibujos animados'),
(7, 'Dora Black'),
(8, 'Fernandito Kitkat'),
(9, 'Guerra'),
(10, 'Ucrania');

--
-- Volcado de datos para la tabla `etiquetasvideo`
--

INSERT INTO `etiquetasvideo` (`id_etiquetasvideo`, `id_etiqueta`, `id_video`) VALUES
(1, 1, 1),
(2, 2, 2);

--
-- Volcado de datos para la tabla `likescomentarios`
--

INSERT INTO `likescomentarios` (`id_like_comentario`, `id_comentario`, `id_usuario`, `tipo`, `fecha_hora`) VALUES
(1, 1, 2, 'me gusta', '2023-01-16 12:00:00'),
(2, 2, 1, 'no me gusta', '2023-02-16 12:00:00'),
(3, 1, 4, 'me gusta', '2024-07-31 17:10:45'),
(4, 2, 5, 'no me gusta', '2024-07-31 17:10:45'),
(5, 1, 6, 'me gusta', '2024-07-31 17:12:08');

--
-- Volcado de datos para la tabla `likesvideo`
--

INSERT INTO `likesvideo` (`id_likes_video`, `likes`, `id_usuario`, `id_video`, `fecha`) VALUES
(5, 1, 1, 1, '2024-07-31 23:44:16'),
(6, 1, 4, 1, '2024-07-31 23:44:16'),
(7, 1, 1, 2, '2024-07-31 23:44:16');

--
-- Volcado de datos para la tabla `playlists`
--

INSERT INTO `playlists` (`id_playlist`, `id_usuario`, `nombre`, `fecha_creacion`, `estado`) VALUES
(1, 1, 'Playlist Uno', '2023-03-01', 'publico'),
(2, 2, 'Playlist Dos', '2023-03-02', 'privado');

--
-- Volcado de datos para la tabla `subscripciones`
--

INSERT INTO `subscripciones` (`id_subscripcion`, `id_usuario`, `id_canal`, `subscripto`, `fecha`) VALUES
(1, 3, 1, 1, '2024-07-31'),
(2, 2, 1, 1, '2024-07-31'),
(5, 6, 1, 1, '2024-07-31'),
(6, 4, 2, 1, '2024-07-31'),
(7, 5, 1, 1, '2024-07-31');

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` ( `email`, `password`, `nombre`, `fecha_nacimiento`, `sexo`, `pais`, `cp`) VALUES
( 'user1@example.com', 'password1', 'Usuario Uno', '1990-01-01', 'Masculino', 'España', 28001),
( 'user2@example.com', 'password2', 'Usuario Dos', '1992-02-02', 'Femenino', 'España', 28002),
( 'user3@example.com', 'password3', 'Usuario Tres', '1994-03-03', 'Otros', 'España', 28003),
( 'user4@example.com', 'password4', 'Usuario Cuatro', '1995-04-04', 'Masculino', 'España', 28004),
( 'user5@example.com', 'password5', 'Usuario Cinco', '1996-05-05', 'Femenino', 'España', 28005),
( 'user6@example.com', 'password6', 'Usuario Seis', '1997-06-06', 'Masculino', 'España', 28006),
( 'email@email.es', '123456', 'Armando Guerra Segura', '1996-08-09', 'Masculino', 'España', 8195),
( 'thisemail@email.es', '123456', 'Juan Guerra Segura', '1996-09-29', 'Masculino', 'España', 8190),
( 'thisgirlemail@email.es', '123456', 'Cintia Tetas', '1996-09-29', 'Femenino', 'España', 8190);

--
-- Volcado de datos para la tabla `videos`
--

INSERT INTO `videos` (`id_video`, `titulo`, `peso_mb`, `duracion_min`, `thumbnail`, `archivo`, `reproducciones`, `likes`, `dislikes`, `estado`, `id_canal`, `descripcion`, `fecha`) VALUES
(1, 'Video Uno', 500, 10, 'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', 1000, 2, 1, 'publico', 1, 'Descripción del video uno', '2023-01-14 23:00:00'),
(2, 'Video Dos', 300, 5, 'https://img.youtube.com/vi/3JZ_D3ELwOQ/hqdefault.jpg', 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ', 500, 1, 3, 'publico', 2, 'Descripción del video dos', '2023-02-14 23:00:00');

--
-- Volcado de datos para la tabla `videosplaylist`
--

INSERT INTO `videosplaylist` (`id_playlist_video`, `id_playlist`, `id_video`, `fecha_agregado`) VALUES
(1, 1, 1, '2023-03-01'),
(2, 1, 2, '2023-03-01'),
(3, 2, 1, '2023-03-02');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
