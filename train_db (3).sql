-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2024 at 04:56 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `train_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `advertisments`
--

CREATE TABLE `advertisments` (
  `img_id` int(11) NOT NULL,
  `img_path` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `advertisments`
--

INSERT INTO `advertisments` (`img_id`, `img_path`) VALUES
(1, 'img1.jpg'),
(2, 'img2.gpg');

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `ans_id` int(11) NOT NULL,
  `answer` varchar(500) NOT NULL,
  `ans_date` datetime NOT NULL DEFAULT current_timestamp(),
  `qus_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `answer`
--

INSERT INTO `answer` (`ans_id`, `answer`, `ans_date`, `qus_id`, `user_id`) VALUES
(83, 'sdscsdc', '2024-05-18 13:08:03', 99, 1),
(85, 'kjkjkjkj', '2024-05-25 16:19:39', 99, 1),
(86, '123', '2024-05-25 16:21:54', 99, 1),
(88, 'nxnxnxn', '2024-06-02 02:35:41', 99, 2);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `course_desc` varchar(500) NOT NULL,
  `course_create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `course_hours` int(11) NOT NULL,
  `course_status` tinyint(1) NOT NULL,
  `course_image` varchar(1000) NOT NULL,
  `speciality_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_id`, `course_name`, `course_desc`, `course_create_at`, `course_hours`, `course_status`, `course_image`, `speciality_id`, `teacher_id`) VALUES
(1, 'Html newCourse', 'This is New Course you will learn HTML \r\nFOM SCRATCHGOOD LUCK', '2024-03-07 22:43:48', 15, 1, 'images.png', 1, 1),
(2, 'sql Oracle', 'this is new sql course you will learn every thing about sql data base ', '2024-03-07 22:45:01', 18, 1, 'Learning-mobile-234-660x330.jpg', 3, 2),
(3, 'photoshop_2021', 'photoshop_design_ui/ux Course', '2024-03-07 22:46:07', 20, 1, 'Learning-mobile-234-660x330.jpg', 5, 3),
(4, 'Css Course', 'This Course For Learning Css Styling', '2024-03-08 23:52:40', 12, 1, 'Learning-mobile-234-660x330.jpg', 1, 1),
(6, 'Css 2021', 'This Course for Begginer', '2024-03-22 17:25:30', 15, 1, 'Learning-mobile-234-660x330.jpg', 1, 1),
(10, 'new course', 'shadi alhamdo', '2024-04-29 23:15:05', 15, 0, 'Learning-mobile-234-660x330.jpg', 1, 1),
(17, '++C', 'C++ for esy', '2024-05-29 13:55:37', 18, 1, 'ÃÂªÃÂ¹ÃÂ¯ÃÂÃÂ ÃÂÃÂ§ÃÂÃÂ¨.jpg', 1, 1),
(27, 'مادة جديدة', 'مادة جديدة للاختبار', '2024-06-02 16:50:50', 5, 1, 'Learning-mobile-234-660x330.jpg', 5, 13),
(32, 'for deleted', 'zcxzcxzcx', '2024-06-04 11:56:29', 77, 1, 'Learning-mobile-234-660x330.jpg', 1, 1),
(33, 'PHP', 'this is new', '2024-06-07 14:55:52', 15, 1, 'html.jpg', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `qus`
--

CREATE TABLE `qus` (
  `qus_id` int(11) NOT NULL,
  `question` varchar(500) NOT NULL,
  `qus_date` datetime NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `qus`
--

INSERT INTO `qus` (`qus_id`, `question`, `qus_date`, `user_id`) VALUES
(97, 'سؤال جديد؟؟؟؟؟', '2024-05-05 13:56:22', 2),
(99, 'سؤال جديد من عادل ؟؟؟؟', '2024-05-05 13:56:39', 2),
(115, 'mmkkkkk', '2024-05-10 16:56:40', 1),
(117, 'bbbbbb', '2024-06-02 01:20:52', 1),
(118, 'سؤال جديد', '2024-06-02 17:32:08', 96),
(121, 'ؤلاؤلاؤلاؤ', '2024-06-07 16:50:43', 1),
(125, 'اي اش الاخبار', '2024-06-07 16:54:51', 1);

-- --------------------------------------------------------

--
-- Table structure for table `speciality`
--

CREATE TABLE `speciality` (
  `speciality_id` int(11) NOT NULL,
  `speciality_name` varchar(200) NOT NULL,
  `speciality_img` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `speciality`
--

INSERT INTO `speciality` (`speciality_id`, `speciality_name`, `speciality_img`) VALUES
(1, 'web development', 'https://miro.medium.com/v2/resize:fit:1200/0*M4bxiCIjcTK-2Xr6.jpeg'),
(2, 'network', 'https://www.cisco.com/c/dam/assets/swa/img/anchor-info/network-designed-628x353.jpg'),
(3, 'Data_Base', 'https://zeenea.com/wp-content/uploads/2023/01/databases-zeenea.jpg.webp'),
(4, 'Languages', 'https://img.freepik.com/free-vector/language-word-concept-with-flat-design_23-2147866087.jpg'),
(5, 'Design', 'https://img.freepik.com/free-vector/illustration-creative-graphic-design_53876-27004.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `student_email` varchar(100) NOT NULL,
  `student_join` datetime NOT NULL DEFAULT current_timestamp(),
  `student_image` varchar(500) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `student_name`, `student_email`, `student_join`, `student_image`, `user_id`) VALUES
(1, 'shadi', 'vvvvvvv@gmail.com', '2024-03-07 22:49:36', 'A4.jpg', 1),
(2, 'Adel Kalaji', 'Adel@gmail.com', '2024-03-07 22:50:09', '456456.jpg', 2),
(3, 'New Student', 'student@mail.com', '2024-03-22 16:34:02', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fuser-profile-avatar_13369991.html&psig=AOvVaw12U2w6GljoqGSsNU2MPabO&ust=1711200870183000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKiN_5T-h4UDFQAAAAAdAAAAABAX', 29),
(11, 'sss', 'sg@gmail.com', '2024-05-03 18:29:29', 'ØªØ¹Ø¯ÙÙ ÙØ§ÙØ¨.jpg', 90),
(12, 'user 20288', 'useremai@gmai.com', '2024-05-13 14:24:56', '', 91),
(13, 'new test', 'test@gmail.com', '2024-05-31 23:39:19', '', 92),
(14, 'fadi', 'abofakher@hotmail.com', '2024-06-02 01:28:05', '', 95),
(15, 'طالب جديد', 'gmail.com@xn--mgbc7bxc', '2024-06-02 17:21:50', '1.png', 96);

-- --------------------------------------------------------

--
-- Table structure for table `student_course_rel`
--

CREATE TABLE `student_course_rel` (
  `sc_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student_course_join` datetime NOT NULL DEFAULT current_timestamp(),
  `student_course_evaluation` int(11) NOT NULL DEFAULT 0,
  `student_course_type` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_course_rel`
