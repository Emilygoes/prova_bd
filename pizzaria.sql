-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 10/06/2026 às 02:00
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pizzaria`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `descricao` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nome`, `descricao`) VALUES
(1, 'tradicional', 'pizzas clássicas do cardápio'),
(2, 'especial', 'pizzas premium com ingredientes diferenciados'),
(3, 'doce', 'pizzas com recheio doce');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cidade` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nome`, `telefone`, `email`, `cidade`) VALUES
(1, 'ana souza', '(49)9111-2233', 'ana@email.com', 'Videira'),
(2, 'bruno lima', '(49)9444-5566', 'bruno@email.com', 'Caçador'),
(3, 'Carla Melo', '(49)9777-8899', 'carla@email.com', 'Fraiburgo'),
(4, 'Diego Costa', '(49)9000-1122', 'diego@email.com', 'Videira');

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

CREATE TABLE `endereco` (
  `id_endereco` int(11) NOT NULL,
  `rua` varchar(150) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `bairro` varchar(80) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `endereco`
--

INSERT INTO `endereco` (`id_endereco`, `rua`, `numero`, `bairro`, `id_cliente`) VALUES
(1, 'rua das flores', '123', 'Centro', 1),
(2, 'Av.Brasil', '456', 'São Cristóvão', 2),
(3, 'rua XV de Novembro', '789', 'centro', 3),
(4, 'Rua Tiradentes', '321', 'Vila Nova', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_pedidos`
--

CREATE TABLE `log_pedidos` (
  `id_log` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `data_hora` datetime DEFAULT NULL,
  `mensagem` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `data_pedido` date NOT NULL,
  `quantidade` int(11) NOT NULL,
  `status_pedido` varchar(30) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_pizza` int(11) DEFAULT NULL,
  `desconto` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `data_pedido`, `quantidade`, `status_pedido`, `id_cliente`, `id_pizza`, `desconto`) VALUES
(1, '2024-10-01', 1, 'entregue', 1, 2, 0.00),
(2, '2024-10-03', 2, 'entregue', 2, 1, 0.00),
(3, '2024-10-05', 1, 'entregue', 3, 3, 0.00),
(4, '2024-10-07', 3, 'Em preparo', 1, 1, 0.00),
(5, '2024-10-10', 1, 'Aguardando', 4, 4, 0.00);

--
-- Acionadores `pedido`
--
DELIMITER $$
CREATE TRIGGER `trg_log_pedido` AFTER INSERT ON `pedido` FOR EACH ROW begin

insert into log_pedido (id_pedido, data_hora, mensagem)
values (new.id_pedido, now (), 'novo pedido registrado');
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pizza`
--

CREATE TABLE `pizza` (
  `id_pizza` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `sabor` varchar(80) NOT NULL,
  `tamanho` varchar(20) NOT NULL,
  `preco` decimal(8,0) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pizza`
--

INSERT INTO `pizza` (`id_pizza`, `nome`, `sabor`, `tamanho`, `preco`, `id_categoria`) VALUES
(1, 'margheritta', 'Queijo e tomate', 'M', 36, 1),
(2, 'Portuguesa', 'Presunto e ovos', 'G', 50, 1),
(3, 'Frango BBQ', 'Frango e barbecue', 'G', 55, 2),
(4, 'Chocolate', 'Nutella e morango', 'M', 42, 3);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_pizza_cardapio`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_pizza_cardapio` (
`nome` varchar(200)
,`sabor` varchar(80)
,`tamanho` varchar(20)
,`pizza` decimal(8,0)
,`categoria` varchar(80)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_pizza_cardapio`
--
DROP TABLE IF EXISTS `vw_pizza_cardapio`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_pizza_cardapio`  AS SELECT `p`.`nome` AS `nome`, `p`.`sabor` AS `sabor`, `p`.`tamanho` AS `tamanho`, `p`.`preco` AS `pizza`, `c`.`nome` AS `categoria` FROM (`pizza` `p` join `categoria` `c` on(`p`.`id_categoria` = `c`.`id_categoria`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`id_endereco`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Índices de tabela `log_pedidos`
--
ALTER TABLE `log_pedidos`
  ADD PRIMARY KEY (`id_log`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_pizza` (`id_pizza`);

--
-- Índices de tabela `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`id_pizza`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `id_endereco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `log_pedidos`
--
ALTER TABLE `log_pedidos`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `pizza`
--
ALTER TABLE `pizza`
  MODIFY `id_pizza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `endereco`
--
ALTER TABLE `endereco`
  ADD CONSTRAINT `endereco_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_pizza`) REFERENCES `pizza` (`id_pizza`);

--
-- Restrições para tabelas `pizza`
--
ALTER TABLE `pizza`
  ADD CONSTRAINT `pizza_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
