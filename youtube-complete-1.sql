-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-08-2024 a las 02:13:09
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canales`
--

CREATE TABLE `canales` (
  `id_canal` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL,
  `nombre` varchar(15) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `canales`
--

INSERT INTO `canales` (`id_canal`, `id_usuario`, `nombre`, `descripcion`, `fecha`) VALUES
(1, 1, 'Guerra Segura', 'Canal dedicado a lorem iasjdaks adisajidask adjsiajdaihak', '2024-07-31'),
(2, 2, 'Canal Dos', 'Descripción del canal dos', '2023-02-02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL,
  `id_usuario` int(15) DEFAULT NULL,
  `id_video` int(15) DEFAULT NULL,
  `texto` text DEFAULT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentario`, `id_usuario`, `id_video`, `texto`, `fecha_hora`) VALUES
(1, 1, 1, 'Este es un comentario en el video uno', '2023-01-16 09:00:00'),
(2, 2, 2, 'Este es un comentario en el video dos', '2023-02-16 10:00:00'),
(3, 4, 1, 'Comentario de Usuario Cuatro en Video Uno', '2024-07-31 17:10:45'),
(4, 5, 2, 'Comentario de Usuario Cinco en Video Dos', '2024-07-31 17:10:45'),
(5, 6, 1, 'Comentario de Usuario Seis en Video Uno', '2024-07-31 17:12:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dislikevideo`
--

CREATE TABLE `dislikevideo` (
  `id_dislike_video` int(15) NOT NULL,
  `dislike` tinyint(1) NOT NULL DEFAULT 0,
  `id_usuario` int(15) NOT NULL,
  `id_video` int(15) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dislikevideo`
--

INSERT INTO `dislikevideo` (`id_dislike_video`, `dislike`, `id_usuario`, `id_video`, `fecha`) VALUES
(4, 1, 4, 1, '2024-07-31 23:48:02'),
(5, 1, 8, 2, '2024-07-31 23:48:02'),
(6, 1, 9, 2, '2024-07-31 23:48:02'),
(7, 1, 6, 2, '2024-07-31 23:48:02');

--
-- Disparadores `dislikevideo`
--
DELIMITER $$
CREATE TRIGGER `after_dislike_delete` AFTER DELETE ON `dislikevideo` FOR EACH ROW BEGIN
    UPDATE youtube.videos
    SET dislikes = dislikes - 1
    WHERE id_video = OLD.id_video;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_dislike_insert` AFTER INSERT ON `dislikevideo` FOR EACH ROW BEGIN
    UPDATE youtube.videos
    SET dislikes = dislikes + 1
    WHERE id_video = NEW.id_video;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

CREATE TABLE `etiquetas` (
  `id_etiqueta` int(15) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetasvideo`
--

CREATE TABLE `etiquetasvideo` (
  `id_etiquetasvideo` int(15) NOT NULL,
  `id_etiqueta` int(15) NOT NULL,
  `id_video` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `etiquetasvideo`
--

INSERT INTO `etiquetasvideo` (`id_etiquetasvideo`, `id_etiqueta`, `id_video`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `likescomentarios`
--

CREATE TABLE `likescomentarios` (
  `id_like_comentario` int(11) NOT NULL,
  `id_comentario` int(15) DEFAULT NULL,
  `id_usuario` int(15) DEFAULT NULL,
  `tipo` enum('me gusta','no me gusta') DEFAULT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `likescomentarios`
--

INSERT INTO `likescomentarios` (`id_like_comentario`, `id_comentario`, `id_usuario`, `tipo`, `fecha_hora`) VALUES
(1, 1, 2, 'me gusta', '2023-01-16 12:00:00'),
(2, 2, 1, 'no me gusta', '2023-02-16 12:00:00'),
(3, 1, 4, 'me gusta', '2024-07-31 17:10:45'),
(4, 2, 5, 'no me gusta', '2024-07-31 17:10:45'),
(5, 1, 6, 'me gusta', '2024-07-31 17:12:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `likesvideo`
--

CREATE TABLE `likesvideo` (
  `id_likes_video` int(15) NOT NULL,
  `likes` tinyint(1) NOT NULL DEFAULT 0,
  `id_usuario` int(15) NOT NULL,
  `id_video` int(15) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `likesvideo`
--

INSERT INTO `likesvideo` (`id_likes_video`, `likes`, `id_usuario`, `id_video`, `fecha`) VALUES
(5, 1, 1, 1, '2024-07-31 23:44:16'),
(6, 1, 4, 1, '2024-07-31 23:44:16'),
(7, 1, 1, 2, '2024-07-31 23:44:16');

--
-- Disparadores `likesvideo`
--
DELIMITER $$
CREATE TRIGGER `after_like_delete` AFTER DELETE ON `likesvideo` FOR EACH ROW BEGIN
    UPDATE youtube.videos
    SET likes = likes - 1
    WHERE id_video = OLD.id_video;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_like_insert` AFTER INSERT ON `likesvideo` FOR EACH ROW BEGIN
    UPDATE youtube.videos
    SET likes = likes + 1
    WHERE id_video = NEW.id_video;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlists`
--

CREATE TABLE `playlists` (
  `id_playlist` int(11) NOT NULL,
  `id_usuario` int(15) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `estado` enum('publico','privado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `playlists`
--

INSERT INTO `playlists` (`id_playlist`, `id_usuario`, `nombre`, `fecha_creacion`, `estado`) VALUES
(1, 1, 'Playlist Uno', '2023-03-01', 'publico'),
(2, 2, 'Playlist Dos', '2023-03-02', 'privado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subscripciones`
--

CREATE TABLE `subscripciones` (
  `id_subscripcion` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL,
  `id_canal` int(15) NOT NULL,
  `subscripto` tinyint(1) NOT NULL DEFAULT 0,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `subscripciones`
--

INSERT INTO `subscripciones` (`id_subscripcion`, `id_usuario`, `id_canal`, `subscripto`, `fecha`) VALUES
(1, 3, 1, 1, '2024-07-31'),
(2, 2, 1, 1, '2024-07-31'),
(5, 6, 1, 1, '2024-07-31'),
(6, 4, 2, 1, '2024-07-31'),
(7, 5, 1, 1, '2024-07-31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(25) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `sexo` enum('Masculino','Femenino','Otros') NOT NULL,
  `pais` varchar(25) NOT NULL,
  `cp` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `email`, `password`, `nombre`, `fecha_nacimiento`, `sexo`, `pais`, `cp`) VALUES
(1, 'email@email.es', '123456', 'Armando Guerra Segura', '1996-08-09', 'Masculino', 'España', 8195),
(2, 'thisemail@email.es', '123456', 'Juan Guerra Segura', '1996-09-29', 'Masculino', 'España', 8190),
(3, 'thisgirlemail@email.es', '123456', 'Cintia Tetas', '1996-09-29', 'Femenino', 'España', 8190),
(4, 'user1@example.com', 'password1', 'Usuario Uno', '1990-01-01', 'Masculino', 'España', 28001),
(5, 'user2@example.com', 'password2', 'Usuario Dos', '1992-02-02', 'Femenino', 'España', 28002),
(6, 'user3@example.com', 'password3', 'Usuario Tres', '1994-03-03', 'Otros', 'España', 28003),
(7, 'user4@example.com', 'password4', 'Usuario Cuatro', '1995-04-04', 'Masculino', 'España', 28004),
(8, 'user5@example.com', 'password5', 'Usuario Cinco', '1996-05-05', 'Femenino', 'España', 28005),
(9, 'user6@example.com', 'password6', 'Usuario Seis', '1997-06-06', 'Masculino', 'España', 28006);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `videos`
--

CREATE TABLE `videos` (
  `id_video` int(15) NOT NULL,
  `titulo` varchar(25) NOT NULL,
  `peso_mb` int(10) NOT NULL,
  `duracion_min` int(6) NOT NULL,
  `thumbnail` varchar(150) NOT NULL,
  `archivo` varchar(150) NOT NULL,
  `reproducciones` int(15) NOT NULL,
  `likes` int(15) NOT NULL,
  `dislikes` int(15) NOT NULL,
  `estado` enum('publico','oculto','privado') NOT NULL,
  `id_canal` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `videos`
--

INSERT INTO `videos` (`id_video`, `titulo`, `peso_mb`, `duracion_min`, `thumbnail`, `archivo`, `reproducciones`, `likes`, `dislikes`, `estado`, `id_canal`, `descripcion`, `fecha`) VALUES
(1, 'Video Uno', 500, 10, 'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', 1000, 2, 1, 'publico', 1, 'Descripción del video uno', '2023-01-14 23:00:00'),
(2, 'Video Dos', 300, 5, 'https://img.youtube.com/vi/3JZ_D3ELwOQ/hqdefault.jpg', 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ', 500, 1, 3, 'publico', 2, 'Descripción del video dos', '2023-02-14 23:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `videosplaylist`
--

CREATE TABLE `videosplaylist` (
  `id_playlist_video` int(11) NOT NULL,
  `id_playlist` int(15) DEFAULT NULL,
  `id_video` int(15) DEFAULT NULL,
  `fecha_agregado` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `videosplaylist`
--

INSERT INTO `videosplaylist` (`id_playlist_video`, `id_playlist`, `id_video`, `fecha_agregado`) VALUES
(1, 1, 1, '2023-03-01'),
(2, 1, 2, '2023-03-01'),
(3, 2, 1, '2023-03-02');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `canales`
--
ALTER TABLE `canales`
  ADD PRIMARY KEY (`id_canal`),
  ADD KEY `usuario_canal` (`id_usuario`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_video` (`id_video`);

--
-- Indices de la tabla `dislikevideo`
--
ALTER TABLE `dislikevideo`
  ADD PRIMARY KEY (`id_dislike_video`),
  ADD UNIQUE KEY `unique_dislikes` (`id_usuario`,`id_video`),
  ADD KEY `video_dislikevideo` (`id_video`);

--
-- Indices de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  ADD PRIMARY KEY (`id_etiqueta`);

--
-- Indices de la tabla `etiquetasvideo`
--
ALTER TABLE `etiquetasvideo`
  ADD PRIMARY KEY (`id_etiquetasvideo`),
  ADD KEY `id_video_etiquetasvideo` (`id_video`),
  ADD KEY `id_etiqueta_etiquetasvideo` (`id_etiqueta`);

--
-- Indices de la tabla `likescomentarios`
--
ALTER TABLE `likescomentarios`
  ADD PRIMARY KEY (`id_like_comentario`),
  ADD UNIQUE KEY `id_comentario` (`id_comentario`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `likesvideo`
--
ALTER TABLE `likesvideo`
  ADD PRIMARY KEY (`id_likes_video`),
  ADD UNIQUE KEY `unique_likes` (`id_usuario`,`id_video`),
  ADD KEY `video_likesvideo` (`id_video`);

--
-- Indices de la tabla `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id_playlist`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  ADD PRIMARY KEY (`id_subscripcion`),
  ADD UNIQUE KEY `unique_subscription` (`id_usuario`,`id_canal`),
  ADD KEY `canal_subscripcion` (`id_canal`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id_video`),
  ADD KEY `canal_videos` (`id_canal`);

--
-- Indices de la tabla `videosplaylist`
--
ALTER TABLE `videosplaylist`
  ADD PRIMARY KEY (`id_playlist_video`),
  ADD KEY `id_playlist` (`id_playlist`),
  ADD KEY `id_video` (`id_video`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `canales`
--
ALTER TABLE `canales`
  MODIFY `id_canal` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `dislikevideo`
--
ALTER TABLE `dislikevideo`
  MODIFY `id_dislike_video` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  MODIFY `id_etiqueta` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `etiquetasvideo`
--
ALTER TABLE `etiquetasvideo`
  MODIFY `id_etiquetasvideo` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `likescomentarios`
--
ALTER TABLE `likescomentarios`
  MODIFY `id_like_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `likesvideo`
--
ALTER TABLE `likesvideo`
  MODIFY `id_likes_video` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id_playlist` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  MODIFY `id_subscripcion` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `videos`
--
ALTER TABLE `videos`
  MODIFY `id_video` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `videosplaylist`
--
ALTER TABLE `videosplaylist`
  MODIFY `id_playlist_video` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `canales`
--
ALTER TABLE `canales`
  ADD CONSTRAINT `usuario_canal` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_video`) REFERENCES `videos` (`id_video`);

--
-- Filtros para la tabla `dislikevideo`
--
ALTER TABLE `dislikevideo`
  ADD CONSTRAINT `usuario_dislikevideo` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `video_dislikevideo` FOREIGN KEY (`id_video`) REFERENCES `videos` (`id_video`);

--
-- Filtros para la tabla `etiquetasvideo`
--
ALTER TABLE `etiquetasvideo`
  ADD CONSTRAINT `id_etiqueta_etiquetasvideo` FOREIGN KEY (`id_etiqueta`) REFERENCES `etiquetas` (`id_etiqueta`),
  ADD CONSTRAINT `id_video_etiquetasvideo` FOREIGN KEY (`id_video`) REFERENCES `videos` (`id_video`);

--
-- Filtros para la tabla `likescomentarios`
--
ALTER TABLE `likescomentarios`
  ADD CONSTRAINT `likescomentarios_ibfk_1` FOREIGN KEY (`id_comentario`) REFERENCES `comentarios` (`id_comentario`),
  ADD CONSTRAINT `likescomentarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `likesvideo`
--
ALTER TABLE `likesvideo`
  ADD CONSTRAINT `usuario_likesvideo` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `video_likesvideo` FOREIGN KEY (`id_video`) REFERENCES `videos` (`id_video`);

--
-- Filtros para la tabla `playlists`
--
ALTER TABLE `playlists`
  ADD CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  ADD CONSTRAINT `canal_subscripcion` FOREIGN KEY (`id_canal`) REFERENCES `canales` (`id_canal`),
  ADD CONSTRAINT `usuario_subscripcion` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `canal_videos` FOREIGN KEY (`id_canal`) REFERENCES `canales` (`id_canal`);

--
-- Filtros para la tabla `videosplaylist`
--
ALTER TABLE `videosplaylist`
  ADD CONSTRAINT `videosplaylist_ibfk_1` FOREIGN KEY (`id_playlist`) REFERENCES `playlists` (`id_playlist`),
  ADD CONSTRAINT `videosplaylist_ibfk_2` FOREIGN KEY (`id_video`) REFERENCES `videos` (`id_video`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
