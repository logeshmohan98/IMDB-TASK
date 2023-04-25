-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 25, 2023 at 06:51 AM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `imdb task`
--

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
CREATE TABLE IF NOT EXISTS `artists` (
  `artist_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `bio` varchar(5000) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `dod` date DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `artist_skills`
--

DROP TABLE IF EXISTS `artist_skills`;
CREATE TABLE IF NOT EXISTS `artist_skills` (
  `artist_id` int NOT NULL,
  `skill_id` int NOT NULL,
  UNIQUE KEY `artist_id` (`artist_id`,`skill_id`) USING BTREE,
  KEY `skill_id` (`skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
CREATE TABLE IF NOT EXISTS `genres` (
  `genre_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`genre_id`, `name`) VALUES
(1, 'Drama'),
(2, 'Crime'),
(3, 'Action'),
(4, 'Thriller');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `media_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `media_type` enum('video','image') NOT NULL,
  `url` varchar(500) NOT NULL,
  PRIMARY KEY (`media_id`),
  KEY `movie_id` (`movie_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`media_id`, `movie_id`, `media_type`, `url`) VALUES
(1, 1, 'video', '/path/to/the-shawshank-redemption-trailer.mp4'),
(2, 1, 'image', '/path/to/the-shawshank-redemption-poster.jpg'),
(3, 2, 'video', '/path/to/the-godfather-trailer.mp4'),
(4, 2, 'image', '/path/to/the-godfather-poster.jpg'),
(5, 3, 'video', '/path/to/the-dark-knight-trailer.mp4'),
(6, 3, 'image', '/path/to/the-dark-knight-poster.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
CREATE TABLE IF NOT EXISTS `movies` (
  `movie_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `release_date` date NOT NULL,
  `runtime_minutes` int NOT NULL,
  `plot_summary` varchar(5000) DEFAULT NULL,
  `box_office_collection` int DEFAULT NULL,
  `imdb_rating` float DEFAULT NULL,
  `imdb_votes` int DEFAULT NULL,
  PRIMARY KEY (`movie_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`movie_id`, `title`, `release_date`, `runtime_minutes`, `plot_summary`, `box_office_collection`, `imdb_rating`, `imdb_votes`) VALUES
(1, 'The Shawshank Redemption', '1994-09-10', 142, NULL, NULL, NULL, NULL),
(2, 'The Godfather', '1972-03-24', 175, NULL, NULL, NULL, NULL),
(3, 'The Dark Knight', '2008-07-14', 152, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
CREATE TABLE IF NOT EXISTS `movie_genres` (
  `movie_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_id`),
  KEY `genre_id` (`genre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `movie_genres`
--

INSERT INTO `movie_genres` (`movie_id`, `genre_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(2, 4),
(3, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `movie_roles`
--

DROP TABLE IF EXISTS `movie_roles`;
CREATE TABLE IF NOT EXISTS `movie_roles` (
  `movie_id` int NOT NULL,
  `artist_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`movie_id`,`artist_id`,`role_id`),
  KEY `artist_id` (`artist_id`),
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `review_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int NOT NULL,
  `review_text` varchar(5000) DEFAULT NULL,
  `review_date` date NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `movie_id`, `user_id`, `rating`, `review_text`, `review_date`) VALUES
(1, 1, 1, 9, 'This movie is a classic!', '2022-01-01'),
(2, 1, 2, 8, 'Great performances all around.', '2022-01-15'),
(3, 2, 3, 10, 'One of the best movies ever made.', '2022-02-01'),
(4, 2, 4, 9, 'A true masterpiece.', '2022-02-15'),
(5, 3, 5, 8, 'A solid action movie with a great cast.', '2022-03-01'),
(6, 3, 6, 7, 'The Joker steals the show.', '2022-03-15');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
CREATE TABLE IF NOT EXISTS `skills` (
  `skill_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `registration_date` date NOT NULL,
  `last_login_date` date DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `registration_date`, `last_login_date`) VALUES
(1, 'john_doe', 'john_doe@example.com', '\0', '2023-04-25', '2023-04-25'),
(2, 'jane_doe', '12:18:40', '\0', '2023-04-25', '2023-04-25'),
(3, 'bob_smith', 'bob_smith@example.com', '', '0000-00-00', NULL),
(4, 'alice_jones', 'alice_jones@example.com', '', '0000-00-00', NULL),
(5, 'david_williams', 'david_williams@example.com', '', '0000-00-00', NULL),
(6, 'emily_davis', 'emily_davis@example.com', '', '0000-00-00', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
