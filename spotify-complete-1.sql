-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-08-2024 a las 08:36:44
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

--
-- Volcado de datos para la tabla `albumes`
--

INSERT INTO `albumes` (`id_album`, `titulo`, `publicacion`, `imagen`, `id_artista`) VALUES
(1, 'Hits of 2022', '2022-03-15', 'https://example.com/album1.jpg', 1),
(2, 'Solo Anthems', '2021-11-20', 'https://example.com/album2.jpg', 2),
(3, 'Duo Classics', '2022-07-18', 'https://example.com/album3.jpg', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `albumlikes`
--

CREATE TABLE `albumlikes` (
  `id_usuario` int(15) NOT NULL,
  `id_album` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `albumlikes`
--

INSERT INTO `albumlikes` (`id_usuario`, `id_album`) VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artistas`
--

CREATE TABLE `artistas` (
  `id_artista` int(15) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `artistas`
--

INSERT INTO `artistas` (`id_artista`, `nombre`, `imagen`) VALUES
(1, 'Big Band', 'https://example.com/artist1.jpg'),
(2, 'Solo Singer', 'https://example.com/artist2.jpg'),
(3, 'Duo Performers', 'https://example.com/artist3.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artistasrel`
--

CREATE TABLE `artistasrel` (
  `id_artista_1` int(15) NOT NULL,
  `id_artista_2` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `artistasrel`
--

INSERT INTO `artistasrel` (`id_artista_1`, `id_artista_2`) VALUES
(1, 2),
(2, 3);

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

--
-- Volcado de datos para la tabla `canciones`
--

INSERT INTO `canciones` (`id_cancion`, `titulo`, `seg`, `reproducciones`, `id_album`) VALUES
(1, 'Upbeat and Happy', 180, 150000, 1),
(2, 'Reflective Solitude', 240, 50000, 2),
(3, 'Dynamic Duets', 210, 75000, 3);

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

--
-- Volcado de datos para la tabla `cancionesplaylist`
--

INSERT INTO `cancionesplaylist` (`id_playlistactiva`, `id_cancion`, `id_usuario`, `fecha_adicion`) VALUES
(1, 1, 1, '2023-07-25 12:30:00'),
(1, 2, 1, '2023-07-25 12:35:00'),
(1, 3, 3, '2023-07-27 14:00:00'),
(2, 2, 2, '2023-07-26 13:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancionlikes`
--

CREATE TABLE `cancionlikes` (
  `id_cancion` int(15) NOT NULL,
  `id_usuario` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cancionlikes`
--

INSERT INTO `cancionlikes` (`id_cancion`, `id_usuario`) VALUES
(2, 2),
(3, 1),
(3, 2),
(3, 3);

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

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id_pago`, `id_usuario`, `id_subscripcion`, `fecha`, `importe`, `estado`) VALUES
(1, 1, 1, '2023-01-01 11:00:00', 9.99, 'Completado'),
(2, 3, 2, '2023-02-01 11:00:00', 9.99, 'Completado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paypal`
--

CREATE TABLE `paypal` (
  `id_usuario` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paypal`
--

INSERT INTO `paypal` (`id_usuario`, `email`, `nombre`) VALUES
(3, 'user3paypal@example.com', 'Chris PayPal');

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

--
-- Volcado de datos para la tabla `playlists`
--

INSERT INTO `playlists` (`id_playlist`, `id_usuario`, `nombre`, `fecha`, `canciones`) VALUES
(1, 1, 'Party Mix', '2023-07-25', 2),
(2, 2, 'Chill Vibes', '2023-07-26', 1),
(3, 3, 'Drive Time', '2023-07-27', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlistsactivas`
--

CREATE TABLE `playlistsactivas` (
  `id_playlistactiva` int(15) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `playlistsactivas`
--

INSERT INTO `playlistsactivas` (`id_playlistactiva`, `fecha`) VALUES
(1, '2023-07-24 22:00:00'),
(2, '2023-07-25 22:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlistsborradas`
--

CREATE TABLE `playlistsborradas` (
  `id_playlistborrada` int(15) NOT NULL,
  `motivo` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `playlistsborradas`
--

INSERT INTO `playlistsborradas` (`id_playlistborrada`, `motivo`, `fecha`) VALUES
(3, 'No longer needed', '2023-07-31 22:00:00');

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

--
-- Volcado de datos para la tabla `subscripciones`
--

INSERT INTO `subscripciones` (`id_subscripcion`, `id_usuario`, `inicio`, `renovacion`, `formapago`, `id_tarjeta`, `id_paypal`) VALUES
(1, 1, '2023-01-01', '2024-01-01', 'Tarjeta de Credito', 1, NULL),
(2, 3, '2023-02-01', '2024-02-01', 'PayPal', NULL, 3);

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

--
-- Volcado de datos para la tabla `tarjetas`
--

INSERT INTO `tarjetas` (`id_tarjeta`, `id_usuario`, `numero`, `mescad`, `anocad`, `cvv`) VALUES
(1, 1, 2147483647, 12, 2025, 123);

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
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `password`, `email`, `nacimiento`, `sexo`, `pais`, `cp`, `nombre`, `tipo`) VALUES
(1, 'pass123', 'user1@example.com', '1990-05-15', 'Masculino', 'USA', 10001, 'John Doe', 'premium'),
(2, 'pass456', 'user2@example.com', '1985-08-23', 'Femenino', 'Canada', 2000, 'Jane Smith', 'free'),
(3, 'pass789', 'user3@example.com', '1992-11-30', 'Otros', 'Mexico', 77500, 'Chris Gomez', 'premium');

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
  MODIFY `id_album` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id_playlist` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `subscripciones`
--
ALTER TABLE `subscripciones`
  MODIFY `id_subscripcion` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  MODIFY `id_tarjeta` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