--

INSERT INTO `student_course_rel` (`sc_id`, `student_id`, `course_id`, `student_course_join`, `student_course_evaluation`, `student_course_type`) VALUES
(3, 2, 1, '2024-03-07 22:52:09', 4, 0),
(7, 2, 2, '2024-03-07 22:53:11', 2, 0),
(8, 3, 1, '2024-03-22 16:39:26', 3, 1),
(9, 2, 6, '2024-03-22 17:26:50', 3, 1),
(58, 1, 1, '2024-05-31 23:12:34', 0, 0),
(60, 11, 10, '2024-06-01 00:59:16', 3, 1),
(62, 1, 6, '2024-06-02 01:22:04', 4, 0),
(63, 1, 2, '2024-06-02 01:30:43', 0, 0),
(64, 1, 4, '2024-06-02 13:38:11', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `student_video_rel`
--

CREATE TABLE `student_video_rel` (
  `sv_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `comment_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_video_rel`
--

INSERT INTO `student_video_rel` (`sv_id`, `student_id`, `video_id`, `comment`, `comment_date`) VALUES
(1, 1, 1, 'good course ', '2024-03-07 22:53:56'),
(2, 2, 1, 'done _----_', '2024-03-07 22:53:56'),
(3, 1, 5, 'very easy', '2024-03-07 22:54:34'),
(4, 2, 2, 'that is good course', '2024-03-07 22:54:34'),
(5, 1, 5, 'i`m intersted', '2024-03-07 22:55:28'),
(6, 2, 5, 'i`m ver happy for watching', '2024-03-07 22:55:28'),
(7, 1, 4, 'that important for me', '2024-03-07 22:56:28'),
(8, 2, 3, 'this course important for data sience', '2024-03-07 22:56:28'),
(9, 1, 2, 'very good nice to watched', '2024-03-22 16:39:53'),
(10, 1, 4, 'goood sql video', '2024-03-30 22:09:51'),
(15, 1, 1, 'ewfdewfewfewew', '2024-04-02 13:54:44'),
(16, 1, 1, 'ewfdewfewfewew', '2024-04-02 13:55:40'),
(17, 1, 1, 'change ', '2024-04-02 13:56:36'),
(18, 1, 1, 'ssss', '2024-04-02 14:03:53'),
(22, 1, 2, 'bvnmnbvcbnm,', '2024-04-04 04:39:19'),
(23, 1, 2, '1ئئئئئ', '2024-04-04 04:39:35'),
(24, 1, 2, '77777', '2024-04-04 04:39:47'),
(25, 1, 3, 'vcccc test', '2024-04-04 04:42:51'),
(27, 1, 5, 'gioiuytnbnbnbnbnbnbnbyuioiuyu', '2024-04-13 14:10:30'),
(33, 1, 9, 'new comment', '2024-05-24 18:47:58'),
(34, 1, 4, 'new comment', '2024-05-24 19:03:24'),
(36, 1, 4, '   dd', '2024-05-24 19:03:32'),
(37, 1, 1, 'ddddsdsss', '2024-05-25 15:59:41'),
(41, 1, 4, 'bbbbbb', '2024-06-02 01:31:24'),
(43, 2, 10, 'nice course', '2024-06-02 03:02:47'),
(44, 2, 10, 'very good course', '2024-06-02 03:02:58'),
(45, 1, 10, 'good course', '2024-06-02 03:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL,
  `teacher_name` varchar(100) NOT NULL,
  `teacher_email` varchar(200) NOT NULL,
  `teacher_mob` varchar(20) NOT NULL,
  `teacher_image` varchar(200) NOT NULL,
  `teacher_desc` varchar(500) NOT NULL,
  `teacher_join` datetime NOT NULL DEFAULT current_timestamp(),
  `Teacher_status` tinyint(1) NOT NULL DEFAULT 0,
  `speciality_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `teacher_whatsapp` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teacher_id`, `teacher_name`, `teacher_email`, `teacher_mob`, `teacher_image`, `teacher_desc`, `teacher_join`, `Teacher_status`, `speciality_id`, `user_id`, `teacher_whatsapp`) VALUES
(1, 'Osama Elzero', 'Osama4456@gmail.com', '+123456', 'pngwing.com (27).png', 'I`m web bbbbbne1111\\r\\n', '2024-03-07 10:39:19', 1, 1, 3, 'Link whtsapp'),
(2, 'Hussen Barakat', 'hussen@gmail.com', '+987654321', 'https://www.nsba.org/-/media/ASBJ/2021/February/features/diverse-teachers-matter.jpg', 'i`m sql  developer', '2024-03-07 22:39:19', 1, 3, 4, 'link'),
(3, 'testing', 'testing@gmail.com', '+987654321', '', 'i`m new hre', '2024-06-01 17:58:22', 1, 3, 93, 'link new'),
(13, 'newtech', 'newTech@gmail.com', '+987654321', '456456.jpg', 'i`m new here', '2024-06-01 15:18:24', 1, 5, 94, 'whatsapp.link'),
(14, 'teacher_test', 'teacher@gmail.com', '123456', '', '123123', '2024-06-05 02:03:06', 0, 4, 97, 'link.com');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_pass` varchar(100) NOT NULL,
  `user_role` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_pass`, `user_role`) VALUES
(1, 'shadi', '321', 0),
(2, 'Adel Kalaji', '123', 0),
(3, 'Osama Elzero', '123', 1),
(4, 'Hussen barkat', '123', 1),
(29, 'new student', '123', 0),
(90, 'sss', '123', 0),
(91, 'user 20288', '123', 0),
(92, 'new test', '123', 0),
(93, 'testing', '123', 1),
(94, 'newtech', '123', 1),
(95, 'fadi', '123', 0),
(96, 'طالب جديد', '123', 0),
(97, 'teacher_test', '123', 1);

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `video_id` int(11) NOT NULL,
  `video_name` varchar(100) NOT NULL,
  `video_pic` varchar(200) NOT NULL,
  `video_path` varchar(200) NOT NULL,
  `video_free` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`video_id`, `video_name`, `video_pic`, `video_path`, `video_free`, `course_id`) VALUES
