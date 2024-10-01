-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-08-2024 a las 08:38:39
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

--
-- Volcado de datos para la tabla `albumes`
--

INSERT INTO `albumes` (`id_album`, `titulo`, `publicacion`, `imagen`, `id_artista`) VALUES
(1, 'Hits of 2022', '2022-03-15', 'https://example.com/album1.jpg', 1),
(2, 'Solo Anthems', '2021-11-20', 'https://example.com/album2.jpg', 2),
(3, 'Duo Classics', '2022-07-18', 'https://example.com/album3.jpg', 3);

--
-- Volcado de datos para la tabla `albumlikes`
--

INSERT INTO `albumlikes` (`id_usuario`, `id_album`) VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 3);

--
-- Volcado de datos para la tabla `artistas`
--

INSERT INTO `artistas` (`id_artista`, `nombre`, `imagen`) VALUES
(1, 'Big Band', 'https://example.com/artist1.jpg'),
(2, 'Solo Singer', 'https://example.com/artist2.jpg'),
(3, 'Duo Performers', 'https://example.com/artist3.jpg');

--
-- Volcado de datos para la tabla `artistasrel`
--

INSERT INTO `artistasrel` (`id_artista_1`, `id_artista_2`) VALUES
(1, 2),
(2, 3);

--
-- Volcado de datos para la tabla `canciones`
--

INSERT INTO `canciones` (`id_cancion`, `titulo`, `seg`, `reproducciones`, `id_album`) VALUES
(1, 'Upbeat and Happy', 180, 150000, 1),
(2, 'Reflective Solitude', 240, 50000, 2),
(3, 'Dynamic Duets', 210, 75000, 3);

--
-- Volcado de datos para la tabla `cancionesplaylist`
--

INSERT INTO `cancionesplaylist` (`id_playlistactiva`, `id_cancion`, `id_usuario`, `fecha_adicion`) VALUES
(1, 1, 1, '2023-07-25 12:30:00'),
(1, 2, 1, '2023-07-25 12:35:00'),
(1, 3, 3, '2023-07-27 14:00:00'),
(2, 2, 2, '2023-07-26 13:00:00');

--
-- Volcado de datos para la tabla `cancionlikes`
--

INSERT INTO `cancionlikes` (`id_cancion`, `id_usuario`) VALUES
(2, 2),
(3, 1),
(3, 2),
(3, 3);

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id_pago`, `id_usuario`, `id_subscripcion`, `fecha`, `importe`, `estado`) VALUES
(1, 1, 1, '2023-01-01 11:00:00', 9.99, 'Completado'),
(2, 3, 2, '2023-02-01 11:00:00', 9.99, 'Completado');

--
-- Volcado de datos para la tabla `paypal`
--

INSERT INTO `paypal` (`id_usuario`, `email`, `nombre`) VALUES
(3, 'user3paypal@example.com', 'Chris PayPal');

--
-- Volcado de datos para la tabla `playlists`
--

INSERT INTO `playlists` (`id_playlist`, `id_usuario`, `nombre`, `fecha`, `canciones`) VALUES
(1, 1, 'Party Mix', '2023-07-25', 2),
(2, 2, 'Chill Vibes', '2023-07-26', 1),
(3, 3, 'Drive Time', '2023-07-27', 1);

--
-- Volcado de datos para la tabla `playlistsactivas`
--

INSERT INTO `playlistsactivas` (`id_playlistactiva`, `fecha`) VALUES
(1, '2023-07-24 22:00:00'),
(2, '2023-07-25 22:00:00');

--
-- Volcado de datos para la tabla `playlistsborradas`
--

INSERT INTO `playlistsborradas` (`id_playlistborrada`, `motivo`, `fecha`) VALUES
(3, 'No longer needed', '2023-07-31 22:00:00');

--
-- Volcado de datos para la tabla `subscripciones`
--

INSERT INTO `subscripciones` (`id_subscripcion`, `id_usuario`, `inicio`, `renovacion`, `formapago`, `id_tarjeta`, `id_paypal`) VALUES
(1, 1, '2023-01-01', '2024-01-01', 'Tarjeta de Credito', 1, NULL),
(2, 3, '2023-02-01', '2024-02-01', 'PayPal', NULL, 3);

--
-- Volcado de datos para la tabla `tarjetas`
--

INSERT INTO `tarjetas` (`id_tarjeta`, `id_usuario`, `numero`, `mescad`, `anocad`, `cvv`) VALUES
(1, 1, 2147483647, 12, 2025, 123);

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `password`, `email`, `nacimiento`, `sexo`, `pais`, `cp`, `nombre`, `tipo`) VALUES
(1, 'pass123', 'user1@example.com', '1990-05-15', 'Masculino', 'USA', 10001, 'John Doe', 'premium'),
(2, 'pass456', 'user2@example.com', '1985-08-23', 'Femenino', 'Canada', 2000, 'Jane Smith', 'free'),
(3, 'pass789', 'user3@example.com', '1992-11-30', 'Otros', 'Mexico', 77500, 'Chris Gomez', 'premium');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
