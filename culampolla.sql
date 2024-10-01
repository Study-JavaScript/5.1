-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-07-2024 a las 13:03:31
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
-- Base de datos: `culampolla`
--
CREATE DATABASE IF NOT EXISTS `culampolla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `culampolla`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `idclient` int(15) NOT NULL,
  `nom` varchar(25) DEFAULT NULL,
  `cp` int(15) DEFAULT NULL,
  `telefon` int(15) DEFAULT NULL,
  `correu` varchar(25) DEFAULT NULL,
  `registre` date DEFAULT current_timestamp(),
  `idrecomendador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clients`
--

INSERT INTO `clients` (`idclient`, `nom`, `cp`, `telefon`, `correu`, `registre`, `idrecomendador`) VALUES
(1, 'Adan', 8197, 897654321, 'adannospam@gmail.com', '2024-07-30', NULL),
(2, 'Juanito', 9888, 786327777, 'juanito@gmail.com', '2024-07-30', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles`
--

CREATE TABLE `detalles` (
  `iddetalles` int(15) NOT NULL,
  `idfactura` int(15) DEFAULT NULL,
  `idulleres` int(15) DEFAULT NULL,
  `cantidad` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles`
--

INSERT INTO `detalles` (`iddetalles`, `idfactura`, `idulleres`, `cantidad`) VALUES
(1, 1, 2, 1),
(2, 1, 4, 1),
(3, 2, 1, 1),
(4, 2, 3, 1),
(5, 2, 5, 1),
(6, 3, 6, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `idfactura` int(15) NOT NULL,
  `data` date DEFAULT current_timestamp(),
  `idclient` int(15) DEFAULT NULL,
  `estat` varchar(10) DEFAULT NULL,
  `idvenedor` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`idfactura`, `data`, `idclient`, `estat`, `idvenedor`) VALUES
(1, '2024-07-30', 1, 'pendent', 1),
(2, '2024-07-30', 2, 'pagat', 1),
(3, '2024-07-30', 2, 'pendent', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveidor`
--

CREATE TABLE `proveidor` (
  `idproveidor` int(15) NOT NULL,
  `nom` varchar(15) DEFAULT NULL,
  `nif` varchar(15) DEFAULT NULL,
  `carrer` varchar(25) DEFAULT NULL,
  `numero` int(10) DEFAULT NULL,
  `pis` int(10) NOT NULL,
  `porta` varchar(10) NOT NULL,
  `ciutat` varchar(15) DEFAULT NULL,
  `cp` int(10) DEFAULT NULL,
  `pais` varchar(15) DEFAULT NULL,
  `telefon` int(10) DEFAULT NULL,
  `fax` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveidor`
--

INSERT INTO `proveidor` (`idproveidor`, `nom`, `nif`, `carrer`, `numero`, `pis`, `porta`, `ciutat`, `cp`, `pais`, `telefon`, `fax`) VALUES
(1, 'Proveedor A', 'NIF12345678', 'Calle Mayor', 15, 3, 'A', 'Madrid', 28001, 'España', 910000000, 0),
(2, 'Proveedor B', 'NIF87654321', 'Avenida Central', 120, 2, 'B', 'Barcelona', 8002, 'España', 930000000, 0),
(3, 'Proveedor C', 'NIF11223344', 'Paseo de Gracia', 25, 5, 'C', 'Valencia', 46001, 'España', 960000000, 0),
(4, 'Proveedor D', 'NIF44332211', 'Calle de Alcalá', 35, 4, 'D', 'Sevilla', 41001, 'España', 950000000, 0),
(5, 'Proveedor E', 'NIF99887766', 'Gran Vía', 50, 1, 'E', 'Bilbao', 48001, 'España', 940000000, 0),
(6, 'Proveedor F', 'NIF11223355', 'Calle de la Luna', 8, 1, 'F', 'Granada', 18001, 'España', 958000000, 0),
(7, 'Proveedor G', 'NIF55667788', 'Avenida de la Libertad', 22, 3, 'G', 'Zaragoza', 50001, 'España', 976000000, 0),
(8, 'Proveedor H', 'NIF22334455', 'Calle del Sol', 45, 2, 'H', 'San Sebastián', 20001, 'España', 943000000, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ulleres`
--

CREATE TABLE `ulleres` (
  `idulleres` int(15) NOT NULL,
  `marca` varchar(15) DEFAULT NULL,
  `graduacioL` float DEFAULT NULL,
  `graduacioR` float DEFAULT NULL,
  `tipo_montura` varchar(15) DEFAULT NULL,
  `color_montura` varchar(15) DEFAULT NULL,
  `preu` float DEFAULT NULL,
  `idproveidor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ulleres`
--

INSERT INTO `ulleres` (`idulleres`, `marca`, `graduacioL`, `graduacioR`, `tipo_montura`, `color_montura`, `preu`, `idproveidor`) VALUES
(1, 'Ray-Ban', -1.25, -1.5, 'Metal', 'Negro', 150, 1),
(2, 'Oakley', -0.75, -0.75, 'Pasta', 'Azul', 200, 2),
(3, 'Gucci', -2, -2.25, 'Metal', 'Oro', 350, 3),
(4, 'Prada', -1, -1.25, 'Flotant', 'Rojo', 300, 4),
(5, 'Versace', -1.5, -1.75, 'Metal', 'Plateado', 250, 5),
(6, 'Tom Ford', -0.5, -0.5, 'Pasta', 'Negro', 275, 1),
(7, 'Armani', -1.75, -2, 'Flotant', 'Verde', 220, 2),
(8, 'Burberry', -1.25, -1.25, 'Metal', 'Marrón', 180, 3),
(9, 'Dior', -0.25, -0.5, 'Flotant', 'Blanco', 400, 4),
(10, 'Chanel', -2.25, -2.5, 'Pasta', 'Negro', 450, 5),
(11, 'Fuchi', -1.25, -1.5, 'Metal', 'Negro', 150, 6),
(12, 'Pakley', -0.75, -0.75, 'Pasta', 'Azul', 200, 6),
(13, 'Tucci', -2, -2.25, 'Metal', 'Oro', 350, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venedors`
--

CREATE TABLE `venedors` (
  `idvenedor` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venedors`
--

INSERT INTO `venedors` (`idvenedor`) VALUES
(1),
(2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`idclient`),
  ADD KEY `id_cliente_recomendador` (`idrecomendador`);

--
-- Indices de la tabla `detalles`
--
ALTER TABLE `detalles`
  ADD PRIMARY KEY (`iddetalles`),
  ADD KEY `factura_detall` (`idfactura`),
  ADD KEY `ulleres_detall` (`idulleres`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`idfactura`),
  ADD KEY `cliente_factura` (`idclient`),
  ADD KEY `venedor_factura` (`idvenedor`);

--
-- Indices de la tabla `proveidor`
--
ALTER TABLE `proveidor`
  ADD PRIMARY KEY (`idproveidor`);

--
-- Indices de la tabla `ulleres`
--
ALTER TABLE `ulleres`
  ADD PRIMARY KEY (`idulleres`),
  ADD KEY `idproveidor` (`idproveidor`);

--
-- Indices de la tabla `venedors`
--
ALTER TABLE `venedors`
  ADD PRIMARY KEY (`idvenedor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `idclient` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalles`
--
ALTER TABLE `detalles`
  MODIFY `iddetalles` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `idfactura` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveidor`
--
ALTER TABLE `proveidor`
  MODIFY `idproveidor` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `ulleres`
--
ALTER TABLE `ulleres`
  MODIFY `idulleres` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `venedors`
--
ALTER TABLE `venedors`
  MODIFY `idvenedor` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `id_cliente_recomendador` FOREIGN KEY (`idrecomendador`) REFERENCES `clients` (`idclient`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalles`
--
ALTER TABLE `detalles`
  ADD CONSTRAINT `factura_detall` FOREIGN KEY (`idfactura`) REFERENCES `facturas` (`idfactura`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `ulleres_detall` FOREIGN KEY (`idulleres`) REFERENCES `ulleres` (`idulleres`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `cliente_factura` FOREIGN KEY (`idclient`) REFERENCES `clients` (`idclient`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `venedor_factura` FOREIGN KEY (`idvenedor`) REFERENCES `venedors` (`idvenedor`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Filtros para la tabla `ulleres`
--
ALTER TABLE `ulleres`
  ADD CONSTRAINT `ulleres_ibfk_1` FOREIGN KEY (`idproveidor`) REFERENCES `proveidor` (`idproveidor`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
