-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-07-2024 a las 00:20:40
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
-- Base de datos: `pizzeria`
--
CREATE DATABASE IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pizzeria`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_pizzas`
--

CREATE TABLE `categorias_pizzas` (
  `id_categoria` int(15) NOT NULL,
  `nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_pizzas`
--

INSERT INTO `categorias_pizzas` (`id_categoria`, `nombre`) VALUES
(1, 'Massa Clásica'),
(2, 'Massa Gruesa'),
(3, 'Massa Cheese');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(15) NOT NULL,
  `nombre` varchar(15) NOT NULL,
  `apellidos` varchar(15) NOT NULL,
  `cp` int(5) NOT NULL,
  `localidad` varchar(15) NOT NULL,
  `provincia` varchar(15) NOT NULL,
  `telefono` int(15) NOT NULL,
  `direccion` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `apellidos`, `cp`, `localidad`, `provincia`, `telefono`, `direccion`) VALUES
(1, 'Juan', 'Pérez', 28001, 'Madrid', 'Madrid', 600123456, 'C/Diagonal, 345'),
(2, 'Ana', 'López', 8001, 'Barcelona', 'Barcelona', 600654321, 'C/Ansem, 17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles`
--

CREATE TABLE `detalles` (
  `id_detalle` int(15) NOT NULL,
  `id_pedido` int(15) NOT NULL,
  `cantidad` int(15) NOT NULL DEFAULT 1,
  `id_producto` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles`
--

INSERT INTO `detalles` (`id_detalle`, `id_pedido`, `cantidad`, `id_producto`) VALUES
(1, 1, 2, 1),
(2, 1, 1, 3),
(3, 2, 3, 4),
(4, 3, 2, 2),
(5, 3, 1, 4);

--
-- Disparadores `detalles`
--
DELIMITER $$
CREATE TRIGGER `actualizar_total_pedido_detalles_insert` AFTER INSERT ON `detalles` FOR EACH ROW BEGIN
    DECLARE total_pedido FLOAT;

    -- Calcula el total sumando los productos * cantidad para todos los detalles del pedido
    SELECT SUM(d.cantidad * p.precio) INTO total_pedido
    FROM detalles d
    JOIN productos p ON d.id_producto = p.id_producto
    WHERE d.id_pedido = NEW.id_pedido;

    -- Actualiza el total en la tabla pedidos
    UPDATE pedidos
    SET total = total_pedido
    WHERE id_pedido = NEW.id_pedido;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(15) NOT NULL,
  `nombre` varchar(15) NOT NULL,
  `apellidos` varchar(15) NOT NULL,
  `nif` varchar(15) NOT NULL,
  `telefono` int(15) NOT NULL,
  `id_tienda` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `nombre`, `apellidos`, `nif`, `telefono`, `id_tienda`) VALUES
(1, 'Carlos', 'Gómez', '12345678A', 600987654, 1),
(2, 'María', 'Martínez', '87654321B', 600876543, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(15) NOT NULL,
  `hora` date NOT NULL DEFAULT current_timestamp(),
  `envio` tinyint(1) NOT NULL,
  `total` float DEFAULT NULL,
  `id_tienda` int(15) NOT NULL,
  `id_empleado` int(15) DEFAULT NULL,
  `hora_entrega` time(6) DEFAULT NULL,
  `id_cliente` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `hora`, `envio`, `total`, `id_tienda`, `id_empleado`, `hora_entrega`, `id_cliente`) VALUES
(1, '2024-07-30', 1, 20.5, 1, 1, '14:00:00.000000', 1),
(2, '2024-07-30', 0, 4.5, 2, 2, '13:30:00.000000', 2),
(3, '2024-07-30', 1, 18.5, 1, 1, '15:00:00.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(15) NOT NULL,
  `nombre` varchar(15) NOT NULL,
  `categoria` enum('pizza','hamburguesa','bebida') NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `imagen` varchar(15) NOT NULL,
  `precio` float NOT NULL,
  `id_categoria` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `categoria`, `descripcion`, `imagen`, `precio`, `id_categoria`) VALUES
(1, 'pizza', 'pizza', 'Pizza Margherita con tomate y mozzarella', 'margherita.jpg', 7.5, 1),
(2, 'pizza', 'pizza', 'Pizza con pepperoni', 'pepperoni.jpg', 8.5, 2),
(3, 'hamburguesa', 'pizza', 'Hamburguesa con queso', 'cheeseburger.jp', 5.5, NULL),
(4, 'bebida', 'pizza', 'Coca Cola', 'cocacola.jpg', 1.5, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiendas`
--

CREATE TABLE `tiendas` (
  `id_tienda` int(15) NOT NULL,
  `direccion` varchar(15) NOT NULL,
  `cp` int(5) NOT NULL,
  `localidad` varchar(15) NOT NULL,
  `provincia` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tiendas`
--

INSERT INTO `tiendas` (`id_tienda`, `direccion`, `cp`, `localidad`, `provincia`) VALUES
(1, 'Avenida Siempre', 28001, 'Madrid', 'Madrid'),
(2, 'Calle Falsa 456', 8001, 'Barcelona', 'Barcelona');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias_pizzas`
--
ALTER TABLE `categorias_pizzas`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `detalles`
--
ALTER TABLE `detalles`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `detalle_pedido` (`id_pedido`),
  ADD KEY `producto_detalle` (`id_producto`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `tienda_empleado` (`id_tienda`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `pedido_cliente` (`id_cliente`),
  ADD KEY `repartidor_pedido` (`id_empleado`),
  ADD KEY `tienda_pedido` (`id_tienda`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `tiendas`
--
ALTER TABLE `tiendas`
  ADD PRIMARY KEY (`id_tienda`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias_pizzas`
--
ALTER TABLE `categorias_pizzas`
  MODIFY `id_categoria` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tiendas`
--
ALTER TABLE `tiendas`
  MODIFY `id_tienda` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalles`
--
ALTER TABLE `detalles`
  ADD CONSTRAINT `detalle_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  ADD CONSTRAINT `producto_detalle` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `tienda_empleado` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id_tienda`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedido_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `repartidor_pedido` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`),
  ADD CONSTRAINT `tienda_pedido` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id_tienda`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `categoria_producto` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_pizzas` (`id_categoria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
