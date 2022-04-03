-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2020 at 05:48 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `resort_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAvailableroom` (IN `param_type` VARCHAR(20))  NO SQL
SELECT
    room.room_no
FROM
    room
WHERE
  room_type = param_type AND
  room.room_no not in 
  (
    SELECT
      room_date.room_no
    FROM
      room_date
    WHERE
      (room_date.check_in<='2022-02-13' and room_date.check_out>='2022-02-13')
      OR
      (room_date.check_in<'2022-02-19' and room_date.check_out>='2022-02-19')
      OR
      (room_date.check_in>='2022-02-13' and room_date.check_out<'2022-02-19')
   )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRoom` (IN `troom` VARCHAR(20))  NO SQL
SELECT room.room_no, room_date.cus_id, room_date.check_in, room_date.check_out FROM room INNER JOIN room_date ON room.room_no = room_date.room_no AND room_type = troom$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(3) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(211, 'abhishek@lt.com', '102030');

-- --------------------------------------------------------

--
-- Table structure for table `bill_generate`
--

CREATE TABLE `bill_generate` (
  `bill_no` int(11) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `customer_name` varchar(30) NOT NULL,
  `adult` int(3) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `total_price` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill_generate`
--

INSERT INTO `bill_generate` (`bill_no`, `customer_id`, `customer_name`, `adult`, `check_in`, `check_out`, `total_price`) VALUES
(01, 01, 'Dr.  Ross  Galler', 2, '2022-02-02', '2020-02-03', 5750),
(02, 02, 'Ms.  Rachel  Green', 2, '2022-02-03', '2022-02-04', 5550),
(03, 03, 'Mr.  Jake  Santiago', 2, '2022-02-04', '2022-02-05', 5350),
(04, 04, 'Mr.  Charls  Boyle', 2, '2022-02-05', '2022-02-06', 5250);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(10) NOT NULL,
  `title` varchar(10) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `nationality` varchar(30) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `adult` int(3) NOT NULL,
  `children` int(3) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `arrival_time` time NOT NULL,
  `status` varchar(20) NOT NULL,
  `room_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `title`, `first_name`, `last_name`, `email`, `nationality`, `phone`, `room_type`, `adult`, `children`, `check_in`, `check_out`, `arrival_time`, `status`, `room_no`) VALUES
(01, 'Dr.', 'Ross', 'Galler', 'ross.galler@friends.com', 'Indian', '8887878787', 'Deluxe Room', 2, 2, '2022-02-02', '2022-02-03', '00:00:00', 'Checked Out', 101),
(02, 'Ms.', 'Rachel', 'Green', 'rachel.g@friends.com', 'Indian', '9000000000', 'Premier Room', 2, 2, '2022-02-03', '2022-02-04', '18:24:00', 'Checked Out', 201),
(03, 'Mr.', 'Jake', 'Santiago', 'jake.p@brooklyn99.com', 'Indian', '2030201010', 'Club Room', 2, 0, '2022-02-04', '2022-02-05', '21:49:00', 'Checked In', 301),
(04, 'Mr.', 'Charls', 'Boyle', 'cb@brooklyn99.com', 'Indian', '505050505050', 'Club Room', 2, 2, '2022-02-05', '2022-02-06', '21:53:00', 'Checked In', 401);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `fullname` varchar(40) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(15) NOT NULL,
  `startdate` date NOT NULL,
  `salary` varchar(20) NOT NULL,
  `emptype` varchar(30) NOT NULL,
  `resigndate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `fullname`, `address`, `phone`, `startdate`, `salary`, `emptype`, `resigndate`) VALUES
(211, 'Abhishek Jaiswal', 'Navi Mumbai', '8767276727', '2022-02-02', '102030', 'admin', '0000-00-00'),
(210, 'Yukta Sawant', 'Mumbai', '9326737071', '2022-02-02', '30000', 'Co-Admin', '0000-00-00'),
(209, 'Swati Pandao', 'Navi Mumbai', '8329334462', '2022-02-02', '30000', 'Co-Admin', '0000-00-00'),
(204, 'Anusuya Auddy', 'Mumbai', '8452989662', '2022-02-02', '30000', 'Co-Admin', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_no` int(10) NOT NULL,
  `room_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`room_no`, `room_type`) VALUES
(101, 'Deluxe Room'),
(102, 'Deluxe Room'),
(103, 'Deluxe Room'),
(104, 'Deluxe Room'),
(105, 'Deluxe Room'),
(201, 'Premier Room'),
(202, 'Premier Room'),
(203, 'Premier Room'),
(204, 'Premier Room'),
(301, 'Orchid Suite'),
(302, 'Orchid Suite'),
(303, 'Orchid Suite'),
(304, 'Orchid Suite'),
(401, 'Club Room'),
(402, 'Club Room'),
(403, 'Club Room'),
(404, 'Club Room');

-- --------------------------------------------------------

--
-- Table structure for table `room_date`
--

CREATE TABLE `room_date` (
  `room_no` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `cus_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room_date`
--

INSERT INTO `room_date` (`room_no`, `check_in`, `check_out`, `cus_id`) VALUES
(101, '2022-02-02', '2022-02-03', 01),
(201, '2022-02-03', '2022-02-04', 02),
(301, '2022-02-04', '2022-02-05', 03),
(401, '2022-02-05', '2022-02-06', 04);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bill_generate`
--
ALTER TABLE `bill_generate`
  ADD PRIMARY KEY (`bill_no`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_no`);

--
-- Indexes for table `room_date`
--
ALTER TABLE `room_date`
  ADD KEY `room_no` (`room_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT for table `bill_generate`
--
ALTER TABLE `bill_generate`
  MODIFY `bill_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=05;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=05;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `room_no` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id`) REFERENCES `employee` (`id`);

--
-- Constraints for table `room_date`
--
ALTER TABLE `room_date`
  ADD CONSTRAINT `room_date_ibfk_1` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
