-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-08-2024 a las 08:37:32
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
-- Base de datos: `spotify`
--
CREATE DATABASE IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `spotify`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `albumes`
--

CREATE TABLE `albumes` (
  `id_album` int(15) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `publicacion` date NOT NULL DEFAULT current_timestamp(),
  `imagen` varchar(255) NOT NULL,
  `id_artista` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `albumlikes`
--

CREATE TABLE `albumlikes` (
  `id_usuario` int(15) NOT NULL,
  `id_album` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artistas`
--

CREATE TABLE `artistas` (
  `id_artista` int(15) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artistasrel`
--

CREATE TABLE `artistasrel` (
  `id_artista_1` int(15) NOT NULL,
  `id_artista_2` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canciones`
--

CREATE TABLE `canciones` (
  `id_cancion` int(15) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `seg` int(15) DEFAULT NULL,
  `reproducciones` int(50) DEFAULT 0,
  `id_album` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancionesplaylist`
--

CREATE TABLE `cancionesplaylist` (
  `id_playlistactiva` int(15) NOT NULL,
  `id_cancion` int(15) NOT NULL,
  `id_usuario` int(15) DEFAULT NULL,
  `fecha_adicion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancionlikes`
--

CREATE TABLE `cancionlikes` (
  `id_cancion` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(15) NOT NULL,
  `id_usuario` int(15) DEFAULT NULL,
  `id_subscripcion` int(15) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `importe` float(10,2) DEFAULT NULL,
  `estado` enum('Pendiente','Completado','Fallido') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paypal`
--

CREATE TABLE `paypal` (
  `id_usuario` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlists`
--

CREATE TABLE `playlists` (
  `id_playlist` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp(),
  `canciones` int(15) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlistsactivas`
--

CREATE TABLE `playlistsactivas` (
  `id_playlistactiva` int(15) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlistsborradas`
--

CREATE TABLE `playlistsborradas` (
  `id_playlistborrada` int(15) NOT NULL,
  `motivo` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subscripciones`
--

CREATE TABLE `subscripciones` (
  `id_subscripcion` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL,
  `inicio` date NOT NULL,
  `renovacion` date NOT NULL,
  `formapago` enum('Tarjeta de Credito','PayPal') NOT NULL,
  `id_tarjeta` int(15) DEFAULT NULL,
  `id_paypal` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjetas`
--

CREATE TABLE `tarjetas` (
  `id_tarjeta` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL,
  `numero` int(60) NOT NULL,
  `mescad` int(2) NOT NULL,
  `anocad` int(4) NOT NULL,
  `cvv` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(15) NOT NULL,
  `password` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `nacimiento` date NOT NULL,
  `sexo` enum('Masculino','Femenino','Otros') NOT NULL,
  `pais` varchar(25) NOT NULL,
  `cp` int(5) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` enum('free','premium') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `albumes`
--
ALTER TABLE `albumes`
  ADD PRIMARY KEY (`id_album`),
  ADD KEY `id_artista` (`id_artista`);

--
-- Indices de la tabla `albumlikes`
--
ALTER TABLE `albumlikes`
  ADD PRIMARY KEY (`id_usuario`,`id_album`),
  ADD KEY `id_album` (`id_album`);

--
-- Indices de la tabla `artistas`
--
ALTER TABLE `artistas`
  ADD PRIMARY KEY (`id_artista`);

--
-- Indices de la tabla `artistasrel`
--
ALTER TABLE `artistasrel`
  ADD PRIMARY KEY (`id_artista_1`,`id_artista_2`),
  ADD KEY `id_artista_2` (`id_artista_2`);

--
-- Indices de la tabla `canciones`
--
ALTER TABLE `canciones`
  ADD PRIMARY KEY (`id_cancion`),
  ADD KEY `id_album` (`id_album`);

--
-- Indices de la tabla `cancionesplaylist`
--
ALTER TABLE `cancionesplaylist`
  ADD PRIMARY KEY (`id_playlistactiva`,`id_cancion`),
  ADD KEY `id_cancion` (`id_cancion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `cancionlikes`
--
ALTER TABLE `cancionlikes`
  ADD PRIMARY KEY (`id_cancion`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_subscripcion` (`id_subscripcion`);

--
-- Indices de la tabla `paypal`
--
ALTER TABLE `paypal`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id_playlist`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `playlistsactivas`
--
ALTER TABLE `playlistsactivas`
  ADD PRIMARY KEY (`id_playlistactiva`);

--
-- Indices de la tabla `playlistsborradas`
--
ALTER TABLE `playlistsborradas`
  ADD PRIMARY KEY (`id_playlistborrada`);

--
-- Indices de la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  ADD PRIMARY KEY (`id_subscripcion`),
  ADD KEY `tarjeta_subscripccion` (`id_tarjeta`),
  ADD KEY `paypal_subscripcion` (`id_paypal`),
  ADD KEY `usuario_subscricion` (`id_usuario`);

--
-- Indices de la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  ADD PRIMARY KEY (`id_tarjeta`),
  ADD KEY `usuario_tarjeta` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `albumes`
--
ALTER TABLE `albumes`
  MODIFY `id_album` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id_playlist` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  MODIFY `id_subscripcion` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  MODIFY `id_tarjeta` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(15) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `albumes`
--
ALTER TABLE `albumes`
  ADD CONSTRAINT `albumes_ibfk_1` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id_artista`);

--
-- Filtros para la tabla `albumlikes`
--
ALTER TABLE `albumlikes`
  ADD CONSTRAINT `albumlikes_ibfk_1` FOREIGN KEY (`id_album`) REFERENCES `albumes` (`id_album`),
  ADD CONSTRAINT `albumlikes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `artistasrel`
--
ALTER TABLE `artistasrel`
  ADD CONSTRAINT `artistasrel_ibfk_1` FOREIGN KEY (`id_artista_1`) REFERENCES `artistas` (`id_artista`),
  ADD CONSTRAINT `artistasrel_ibfk_2` FOREIGN KEY (`id_artista_2`) REFERENCES `artistas` (`id_artista`);

--
-- Filtros para la tabla `canciones`
--
ALTER TABLE `canciones`
  ADD CONSTRAINT `canciones_ibfk_1` FOREIGN KEY (`id_album`) REFERENCES `albumes` (`id_album`);

--
-- Filtros para la tabla `cancionesplaylist`
--
ALTER TABLE `cancionesplaylist`
  ADD CONSTRAINT `cancionesplaylist_ibfk_2` FOREIGN KEY (`id_cancion`) REFERENCES `canciones` (`id_cancion`),
  ADD CONSTRAINT `cancionesplaylist_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `cancionesplaylist_ibfk_4` FOREIGN KEY (`id_playlistactiva`) REFERENCES `playlistsactivas` (`id_playlistactiva`);

--
-- Filtros para la tabla `cancionlikes`
--
ALTER TABLE `cancionlikes`
  ADD CONSTRAINT `cancionlikes_ibfk_1` FOREIGN KEY (`id_cancion`) REFERENCES `canciones` (`id_cancion`),
  ADD CONSTRAINT `cancionlikes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`id_subscripcion`) REFERENCES `subscripciones` (`id_subscripcion`);

--
-- Filtros para la tabla `paypal`
--
ALTER TABLE `paypal`
  ADD CONSTRAINT `paypal_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `playlists`
--
ALTER TABLE `playlists`
  ADD CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `playlistsactivas`
--
ALTER TABLE `playlistsactivas`
  ADD CONSTRAINT `playlistsactivas_ibfk_1` FOREIGN KEY (`id_playlistactiva`) REFERENCES `playlists` (`id_playlist`);

--
-- Filtros para la tabla `playlistsborradas`
--
ALTER TABLE `playlistsborradas`
  ADD CONSTRAINT `playlistsborradas_ibfk_1` FOREIGN KEY (`id_playlistborrada`) REFERENCES `playlists` (`id_playlist`);

--
-- Filtros para la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  ADD CONSTRAINT `paypal_subscripcion` FOREIGN KEY (`id_paypal`) REFERENCES `paypal` (`id_usuario`),
  ADD CONSTRAINT `tarjeta_subscripccion` FOREIGN KEY (`id_tarjeta`) REFERENCES `tarjetas` (`id_tarjeta`),
  ADD CONSTRAINT `usuario_subscricion` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  ADD CONSTRAINT `usuario_tarjeta` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