(1, 'html_1', 'Background.png', 'ÃÂ¬ÃÂÃÂ³ÃÂ© ÃÂ«ÃÂ§ÃÂÃÂÃÂ© ÃÂÃÂ®ÃÂ¨ÃÂ± ÃÂªÃÂµÃÂÃÂÃÂ.mp4', 1, 1),
(2, 'html_2', 'html.jpg', 'ÃÂ¬ÃÂÃÂ³ÃÂ© ÃÂ«ÃÂ§ÃÂÃÂÃÂ© ÃÂÃÂ®ÃÂ¨ÃÂ± ÃÂªÃÂµÃÂÃÂÃÂ.mp4', 1, 1),
(3, 'sql_1', 'sql.jpg', 'path.path', 1, 2),
(4, 'sql_2', 'sql.jpg', 'path.path', 1, 2),
(5, 'photo_1', 'https://img-c.udemycdn.com/course/750x422/5346430_f677.jpg', 'https://youtu.be/0DEa_aIH6es?list=PLZ5zEGbaMXXWsB4rL674dSs3K4B_95pOk', 1, 3),
(7, 'photoshoop-2', 'https://img-c.udemycdn.com/course/750x422/5346430_f677.jpg', 'https://youtu.be/0DEa_aIH6es?list=PLZ5zEGbaMXXWsB4...\n', 0, 3),
(9, 'html_4', 'html.jpg', 'ÃÂ¬ÃÂÃÂ³ÃÂ© ÃÂ«ÃÂ§ÃÂÃÂÃÂ© ÃÂÃÂ®ÃÂ¨ÃÂ± ÃÂªÃÂµÃÂÃÂÃÂ.mp4', 1, 1),
(10, 'html_5', 'html.jpg', 'ÃÂÃÂªÃÂÃÂµÃÂÃÂÃÂÃÂÃÂÃÂ  ÃÂÃÂ§ÃÂÃÂÃÂÃÂ¬ÃÂÃÂÃÂÃÂ³ÃÂÃÂ© 1 ÃÂÃÂ§ÃÂÃÂÃÂÃÂ¯ÃÂÃÂ§ÃÂÃÂ±ÃÂÃÂ© 1.mp4', 1, 1),
(15, 'فيديو', '2110-red-among-us-mainpreview-1e6fbcd0db77c81e2ae58defaadce2d44d210368ea309af119e03382f28cf351.jpg', 'Ø¬ÙØ³Ø© Ø«Ø§ÙÙØ© ÙØ®Ø¨Ø± ØªØµÙÙÙ.mp4', 0, 27),
(16, 'c++ vvideo one', '1.png', 'Ø¬ÙØ³Ø© Ø«Ø§ÙÙØ© ÙØ®Ø¨Ø± ØªØµÙÙÙ.mp4', 0, 17);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `advertisments`
--
ALTER TABLE `advertisments`
  ADD PRIMARY KEY (`img_id`);

