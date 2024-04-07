CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `balance` int(50) NOT NULL,
  `category` text NOT NULL,
  `items` text NOT NULL,
  `duty` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;