--
-- Table structure for table `archive`
--

CREATE TABLE `archive` (
  `id` int(11) NOT NULL,
  `oid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `time1` bigint(20) NOT NULL,
  `time2` bigint(20) NOT NULL,
  `data` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cron`
--

CREATE TABLE `cron` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `time` varchar(24) NOT NULL,
  `url` varchar(128) NOT NULL,
  `date` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `data` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `error`
--

CREATE TABLE `error` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `mes` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ipmanager`
--

CREATE TABLE `ipmanager` (
  `id` int(11) NOT NULL,
  `ip` bigint(20) NOT NULL,
  `sid` int(11) NOT NULL,
  `service` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `mac` varchar(128) NOT NULL,
  `domain` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `log_income`
--

CREATE TABLE `log_income` (
  `id` int(11) NOT NULL,
  `payment_id` varchar(128) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `system` varchar(128) NOT NULL,
  `time` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `log_ip`
--

CREATE TABLE `log_ip` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `ip` bigint(20) NOT NULL,
  `platform` varchar(24) DEFAULT NULL,
  `browser` varchar(24) DEFAULT NULL,
  `time` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `log_spend`
--

CREATE TABLE `log_spend` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `oid` int(11) NOT NULL,
  `time1` bigint(20) NOT NULL,
  `time2` bigint(20) NOT NULL,
  `money` int(11) NOT NULL,
  `info` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `servers`
--

CREATE TABLE `servers` (
  `id` int(11) NOT NULL,
  `ip` bigint(20) NOT NULL,
  `port` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `domain` varchar(128) NOT NULL,
  `handler` varchar(128) DEFAULT NULL,
  `access` varchar(128) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `server` int(11) NOT NULL,
  `time1` bigint(20) NOT NULL,
  `time2` bigint(20) NOT NULL,
  `time3` int(11) DEFAULT NULL,
  `auto` int(11) NOT NULL DEFAULT '1',
  `data` varchar(1024) NOT NULL DEFAULT '{"extra":0,"extra_text":0,"extra_currency":"EUR"}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `support`
--

CREATE TABLE `support` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `open` varchar(128) NOT NULL,
  `last` varchar(128) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `support_msg`
--

CREATE TABLE `support_msg` (
  `id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `msg` mediumtext NOT NULL,
  `time` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tariff`
--

CREATE TABLE `tariff` (
  `id` int(11) NOT NULL,
  `gid` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `price` varchar(128) NOT NULL,
  `currency` varchar(128) NOT NULL DEFAULT 'EUR',
  `point` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `handler` varchar(128) NOT NULL,
  `data` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `handler` varchar(128) NOT NULL,
  `data` varchar(1024) NOT NULL,
  `info` varchar(1024) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(128) NOT NULL,
  `passwd` varchar(128) NOT NULL,
  `session` varchar(128) DEFAULT NULL,
  `bitcoin` varchar(128) DEFAULT NULL,
  `api` varchar(128) DEFAULT NULL,
  `data` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `archive`
--
ALTER TABLE `archive`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `oid` (`oid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `sid` (`sid`) USING BTREE;

--
-- Indexes for table `cron`
--
ALTER TABLE `cron`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `error`
--
ALTER TABLE `error`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `ipmanager`
--
ALTER TABLE `ipmanager`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip` (`ip`),
  ADD KEY `sid` (`sid`),
  ADD KEY `owner` (`owner`);

--
-- Indexes for table `log_income`
--
ALTER TABLE `log_income`
  ADD PRIMARY KEY (`id`),
  ADD KEY `system` (`system`),
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `log_ip`
--
ALTER TABLE `log_ip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `log_spend`
--
ALTER TABLE `log_spend`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `sid` (`oid`);

--
-- Indexes for table `servers`
--
ALTER TABLE `servers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip` (`ip`),
  ADD KEY `handler` (`handler`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gid` (`sid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `auto` (`auto`),
  ADD KEY `server` (`server`);

--
-- Indexes for table `support`
--
ALTER TABLE `support`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `support_msg`
--
ALTER TABLE `support_msg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tid` (`tid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `tariff`
--
ALTER TABLE `tariff`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gid` (`gid`),
  ADD KEY `status` (`status`),
  ADD KEY `handler` (`handler`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mail` (`login`),
  ADD UNIQUE KEY `session` (`session`),
  ADD UNIQUE KEY `bitcoin` (`bitcoin`),
  ADD UNIQUE KEY `api` (`api`),
  ADD KEY `passwd` (`passwd`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `archive`
--
ALTER TABLE `archive`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cron`
--
ALTER TABLE `cron`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `error`
--
ALTER TABLE `error`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ipmanager`
--
ALTER TABLE `ipmanager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `log_income`
--
ALTER TABLE `log_income`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `log_ip`
--
ALTER TABLE `log_ip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `log_spend`
--
ALTER TABLE `log_spend`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `servers`
--
ALTER TABLE `servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `support`
--
ALTER TABLE `support`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `support_msg`
--
ALTER TABLE `support_msg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tariff`
--
ALTER TABLE `tariff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Dumping data for table `error`
--

INSERT INTO `error` (`id`, `name`, `mes`) VALUES
(1, 'no_auth', 'Неудачная попытка входа'),
(2, 'no_user', 'Неправильный логин'),
(3, 'bad_passwd', 'Неправильный пароль'),
(4, 'block_user', 'Пользователь заблокирован'),
(5, 'empty_message', 'Пустое сообщение'),
(6, 'no_access', 'Нет доступа'),
(7, 'close_tiket', 'Тикет уже закрыт'),
(8, 'already_open', 'Тикет уже открыт'),
(9, 'empty_post_value', 'Пустой POST'),
(10, 'bad_email', 'Неправильный email'),
(11, 'user_exist', 'Такой пользователь уже существует'),
(12, 'captcha_fail', 'Проверка на бота не пройдена'),
(13, 'wrong_hash', 'Неправильный hash'),
(14, 'lost_passwd_time', 'Ссылка устарела, для восстановления пароля - получите новую ссылку'),
(15, 'no_auth_page', 'У вас нет доступа к этой странице'),
(16, 'wrong_phone', 'Неправильный телефонный номер'),
(17, 'only_numeric', 'Только цифры'),
(18, 'wrong_action', 'Неправильное действие'),
(19, 'not_valid', 'Неправильное значение у переменной'),
(20, 'max_limit', 'Вы превысили лимит'),
(21, 'wrong_ip', 'Неправильный IP'),
(22, 'wrong_mac', 'Неправильный MAC'),
(23, 'wrong_host', 'Неправильный HOST'),
(24, 'too_long_value', 'Слишком длинное значение'),
(25, 'already_get_it', 'Такая запись уже есть'),
(26, 'no_service', 'Нет такой услуги'),
(27, 'no_money', 'Пополните баланс'),
(28, 'no_moneyback', 'Нельзя сделать moneyback. Пожалуйста, обратитесь в техничекую поддержку.'),
(29, 'already_tariff', 'Вы уже используете этот тариф.'),
(30, 'error_task', 'Ошибка! Не могу добавить задание!'),
(31, 'task_already', 'Ошибка! Такое задание уже добавлено!'),
(32, 'no_gid_change_tariff', 'По этой услуге нельзя сделать манибек/ поменять тариф'),
(33, 'wrong_tariff', 'Ошибка! Неправильный тариф'),
(34, 'different_handler', 'Ошибка! Другой тип услуги'),
(35, 'deny_tor', 'Tor deny'),
(36, 'not_paid', 'Услуга не оплачена'),
(37, 'wait_60min', 'Попробуйте повторить через 60 минут'),
(38, 'cant_tariff_lower', 'Для перехода на более младший тариф => пожалуйста, обратитесь в тех поддержку.'),
(39, 'no_time', 'Время еще не истекло'),
(40, 'no_info', 'Нет информации');