--
-- Indexes for table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`ans_id`),
  ADD KEY `qus_id` (`qus_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `speciality_id` (`speciality_id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `qus`
--
ALTER TABLE `qus`
  ADD PRIMARY KEY (`qus_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `speciality`
--
ALTER TABLE `speciality`
  ADD PRIMARY KEY (`speciality_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `student_course_rel`
--
ALTER TABLE `student_course_rel`
  ADD PRIMARY KEY (`sc_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `student_video_rel`
--
ALTER TABLE `student_video_rel`
  ADD PRIMARY KEY (`sv_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacher_id`),
  ADD KEY `speciality_id` (`speciality_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `course_id` (`course_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `advertisments`
--
ALTER TABLE `advertisments`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `answer`
--
ALTER TABLE `answer`
  MODIFY `ans_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `qus`
--
ALTER TABLE `qus`
  MODIFY `qus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `speciality`
--
ALTER TABLE `speciality`
  MODIFY `speciality_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `student_course_rel`
--
ALTER TABLE `student_course_rel`
  MODIFY `sc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `student_video_rel`
--
ALTER TABLE `student_video_rel`
  MODIFY `sv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`qus_id`) REFERENCES `qus` (`qus_id`),
  ADD CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`),
  ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`speciality_id`) REFERENCES `speciality` (`speciality_id`);

--
-- Constraints for table `qus`
--
ALTER TABLE `qus`
  ADD CONSTRAINT `qus_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `student_course_rel`
--
ALTER TABLE `student_course_rel`
  ADD CONSTRAINT `student_course_rel_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  ADD CONSTRAINT `student_course_rel_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);

--
-- Constraints for table `student_video_rel`
--
ALTER TABLE `student_video_rel`
  ADD CONSTRAINT `student_video_rel_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  ADD CONSTRAINT `student_video_rel_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`video_id`);

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`speciality_id`) REFERENCES `speciality` (`speciality_id`);

--
-- Constraints for table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `video_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
