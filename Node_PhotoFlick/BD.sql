-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 18-Jun-2019 às 00:36
-- Versão do servidor: 5.7.21
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `photoflick`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `comentario`
--

DROP TABLE IF EXISTS `comentario`;
CREATE TABLE IF NOT EXISTS `comentario` (
  `id_comentario` int(8) NOT NULL AUTO_INCREMENT,
  `comentario` varchar(200) CHARACTER SET latin1 NOT NULL,
  `id_user` int(8) NOT NULL,
  `id_publicacao` int(8) NOT NULL,
  PRIMARY KEY (`id_comentario`),
  KEY `usercoment_fk` (`id_user`),
  KEY `publicoment_fk` (`id_publicacao`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `comentario`
--

INSERT INTO `comentario` (`id_comentario`, `comentario`, `id_user`, `id_publicacao`) VALUES
(25, '#slb', 19, 10),
(26, 'Khabib é melhor xd', 19, 12),
(27, 'Bora Bruno Lageeee', 19, 10),
(28, 'miguel ribeiro ahah', 27, 14),
(29, 'hjkhjhjk', 27, 11),
(30, 'muito maquina', 27, 12),
(31, 'toooooooooooooooooooooooooooooooooooppppp', 27, 12),
(32, 'aa', 27, 12),
(33, 'a', 27, 12),
(34, 'a', 27, 12),
(35, 'hhh', 27, 12),
(36, 'aaa', 27, 10),
(37, 'FB', 27, 15),
(38, '#viana', 27, 16),
(39, '#fb', 27, 15),
(40, 'fjdklfds', 27, 16),
(41, 'aaaaa', 20, 13),
(42, 'kjdskfds', 27, 16),
(43, 'aassdsdsadasdsa', 27, 16),
(44, ',l.fdmdx,.vxc', 27, 16),
(45, 'topzao', 29, 11),
(46, 'dasdsadsa', 29, 17);

-- --------------------------------------------------------

--
-- Estrutura da tabela `gosto`
--

DROP TABLE IF EXISTS `gosto`;
CREATE TABLE IF NOT EXISTS `gosto` (
  `id_gosto` int(8) NOT NULL AUTO_INCREMENT,
  `data` varchar(60) CHARACTER SET latin1 NOT NULL,
  `id_publicacao` int(8) NOT NULL,
  `id_user` int(8) NOT NULL,
  PRIMARY KEY (`id_gosto`),
  KEY `usergosto_fk` (`id_user`),
  KEY `publicacaogosto_fk` (`id_publicacao`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `gosto`
--

INSERT INTO `gosto` (`id_gosto`, `data`, `id_publicacao`, `id_user`) VALUES
(18, '14-01-2019 18:31:56', 12, 19),
(20, '14-01-2019 18:32:08', 10, 19),
(24, '14-01-2019 20:45:52', 13, 19),
(44, '15-01-2019 20:28:07', 11, 20),
(45, '15-01-2019 20:52:41', 15, 27),
(48, '15-01-2019 20:59:10', 10, 20),
(75, '15-01-2019 21:50:52', 14, 27),
(94, '15-01-2019 23:15:43', 12, 27),
(97, '22-01-2019 10:34:03', 13, 20),
(99, '22-01-2019 12:35:01', 16, 27),
(100, '06-06-2019 16:25:34', 11, 29);

-- --------------------------------------------------------

--
-- Estrutura da tabela `gosto_comentario`
--

DROP TABLE IF EXISTS `gosto_comentario`;
CREATE TABLE IF NOT EXISTS `gosto_comentario` (
  `id_gostocoment` int(8) NOT NULL AUTO_INCREMENT,
  `id_user` int(8) NOT NULL,
  `id_comentario` int(8) NOT NULL,
  PRIMARY KEY (`id_gostocoment`),
  KEY `gostousercoment_fk` (`id_user`),
  KEY `gostocomentcoment_fk` (`id_comentario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `publicacao`
--

DROP TABLE IF EXISTS `publicacao`;
CREATE TABLE IF NOT EXISTS `publicacao` (
  `id_publicacao` int(8) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(300) CHARACTER SET latin1 NOT NULL,
  `foto` varchar(90) CHARACTER SET latin1 NOT NULL,
  `data` varchar(60) CHARACTER SET latin1 NOT NULL,
  `localizacao` varchar(80) CHARACTER SET latin1 DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `id_user` int(8) NOT NULL,
  PRIMARY KEY (`id_publicacao`),
  KEY `user_fk` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `publicacao`
--

INSERT INTO `publicacao` (`id_publicacao`, `descricao`, `foto`, `data`, `localizacao`, `estado`, `id_user`) VALUES
(10, 'Pablo Felix', 'bggri4uszxs.png', '14-01-2019 18:17:34', 'Paredes de Coura', 1, 27),
(11, 'Buenos dias Matosinhos, olha os avioes lá trás', 'op0vpv96nco.png', '14-01-2019 18:18:29', 'Matosinhos', 1, 19),
(12, 'Máquina ', 'hd8alztcsmm.png', '14-01-2019 18:19:23', 'Meadela', 1, 20),
(13, 'Grande banda !!', '6yfbaqqsj54.png', '14-01-2019 18:53:44', 'Viana do Castelo', 1, 27),
(14, 'Excelente politécnico !', '7hwg0605vv3.png', '14-01-2019 22:26:51', 'Viana do Castelo', 1, 20),
(15, '#zuckerber', '0lmor9s98o5r.png', '14-01-2019 22:28:53', 'Lisboa', 1, 20),
(16, '#viana #santaluzia', 'gv3ki43d19.png', '14-01-2019 22:30:41', 'Viana do Castelo', 1, 20),
(17, 'Dia no SAS #ruicarneiro #ondeandasgil #faltaumatranche #gandagradienteohrui', 'xcw5qi4o4sf.png', '06-06-2019 16:26:41', 'SAS', 1, 29);

-- --------------------------------------------------------

--
-- Estrutura da tabela `seguir`
--

DROP TABLE IF EXISTS `seguir`;
CREATE TABLE IF NOT EXISTS `seguir` (
  `id_seguir` int(8) NOT NULL AUTO_INCREMENT,
  `id_seguidor` int(8) NOT NULL,
  `id_seguido` int(8) NOT NULL,
  PRIMARY KEY (`id_seguir`),
  KEY `seguidor_fk` (`id_seguidor`),
  KEY `seguido_fk` (`id_seguido`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `seguir`
--

INSERT INTO `seguir` (`id_seguir`, `id_seguidor`, `id_seguido`) VALUES
(25, 19, 27),
(26, 19, 20),
(29, 20, 27),
(30, 20, 19),
(35, 27, 19),
(36, 29, 19);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(8) NOT NULL AUTO_INCREMENT,
  `e-mail` varchar(50) CHARACTER SET latin1 NOT NULL,
  `password` varchar(200) CHARACTER SET latin1 NOT NULL,
  `hash` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `data_nascimento` varchar(30) CHARACTER SET latin1 NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `data_registo` varchar(50) CHARACTER SET latin1 NOT NULL,
  `nome` varchar(50) CHARACTER SET latin1 NOT NULL,
  `foto` varchar(70) CHARACTER SET latin1 NOT NULL,
  `username` varchar(40) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`id_user`, `e-mail`, `password`, `hash`, `data_nascimento`, `ativo`, `data_registo`, `nome`, `foto`, `username`) VALUES
(19, 'xicos@gmail.com', 'f29beb0b809cdcaffe452db4013b2de01b8eeb6c', '4axyk08n3ih', '1999-05-08', 1, '2019-1-10 22:57:24', 'Francisco Santos', 'aprxcva7ux.png', 'xico'),
(20, 'miguel@ipvc.pt', 'aa6b6b15aadbe38fde608cb9a826562755f9f6eb', '41pymro1pv5', '1998-06-23', 1, '2019-1-10 23:05:25', 'Miguel Gramacho', '41pymro1pv5.png', 'miguel86'),
(27, 'hugo@gmail.com', '19285e9a1223c84e566d7ffe013088c33b80d720', 'cd6jkzna4ek', '1995-08-10', 1, '2019-1-10 23:15:28', 'Hugo Barbosa', 'cd6jkzna4ek.png', 'hugo8'),
(28, 'francisco@ipvc.pt', '8c8888d1d4e538de07c7cd9991096e4ac9490cf4', 'ptp92pwt3y', '2019-01-15', 1, '2019-1-15 21:24:44', 'Francisco', 'ptp92pwt3y.png', 'xico26'),
(29, 'filipe@gmail.com', 'cfb15ce3f16d34d17e13c6831a0fa92fd30c02bd', 'ej8gcuj4tl8', '2019-06-20', 1, '2019-6-6 16:25:08', 'Filipe Reis', 'ej8gcuj4tl8.png', 'filipe');

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `publicoment_fk` FOREIGN KEY (`id_publicacao`) REFERENCES `publicacao` (`id_publicacao`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usercoment_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `gosto`
--
ALTER TABLE `gosto`
  ADD CONSTRAINT `publicacaogosto_fk` FOREIGN KEY (`id_publicacao`) REFERENCES `publicacao` (`id_publicacao`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usergosto_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `gosto_comentario`
--
ALTER TABLE `gosto_comentario`
  ADD CONSTRAINT `gostocomentcoment_fk` FOREIGN KEY (`id_comentario`) REFERENCES `comentario` (`id_comentario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gostousercoment_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `publicacao`
--
ALTER TABLE `publicacao`
  ADD CONSTRAINT `user_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `seguir`
--
ALTER TABLE `seguir`
  ADD CONSTRAINT `seguido_fk` FOREIGN KEY (`id_seguido`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seguidor_fk` FOREIGN KEY (`id_seguidor`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
