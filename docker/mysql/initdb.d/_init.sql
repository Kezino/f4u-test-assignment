SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: 'f4u'
--
CREATE DATABASE IF NOT EXISTS f4u DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE f4u;

--
-- Grant privileges to user
--
GRANT ALL PRIVILEGES ON `symfony`.* TO 'f4u'@'%' WITH GRANT OPTION;
