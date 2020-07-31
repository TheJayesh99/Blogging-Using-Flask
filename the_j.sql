-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 12, 2020 at 10:55 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `the_j`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `sno` int(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` varchar(20) NOT NULL,
  `msg` varchar(200) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sno`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `number`, `msg`, `date`) VALUES
(1, 'test', 'test@gmail.com', '1234567890', 'hi testing', '2020-01-31 18:29:36'),
(2, 'test2', 'testing@gmail.com', '9874563210', 'testing through site', '2020-01-31 18:34:46'),
(3, 'jayesh', 'jayeshm.official@gmail.com', '9632587410', 'hi testing this message', '2020-02-05 17:27:38'),
(4, 'jayseh', 'jayeshm.official@gmail.com', '9632585741', 'hi how are you', '2020-02-05 17:30:19'),
(5, 'jayseh', 'jayeshm.official@gmail.com', '9632585741', 'hi how are you', '2020-02-05 17:32:10'),
(6, 'jayseh', 'jayeshm.official@gmail.com', '9632585741', 'hi how are you', '2020-02-05 17:33:41'),
(7, 'jayseh', 'jayeshm.official@gmail.com', '9632585741', 'hi how are you', '2020-02-05 17:33:54'),
(8, 'jayseh', 'jayeshm.official@gmail.com', '9632585741', 'hi how are you', '2020-02-05 17:34:10'),
(9, 'jayseh', 'jayeshm.official@gmail.com', '9632585741', 'hi how are you', '2020-02-05 17:34:17'),
(10, 'jayseh', 'jayeshm.official@gmail.com', '9632585741', 'hi how are you', '2020-02-05 17:36:07'),
(11, 'ashwin', 'ashwin@gmail.com', '1234567891', 'hii i am ashwin ,konichiwa', '2020-02-14 17:12:37'),
(12, 'dadasd', 'dasad', 'asfasfasvasv', 'aafafqafafasf', '2020-02-23 12:13:21'),
(13, 'adasfasfaffafa', 'afafasf', 'afasfafa', 'asfsfasfasfaf', '2020-02-23 12:14:35');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `sno` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `tagline` varchar(500) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(30) NOT NULL DEFAULT 'post-bg.jpg',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sno`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'How blogs worksss', 'This is frist post ', 'first-post', 'On many blogs, the person reading the posts can leave comments, which are notes in which a person says what they think about the blog post[2]. This makes blogs good for discussion — if someone writes something that someone else does not believe to be true, someone else can fix it by writing a comment on that blog or on their own blog. Someone else cannot change what the post says, but the writer of the post can. Not all blog posts need to be talked about or fixed. But if there are a lot of people interested in a topic, they can start a discussion on the original blog, on their own blogs, or both. These people can discuss a topic or their point of view.', 'post-bg.jpg', '2020-02-14 17:41:43'),
(2, 'Variables', 'its just a vaaiables', 'Variables', 'Template variables are defined by the context dictionary passed to the template.\r\n\r\nYou can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.\r\n\r\nYou can use a dot (.) to access attributes of a variable in addition to the standard Python __getitem__ “subscript” syntax ([]).\r\n\r\nThe following lines do the same thing:', 'home-bg.jpg', '2020-02-07 16:57:24'),
(3, 'Filters', 'yo filters', 'filters', 'Variables can be modified by filters. Filters are separated from the variable by a pipe symbol (|) and may have optional arguments in parentheses. Multiple filters can be chained. The output of one filter is applied to the next.\r\n\r\nFor example, {{ name|striptags|title }} will remove all HTML Tags from variable name and title-case the output (title(striptags(name))).\r\n\r\nFilters that accept arguments have parentheses around the arguments, just like a function call. For example: {{ listx|join(\', \') }} will join a list with commas (str.join(\', \', listx)).\r\n\r\nThe List of Builtin Filters below describes all the builtin filters.', 'post-bg.jpg', '2020-02-07 17:05:28'),
(4, 'Tests', 'test', 'test', 'Beside filters, there are also so-called “tests” available. Tests can be used to test a variable against a common expression. To test a variable or expression, you add is plus the name of the test after the variable. For example, to find out if a variable is defined, you can do name is defined, which will then return true or false depending on whether name is defined in the current template context.\r\n\r\nTests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:\r\n\r\n{% if loop.index is divisibleby 3 %}\r\n{% if loop.index is divisibleby(3) %}\r\nThe List of Builtin Tests below describes all the builtin tests.', 'post-bg.jpg', '2020-02-07 17:06:13');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
