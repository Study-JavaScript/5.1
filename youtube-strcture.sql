-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-08-2024 a las 01:59:41
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetasvideo`
--

CREATE TABLE `etiquetasvideo` (
  `id_etiquetasvideo` int(15) NOT NULL,
  `id_etiqueta` int(15) NOT NULL,
  `id_video` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `id_canal` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dislikevideo`
--
ALTER TABLE `dislikevideo`
  MODIFY `id_dislike_video` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  MODIFY `id_etiqueta` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `etiquetasvideo`
--
ALTER TABLE `etiquetasvideo`
  MODIFY `id_etiquetasvideo` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `likescomentarios`
--
ALTER TABLE `likescomentarios`
  MODIFY `id_like_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `likesvideo`
--
ALTER TABLE `likesvideo`
  MODIFY `id_likes_video` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id_playlist` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  MODIFY `id_subscripcion` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `videos`
--
ALTER TABLE `videos`
  MODIFY `id_video` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `videosplaylist`
--
ALTER TABLE `videosplaylist`
  MODIFY `id_playlist_video` int(11) NOT NULL AUTO_INCREMENT;

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
