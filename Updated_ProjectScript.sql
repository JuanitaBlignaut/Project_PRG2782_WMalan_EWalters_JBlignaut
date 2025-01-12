﻿USE [master]
GO
/****** Object:  Database [PRG2782_Project]    Script Date: 2021/10/13 16:24:23 ******/
CREATE DATABASE [PRG2782_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRG2782_Project', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PRG2782_Project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PRG2782_Project_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PRG2782_Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PRG2782_Project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRG2782_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRG2782_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRG2782_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRG2782_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRG2782_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRG2782_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRG2782_Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PRG2782_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRG2782_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRG2782_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRG2782_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRG2782_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRG2782_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRG2782_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRG2782_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRG2782_Project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PRG2782_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRG2782_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRG2782_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRG2782_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRG2782_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRG2782_Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRG2782_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRG2782_Project] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PRG2782_Project] SET  MULTI_USER 
GO
ALTER DATABASE [PRG2782_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRG2782_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRG2782_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRG2782_Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRG2782_Project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRG2782_Project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PRG2782_Project] SET QUERY_STORE = OFF
GO
USE [PRG2782_Project]
GO
/****** Object:  Table [dbo].[ModuleInfo]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleInfo](
	[ModuleCode] [varchar](50) NOT NULL,
	[ModuleName] [varchar](50) NOT NULL,
	[ModuleDescription] [varchar](50) NOT NULL,
	[Links] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ModuleInfo] PRIMARY KEY CLUSTERED 
(
	[ModuleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentInfo]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentInfo](
	[StudentNumber] [int] NOT NULL,
	[StudentFullname] [varchar](50) NOT NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[ModuleCode] [varchar](50) FOREIGN KEY REFERENCES [dbo].[ModuleInfo]([ModuleCode]),
	[Photo] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spAddModule]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddModule]
(
@Mcode VARCHAR(20),
@Name VARCHAR(30),
@Desc VARCHAR(max),
@Link VARCHAR(Max)

)
AS
BEGIN 
	INSERT INTO ModuleInfo
	VALUES(@Mcode,@Name,@Desc,@Link)


END
GO
/****** Object:  StoredProcedure [dbo].[spAddStudent]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddStudent]
(
@Id INT,
@Name VARCHAR(50),
@Date date,
@Gender VARCHAR(30),
@Phone	VARCHAR(50),
@Address VARCHAR(MAX),
@Mcode VARCHAR(50),
@Image VARBINARY(MAX)


)
AS
INSERT INTO StudentInfo (StudentNumber,StudentFullname,DateOfBirth,Gender,Phone,Address,ModuleCode,Photo)
VALUES(@Id,@Name,@Date,@Gender,@Phone,@Address,@Mcode,@Image)
SET @Id=SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[spDeleteModule]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteModule]
(
@Mcode VARCHAR(20)


)

AS
BEGIN 
	DELETE FROM ModuleInfo
	WHERE ModuleCode=@Mcode


END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteStudent]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteStudent]
(
@Id INT


)

AS
BEGIN 
	DELETE FROM StudentInfo
	WHERE StudentNumber=@Id


END
GO
/****** Object:  StoredProcedure [dbo].[spGetModule]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetModule]

AS
BEGIN 
SELECT *FROM ModuleInfo	


END
GO
/****** Object:  StoredProcedure [dbo].[spGetStudents]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetStudents]
AS
BEGIN 
	SELECT * FROM StudentInfo


END
GO
/****** Object:  StoredProcedure [dbo].[spSearchModule]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSearchModule]
(
@Mcode VARCHAR(20)


)

AS
BEGIN 
	SELECT * FROM ModuleInfo
	WHERE ModuleCode=@Mcode


END
GO
/****** Object:  StoredProcedure [dbo].[spSearchStudent]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSearchStudent]
(
@Id INT


)

AS
BEGIN 
	SELECT * FROM StudentInfo
	WHERE StudentNumber=@Id


END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateModule]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateModule]
(
@Mcode VARCHAR(20),
@Name VARCHAR(30),
@Desc VARCHAR(300),
@Link VARCHAR(30)

)

AS
BEGIN 
	UPDATE ModuleInfo
	SET ModuleCode=@Mcode, ModuleName=@Name, ModuleDescription=@Desc, Links=@Link
	WHERE ModuleCode=@Mcode


END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateStudent]    Script Date: 2021/10/13 16:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateStudent]
(
@Id INT,
@Name VARCHAR(50),
@Date VARCHAR(50),
@Gender VARCHAR(30),
@Phone	VARCHAR(50),
@Address VARCHAR(MAX),
@Mcode VARCHAR(50),
@Image VARBINARY(MAX)


)
AS
UPDATE StudentInfo SET StudentNumber=@Id,StudentFullname=@Name,DateOfBirth=@Date,Gender=@Gender,
Phone=@Phone,Address=@Address,ModuleCode=@Mcode,Photo=@Image
WHERE StudentNumber=@Id
GO
USE [master]
GO
ALTER DATABASE [PRG2782_Project] SET  READ_WRITE 
GO
