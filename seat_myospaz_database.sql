USE [master]
GO
/****** Object:  Database [Seat_myospaz]    Script Date: 2023-06-19 7:06:46 PM ******/
CREATE DATABASE [Seat_myospaz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Seat_myospaz', FILENAME = N'D:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\Seat_myospaz.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Seat_myospaz_log', FILENAME = N'D:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\Seat_myospaz_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Seat_myospaz] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Seat_myospaz].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Seat_myospaz] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Seat_myospaz] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Seat_myospaz] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Seat_myospaz] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Seat_myospaz] SET ARITHABORT OFF 
GO
ALTER DATABASE [Seat_myospaz] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Seat_myospaz] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Seat_myospaz] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Seat_myospaz] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Seat_myospaz] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Seat_myospaz] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Seat_myospaz] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Seat_myospaz] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Seat_myospaz] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Seat_myospaz] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Seat_myospaz] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Seat_myospaz] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Seat_myospaz] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Seat_myospaz] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Seat_myospaz] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Seat_myospaz] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Seat_myospaz] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Seat_myospaz] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Seat_myospaz] SET  MULTI_USER 
GO
ALTER DATABASE [Seat_myospaz] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Seat_myospaz] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Seat_myospaz] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Seat_myospaz] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Seat_myospaz] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Seat_myospaz] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Seat_myospaz] SET QUERY_STORE = OFF
GO
USE [Seat_myospaz]
GO
/****** Object:  User [Myospaz]    Script Date: 2023-06-19 7:06:47 PM ******/
CREATE USER [Myospaz] FOR LOGIN [Myospaz] WITH DEFAULT_SCHEMA=[Myospaz]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [Myospaz]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [Myospaz]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Myospaz]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Myospaz]
GO
/****** Object:  Schema [Masters]    Script Date: 2023-06-19 7:06:47 PM ******/
CREATE SCHEMA [Masters]
GO
/****** Object:  Schema [Myospaz]    Script Date: 2023-06-19 7:06:47 PM ******/
CREATE SCHEMA [Myospaz]
GO
/****** Object:  UserDefinedTableType [dbo].[FloorListUT]    Script Date: 2023-06-19 7:06:47 PM ******/
CREATE TYPE [dbo].[FloorListUT] AS TABLE(
	[FloorId] [nvarchar](max) NULL,
	[FloorName] [nvarchar](max) NULL,
	[IsType] [varchar](1) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UserAccessListUT]    Script Date: 2023-06-19 7:06:47 PM ******/
CREATE TYPE [dbo].[UserAccessListUT] AS TABLE(
	[RowId] [nvarchar](max) NULL,
	[Id] [bigint] NULL,
	[UserId] [nvarchar](max) NULL,
	[Select] [nvarchar](max) NULL,
	[IsType] [varchar](1) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UserFloorListUT]    Script Date: 2023-06-19 7:06:47 PM ******/
CREATE TYPE [dbo].[UserFloorListUT] AS TABLE(
	[RowId] [varchar](max) NULL,
	[FloorId] [varchar](max) NULL,
	[FloorName] [nvarchar](max) NULL,
	[Select] [varchar](max) NULL,
	[IsType] [varchar](1) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[GetFormattedDate]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetFormattedDate] 
(
	@vVal Datetime
)
RETURNS varchar(255)
AS
BEGIN

	Declare @mDT NVARCHAR(20)

	IF(@vVal = '01-Jan-1900 12:00 AM')
	BEGIN
		Select @mDT = ''
	END
	ELSE
	BEGIN
		Select @mDT = FORMAT(@vVal, 'yyyy-MM-dd hh:mm')
	END

	RETURN @mDT

END
GO
/****** Object:  Table [dbo].[SeatingLogHistory]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeatingLogHistory](
	[id] [bigint] NOT NULL,
	[UserId] [bigint] NULL,
	[FloorId] [bigint] NULL,
	[FloorMapId] [bigint] NULL,
	[IsBooked] [bit] NULL,
	[UsageStartTime] [datetime] NOT NULL,
	[UsageEndTime] [datetime] NOT NULL,
	[IsWFH] [bit] NULL,
	[Status] [varchar](100) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_SeatingLogHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeatingLogToday]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeatingLogToday](
	[id] [bigint] NOT NULL,
	[UserId] [bigint] NULL,
	[FloorId] [bigint] NULL,
	[FloorMapId] [bigint] NULL,
	[IsBooked] [bit] NULL,
	[UsageStartTime] [datetime] NOT NULL,
	[UsageEndTime] [datetime] NOT NULL,
	[IsWFH] [bit] NULL,
	[Status] [varchar](100) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_SeatingLogToday] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ImageDtls]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ImageDtls](
	[ImgId] [bigint] NOT NULL,
	[PId] [bigint] NOT NULL,
	[ImageName] [nvarchar](255) NULL,
	[OrgImageName] [nvarchar](max) NULL,
	[ImageDesc] [nvarchar](255) NULL,
	[ImagePath] [nvarchar](255) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_ImageDtls] PRIMARY KEY CLUSTERED 
(
	[ImgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ProfPicImageDtls]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ProfPicImageDtls](
	[ImgId] [bigint] NOT NULL,
	[PId] [bigint] NOT NULL,
	[ImageName] [nvarchar](255) NULL,
	[OrgImageName] [nvarchar](max) NULL,
	[ImageDesc] [nvarchar](255) NULL,
	[ImagePath] [nvarchar](255) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ResetSPLog]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ResetSPLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StartDateTime] [datetime] NULL,
	[ComplDateTime] [datetime] NULL,
 CONSTRAINT [PK_tbl_ResetSPLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ResetSPLogError]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ResetSPLogError](
	[LogId] [bigint] IDENTITY(1,1) NOT NULL,
	[ErrorMessage] [varchar](max) NULL,
	[ErrorSeverity] [varchar](max) NULL,
	[ErrorState] [varchar](max) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_ResetSPLogError] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Roles]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Roles](
	[RoleId] [bigint] NOT NULL,
	[RoleCode] [nvarchar](50) NULL,
	[Rolename] [nvarchar](255) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_ControllerMap]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_ControllerMap](
	[ControllerId] [bigint] NOT NULL,
	[ControllerName] [nvarchar](255) NOT NULL,
	[ControllerDesc] [nvarchar](255) NOT NULL,
	[Status] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_ControllerMap] PRIMARY KEY CLUSTERED 
(
	[ControllerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_ControllerMap_FloorAdmin]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_ControllerMap_FloorAdmin](
	[Id] [bigint] NOT NULL,
	[ControllerMapId] [bigint] NULL,
	[UserId] [bigint] NOT NULL,
	[RoleCode] [nvarchar](500) NOT NULL,
	[RoleId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](500) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_Users_FloorAdmin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_Department]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_Department](
	[DeptId] [bigint] NOT NULL,
	[DeptCode] [nvarchar](max) NULL,
	[DeptName] [nvarchar](255) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_Department] PRIMARY KEY CLUSTERED 
(
	[DeptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_Floor]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_Floor](
	[FloorId] [bigint] NOT NULL,
	[FloorCode] [nvarchar](max) NOT NULL,
	[FloorSrNo] [bigint] NOT NULL,
	[FloorName] [nvarchar](255) NOT NULL,
	[FloorDesc] [nvarchar](max) NULL,
	[FloorImageId] [bigint] NOT NULL,
	[RevNo] [bigint] NOT NULL,
	[UsernameFontsize] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[ControllerId] [bigint] NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_Floor] PRIMARY KEY CLUSTERED 
(
	[FloorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_FloorMap]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_FloorMap](
	[Id] [bigint] NOT NULL,
	[FloorId] [bigint] NOT NULL,
	[Width] [nvarchar](50) NOT NULL,
	[Height] [nvarchar](50) NOT NULL,
	[DeptId] [bigint] NULL,
	[SeatId] [nvarchar](max) NOT NULL,
	[SeatDetails] [nvarchar](500) NOT NULL,
	[CurrentX] [nvarchar](500) NOT NULL,
	[CurrentY] [nvarchar](500) NOT NULL,
	[Status] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_FloorMap] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_UserAccess]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_UserAccess](
	[UserAccessId] [bigint] NOT NULL,
	[FloorId] [bigint] NOT NULL,
	[FloorDesc] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_UserAccess] PRIMARY KEY CLUSTERED 
(
	[UserAccessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_UserAccess_BKp]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_UserAccess_BKp](
	[UserAccessId] [bigint] NOT NULL,
	[FloorId] [bigint] NOT NULL,
	[FloorDesc] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_UserAccess_Users]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_UserAccess_Users](
	[Id] [bigint] NOT NULL,
	[UserAccessId] [bigint] NULL,
	[UserId] [bigint] NULL,
	[ActionType] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[ActionDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_UserAccess_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_UserAccess_UsersBkp]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_UserAccess_UsersBkp](
	[Id] [bigint] NOT NULL,
	[UserAccessId] [bigint] NULL,
	[UserId] [bigint] NULL,
	[ActionType] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[ActionDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Masters].[tbl_Users]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Masters].[tbl_Users](
	[UserId] [bigint] NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](500) NOT NULL,
	[FNKanji] [nvarchar](255) NOT NULL,
	[LNKanji] [nvarchar](255) NOT NULL,
	[FNFurigana] [nvarchar](255) NULL,
	[LNFurigana] [nvarchar](255) NULL,
	[FNRomaji] [nvarchar](255) NULL,
	[LNRomaji] [nvarchar](255) NULL,
	[RoleId] [bigint] NULL,
	[DeptId] [bigint] NULL,
	[FloorId] [bigint] NULL,
	[IsActive] [bit] NOT NULL,
	[UserDisplay] [nvarchar](500) NULL,
	[UserTitle] [nvarchar](500) NULL,
	[HomeMapFloorId] [bigint] NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SeatingLogHistory] ADD  CONSTRAINT [DF_SeatingLogHistory_Status]  DEFAULT ('') FOR [Status]
GO
ALTER TABLE [dbo].[SeatingLogToday] ADD  CONSTRAINT [DF_SeatingLogToday_CreatedOn]  DEFAULT ('') FOR [UsageStartTime]
GO
ALTER TABLE [dbo].[SeatingLogToday] ADD  CONSTRAINT [DF_SeatingLogToday_UsageEndTime]  DEFAULT ('') FOR [UsageEndTime]
GO
ALTER TABLE [dbo].[SeatingLogToday] ADD  CONSTRAINT [DF_SeatingLogToday_Status]  DEFAULT ('') FOR [Status]
GO
ALTER TABLE [dbo].[tbl_Roles] ADD  CONSTRAINT [DF_tbl_Roles_RoleCode]  DEFAULT ('') FOR [RoleCode]
GO
ALTER TABLE [dbo].[tbl_Roles] ADD  CONSTRAINT [DF_tbl_Roles_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Masters].[tbl_ControllerMap] ADD  CONSTRAINT [DF_tbl_ControllerMap_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [Masters].[tbl_ControllerMap] ADD  CONSTRAINT [DF_tbl_ControllerMap_CreatedOn]  DEFAULT ('') FOR [CreatedOn]
GO
ALTER TABLE [Masters].[tbl_ControllerMap] ADD  CONSTRAINT [DF_tbl_ControllerMap_CreatedOn1]  DEFAULT ('') FOR [UpdatedOn]
GO
ALTER TABLE [Masters].[tbl_ControllerMap_FloorAdmin] ADD  CONSTRAINT [DF_tbl_Users_FloorAdmin_RoleCode]  DEFAULT ('') FOR [RoleCode]
GO
ALTER TABLE [Masters].[tbl_ControllerMap_FloorAdmin] ADD  CONSTRAINT [DF_tbl_Users_FloorAdmin_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Masters].[tbl_Department] ADD  CONSTRAINT [DF_tbl_Department_DeptName]  DEFAULT ('') FOR [DeptName]
GO
ALTER TABLE [Masters].[tbl_Department] ADD  CONSTRAINT [DF_tbl_Department_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Masters].[tbl_Department] ADD  CONSTRAINT [DF_tbl_Department_CreatedOn]  DEFAULT ('') FOR [CreatedOn]
GO
ALTER TABLE [Masters].[tbl_Department] ADD  CONSTRAINT [DF_tbl_Department_UpdatedOn]  DEFAULT ('') FOR [UpdatedOn]
GO
ALTER TABLE [Masters].[tbl_Floor] ADD  CONSTRAINT [DF_tbl_Floor_UsernameFontsize]  DEFAULT ((11)) FOR [UsernameFontsize]
GO
ALTER TABLE [Masters].[tbl_Floor] ADD  CONSTRAINT [DF_tbl_Floor_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Masters].[tbl_Floor] ADD  CONSTRAINT [DF_tbl_Floor_CreatedOn]  DEFAULT ('') FOR [CreatedOn]
GO
ALTER TABLE [Masters].[tbl_Floor] ADD  CONSTRAINT [DF_tbl_Floor_UpdatedOn]  DEFAULT ('') FOR [UpdatedOn]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_Width]  DEFAULT ('') FOR [Width]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_Height]  DEFAULT ('') FOR [Height]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_SeatDetails]  DEFAULT ('') FOR [SeatDetails]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_CurrentXY]  DEFAULT ('') FOR [CurrentX]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_CurrentY]  DEFAULT ('') FOR [CurrentY]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_CreatedOn]  DEFAULT ('') FOR [CreatedOn]
GO
ALTER TABLE [Masters].[tbl_FloorMap] ADD  CONSTRAINT [DF_tbl_FloorMap_UpdatedOn]  DEFAULT ('') FOR [UpdatedOn]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_Username]  DEFAULT ('') FOR [Username]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_Password]  DEFAULT ('') FOR [Password]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_FNKanji]  DEFAULT ('') FOR [FNKanji]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_LNKanji]  DEFAULT ('') FOR [LNKanji]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_FNFurigana]  DEFAULT ('') FOR [FNFurigana]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_LNFurigana]  DEFAULT ('') FOR [LNFurigana]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_FNRomaji]  DEFAULT ('') FOR [FNRomaji]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_LNRomaji]  DEFAULT ('') FOR [LNRomaji]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_UserDisplay]  DEFAULT ('') FOR [UserDisplay]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_UserTitle]  DEFAULT ('') FOR [UserTitle]
GO
ALTER TABLE [Masters].[tbl_Users] ADD  CONSTRAINT [DF_tbl_Users_CreatedOn]  DEFAULT ('') FOR [CreatedOn]
GO
ALTER TABLE [dbo].[SeatingLogHistory]  WITH CHECK ADD  CONSTRAINT [FK_SeatingLogHistory_SeatingLogHistory] FOREIGN KEY([id])
REFERENCES [dbo].[SeatingLogHistory] ([id])
GO
ALTER TABLE [dbo].[SeatingLogHistory] CHECK CONSTRAINT [FK_SeatingLogHistory_SeatingLogHistory]
GO
ALTER TABLE [dbo].[SeatingLogToday]  WITH CHECK ADD  CONSTRAINT [FK_SeatingLogToday_tbl_Floor] FOREIGN KEY([FloorId])
REFERENCES [Masters].[tbl_Floor] ([FloorId])
GO
ALTER TABLE [dbo].[SeatingLogToday] CHECK CONSTRAINT [FK_SeatingLogToday_tbl_Floor]
GO
ALTER TABLE [dbo].[SeatingLogToday]  WITH CHECK ADD  CONSTRAINT [FK_SeatingLogToday_tbl_FloorMap] FOREIGN KEY([FloorMapId])
REFERENCES [Masters].[tbl_FloorMap] ([Id])
GO
ALTER TABLE [dbo].[SeatingLogToday] CHECK CONSTRAINT [FK_SeatingLogToday_tbl_FloorMap]
GO
ALTER TABLE [Masters].[tbl_ControllerMap_FloorAdmin]  WITH CHECK ADD  CONSTRAINT [FK_tbl_ControllerMap_FloorAdmin_tbl_ControllerMap] FOREIGN KEY([ControllerMapId])
REFERENCES [Masters].[tbl_ControllerMap] ([ControllerId])
GO
ALTER TABLE [Masters].[tbl_ControllerMap_FloorAdmin] CHECK CONSTRAINT [FK_tbl_ControllerMap_FloorAdmin_tbl_ControllerMap]
GO
ALTER TABLE [Masters].[tbl_Floor]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Floor_tbl_ControllerMap] FOREIGN KEY([ControllerId])
REFERENCES [Masters].[tbl_ControllerMap] ([ControllerId])
GO
ALTER TABLE [Masters].[tbl_Floor] CHECK CONSTRAINT [FK_tbl_Floor_tbl_ControllerMap]
GO
ALTER TABLE [Masters].[tbl_UserAccess]  WITH CHECK ADD  CONSTRAINT [FK_tbl_UserAccess_tbl_Floor] FOREIGN KEY([FloorId])
REFERENCES [Masters].[tbl_Floor] ([FloorId])
GO
ALTER TABLE [Masters].[tbl_UserAccess] CHECK CONSTRAINT [FK_tbl_UserAccess_tbl_Floor]
GO
ALTER TABLE [Masters].[tbl_UserAccess_Users]  WITH CHECK ADD  CONSTRAINT [FK_tbl_UserAccess_Users_tbl_UserAccess] FOREIGN KEY([UserAccessId])
REFERENCES [Masters].[tbl_UserAccess] ([UserAccessId])
GO
ALTER TABLE [Masters].[tbl_UserAccess_Users] CHECK CONSTRAINT [FK_tbl_UserAccess_Users_tbl_UserAccess]
GO
ALTER TABLE [Masters].[tbl_Users]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Users_tbl_Floor] FOREIGN KEY([FloorId])
REFERENCES [Masters].[tbl_Floor] ([FloorId])
GO
ALTER TABLE [Masters].[tbl_Users] CHECK CONSTRAINT [FK_tbl_Users_tbl_Floor]
GO
/****** Object:  StoredProcedure [dbo].[spr_Floor_BookSeat]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spr_Floor_BookSeat]
	@vId			BIGINT,
	@vFloorId		BIGINT,
	@vUserId		BIGINT,
	@vFloorMapId	BIGINT,
	@vIsBook		VARCHAR(1),
	@vCurrUsrId		BIGINT,
	@vIsWFH			BIT = 0
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mIsWFH	BIT = NULL

	IF EXISTS(Select 1
			  FROM [dbo].[SeatingLogToday] A
			  Where A.UserId = @vUserId AND IsBooked = 1)
	BEGIN
		
		Update A
		SET A.IsBooked = 0,
			A.[Status] = 'Complete',
			A.[UsageEndTime] = GETDATE()
		FROM [dbo].[SeatingLogToday] A
		WHere A.UserId = @vUserId AND A.[UsageEndTime] = ''

		--Update A
		--SET A.IsBooked = 0,
		--	A.[Status] = 'Complete',
		--	A.[UsageEndTime] = GETDATE()
		--FROM [dbo].[SeatingLogHistory] A
		--WHere A.UserId = @vUserId AND A.[UsageEndTime] = ''

	END

	IF EXISTS(Select 1
			  FROM [dbo].[SeatingLogToday] A
			  Where A.UserId = @vUserId AND A.IsWFH = 1)
	BEGIN
		
		Update A
		SET A.[Status] = 'Complete',
			A.[UsageEndTime] = GETDATE()
		FROM [dbo].[SeatingLogToday] A
		WHere A.UserId = @vUserId AND A.[UsageEndTime] = ''

		--Update A
		--SET A.[Status] = 'Complete',
		--	A.[UsageEndTime] = GETDATE()
		--FROM [dbo].[SeatingLogHistory] A
		--WHere A.UserId = @vUserId AND A.[UsageEndTime] = ''

	END

	IF((@vIsWFH = 1 OR @vIsWFH = 0) AND EXISTS(Select 1
												  FROM [dbo].[SeatingLogToday] A
												  Where A.UserId = @vUserId AND A.IsWFH IS NOT NULL 
														AND DATEDIFF(Day,A.UsageStartTime,GETDATE()) = 0
														AND A.UsageEndTime = ''))
	BEGIN
		
		Update A
		SET A.IsWFH = @vIsWFH,
			A.UpdatedBy = @vCurrUsrId,
			A.UsageStartTime = GETDATE(),
			A.UpdatedOn = GETDATE(),
			A.[Status] = CASE WHEN @vIsWFH = 0 THEN 'Complete' ELSE '' END 
		FROM [dbo].[SeatingLogToday] A
		Where A.UserId = @vUserId AND A.IsWFH IS NOT NULL AND DATEDIFF(Day,A.UsageStartTime,GETDATE()) = 0 

		RETURN

	END
	
	Declare @mId INT,@mSLHId INT

	Select @mId = ISNULL(MAX(Id),0) + 1
	FROM [dbo].[SeatingLogToday]

	INSERT INTO [dbo].[SeatingLogToday]
	(
		id, UserId, FloorId, FloorMapId, IsBooked,UsageStartTime, UsageEndTime,IsWFH, CreatedBy
	)
	Select @mId,@vUserId,@vFloorId,@vFloorMapId,@vIsBook,GETDATE(),'',@vIsWFH,@vCurrUsrId

	--Select @mSLHId = ISNULL(MAX(Id),0) + 1
	--FROM [dbo].[SeatingLogHistory]

	--INSERT INTO [dbo].[SeatingLogHistory]
	--(
	--	id,UserId, FloorId, FloorMapId, IsBooked, UsageStartTime ,UsageEndTime,IsWFH, CreatedBy
	--)
	--Select @mSLHId,@vUserId,@vFloorId,@vFloorMapId,@vIsBook,GETDATE(),'',@vIsWFH,@vCurrUsrId

END
GO
/****** Object:  StoredProcedure [dbo].[spr_Floor_ReleaseSeat]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spr_Floor_ReleaseSeat]
	@vId			BIGINT,
	@vCurrUsrId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	IF EXISTS (Select 1
			   FROM [dbo].[SeatingLogToday] A
			   Where A.FloorMapId = @vId AND A.IsWFH = 1)
	BEGIN
		
		Update A
		SET A.IsWFH = 0,
			A.UpdatedBy = @vCurrUsrId,
			A.UpdatedOn = GETDATE(),
			A.[Status] = 'Complete',
			A.UsageEndTime = GETDATE()
		FROM [dbo].[SeatingLogToday] A
		WHere A.FloorMapId = @vId

		--Update A
		--SET A.IsWFH = 0,
		--	A.UpdatedBy = @vCurrUsrId,
		--	A.UpdatedOn = GETDATE(),
		--	A.[Status] = 'Complete',
		--	A.UsageEndTime = GETDATE()
		--FROM [dbo].[SeatingLogHistory] A
		--WHere A.FloorMapId = @vId
			

	END
	ELSE
	BEGIN

		Update A
		SET A.IsBooked = 0,
			A.UpdatedBy = @vCurrUsrId,
			A.UpdatedOn = GETDATE(),
			A.[Status] = 'Complete',
			A.UsageEndTime = GETDATE()
		FROM [dbo].[SeatingLogToday] A
		WHere A.FloorMapId = @vId

		--Update A
		--SET A.IsBooked = 0,
		--	A.UpdatedBy = @vCurrUsrId,
		--	A.UpdatedOn = GETDATE(),
		--	A.[Status] = 'Complete',
		--	A.UsageEndTime = GETDATE()
		--FROM [dbo].[SeatingLogHistory] A
		--WHere A.FloorMapId = @vId

	END

END
GO
/****** Object:  StoredProcedure [dbo].[spr_Floor_ShowAllWFHUserUnderHM]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [dbo].[spr_Floor_ShowAllWFHUserUnderHM] 20,4
-- =============================================
CREATE PROCEDURE [dbo].[spr_Floor_ShowAllWFHUserUnderHM]
	@vFloorId		BIGINT,
	@vCurrUsrId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select RowId = ROW_NUMBER() over(order by (A.FloorName)),*
	FROM
		(
			SELECT DISTINCT 
				   A.UserId,[Name] = A.LNKanji + '  ' + A.FNKanji + ' ('+ A.UserName +')',F.FloorName
			FROM [Masters].[tbl_Users] A
			INNER JOIN Masters.tbl_Floor F
				ON A.HomeMapFloorId = F.FloorId
			INNER JOIN [dbo].[SeatingLogToday] ST
				ON A.UserId = ST.UserId AND ST.IsWFH = 1 AND [Status] != 'Complete'
			Where F.FloorId = @vFloorId
		) A
	Order by A.FloorName

END
GO
/****** Object:  StoredProcedure [dbo].[spr_IsUserWFH]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spr_IsUserWFH]
	@vUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select UserId = A.UserId,IsWFH = CONVERT(VARCHAR,A.IsWFH)
	from [dbo].[SeatingLogToday] A
	WHere A.UserId = @vUserId AND A.IsWFH = 1 AND (DATEDIFF(Day,A.UsageStartTime,GETDATE()) = 0)
    
END
GO
/****** Object:  StoredProcedure [dbo].[spr_ResetSeatLogToday]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [dbo].[spr_ResetSeatLogToday]
-- =============================================
CREATE PROCEDURE [dbo].[spr_ResetSeatLogToday]
AS
BEGIN
	
	SET NOCOUNT ON;

	BEGIN TRY

		Declare @mTime varchar(150) = ''
		Declare @mCount INT = 10,@mData INT

		Select @mTime = CONVERT(VARCHAR(MAX),GETDATE (),108)

		--IF(@mTime = '00:00:00') -- Comment this line, if need to execute manually
		BEGIN

			BEGIN TRAN
				
				Update A
				SET A.UsageEndTime = GETDATE(),
					A.[Status] = 'Complete'
				FROM [dbo].[SeatingLogToday] A
				Where A.[Status] != 'Complete'

				INSERT INTO [dbo].[SeatingLogHistory]
				(
					UserId, FloorId, FloorMapId, IsBooked, UsageStartTime, UsageEndTime, 
					IsWFH, [Status], CreatedBy, UpdatedBy, UpdatedOn
				)
				Select UserId, FloorId, FloorMapId, IsBooked, UsageStartTime, UsageEndTime, 
					   IsWFH, [Status], CreatedBy, UpdatedBy, UpdatedOn
				FROM [dbo].[SeatingLogToday]

				IF(@@TRANCOUNT > 0)
				BEGIN
					Truncate Table [dbo].[SeatingLogToday]
				END

			COMMIT TRAN

		END
	END TRY
	BEGIN CATCH
		
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000),@ErrorSeverity INT,@ErrorState INT;

		SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY(),@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[tbl_ResetSPLogError]
		(
			ErrorMessage, ErrorSeverity, ErrorState, CreatedOn
		)
		Select @ErrorMessage,@ErrorSeverity,@ErrorState,GETDATE()
		
	END CATCH
		
END
GO
/****** Object:  StoredProcedure [dbo].[spr_ResetSPLog]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spr_ResetSPLog]
	@vId		BIGINT,
	@vIsType	VARCHAR(1)
AS
BEGIN

	SET NOCOUNT ON;

	IF(@vIsType = 'N')
	BEGIN
	
		INSERT INTO [dbo].[tbl_ResetSPLog]
		(
			StartDateTime
		)
		Select GETDATE()


		Select Id = SCOPE_IDENTITY()

	END
	ELSE
	BEGIN
		
		Update A
		SET A.ComplDateTime = GETDATE()
		FROM [dbo].[tbl_ResetSPLog] A
		Where A.Id = @vId

		Select Id = @vId

	END

END
GO
/****** Object:  StoredProcedure [dbo].[spr_Seat_Search]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [dbo].[spr_Seat_Search] '','','4','',13
-- =============================================
CREATE PROCEDURE [dbo].[spr_Seat_Search]
	@vLastName		nvarchar(max),
	@vFirstName		nvarchar(max),
	@vFloorId		VARCHAR(MAX),
	@vDeptId		VARCHAR(MAX),
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @Qry NVARCHAR(MAX) = '',@mWhereCond NVARCHAR(MAX) = ''

	Declare @mTable Table
	(
		BookType		 VARCHAR(MAX),
		UserId			 BIGINT,
		[Name]			 NVARCHAR(500),
		FloorId			 BIGINT,
		FloorName		 NVARCHAR(500),
		SeatId			 BIGINT,
		SeatDetails		 NVARCHAR(500),
		FloorMapId		 BIGINT
	)

	IF(@vFloorId IS NOT NULL AND @vFloorId != '')
	BEGIN
		
		Select RowId = ROW_NUMBER() over(Order by (Select 1)),*
		from (

			SELECT DISTINCT OrderKey = 1, [BookType] = '登録済み',U.UserId, [Name] = U.LNKanji + ' ' + U.FNKanji,F.FloorId,
				   FloorName = ISNULL(F.FloorName,''),SeatId = ISNULL(FM.SeatId,''),SeatDetails = ISNULL(FM.SeatDetails,''),
				   FloorMapId = FM.Id
			FROM Masters.tbl_Users U
			INNER JOIN SeatingLogToday L
				ON U.UserId = L.UserId
			INNER JOIN Masters.tbl_FloorMap FM
				ON FM.Id = L.FloorMapID
			INNER JOIN Masters.tbl_Floor F
				ON F.FloorId = FM.FloorId
			WHERE FM.FloorId = @vFloorId AND U.UserID = L.UserID AND L.[Status] <> 'Complete' AND L.FloorMapID = FM.Id 
				  AND L.IsBooked = 1
			UNION ALL
			SELECT DISTINCT OrderKey = 1, [BookType] = '在宅勤務',U.UserId, 
							[Name] = U.LNKanji + ' ' + U.FNKanji,FloorId = NULL,
							FloorName = '',SeatId = NULL,SeatDetails = '',
							FloorMapId = NULL
			FROM Masters.tbl_Users U
			INNER JOIN SeatingLogToday L
				ON U.UserId = L.UserId
			INNER JOIN Masters.tbl_Floor F
				ON F.FloorId = U.HomeMapFloorId
			WHERE F.FloorId = @vFloorId AND U.UserID = L.UserID AND L.[Status] <> 'Complete' AND L.IsWFH = 1
			UNION ALL
			SELECT DISTINCT OrderKey = 2, [BookType] = '未登録',U.UserId,
							[Name] = U.LNKanji + ' ' + U.FNKanji,FloorId = NULL,
							FloorName = NULL,SeatId = NULL,SeatDetails = NULL,
							FloorMapId = NULL
			From Masters.tbl_Users U
			INNER JOIN [Masters].[tbl_UserAccess_Users] USA
				ON USA.UserId = U.UserId
			INNER JOIN [Masters].[tbl_UserAccess] US
				ON USA.UserAccessId = US.USerAccessId
			WHERE U.UserID NOT IN (
									Select U.UserId
									FROM Masters.tbl_Users U
									INNER JOIN SeatingLogToday L
										ON U.UserId = L.UserId
									INNER JOIN Masters.tbl_FloorMap FM
										ON FM.Id = L.FloorMapID
									INNER JOIN Masters.tbl_Floor F
										ON F.FloorId = FM.FloorId
									WHERE FM.FloorId = @vFloorId AND U.UserID = L.UserID AND L.[Status] <> 'Complete' AND L.FloorMapID = FM.Id 
										  AND L.IsBooked = 1
									UNION ALL
									Select U.UserId
									FROM Masters.tbl_Users U
									INNER JOIN SeatingLogToday L
										ON U.UserId = L.UserId
									INNER JOIN Masters.tbl_Floor F
										ON F.FloorId = U.HomeMapFloorId
									WHERE F.FloorId = @vFloorId AND U.UserID = L.UserID AND L.[Status] <> 'Complete' AND L.IsWFH = 1

								  )
				 AND US.FloorId = @vFloorId
			) A

	END
	ELSE IF(@vDeptId IS NOT NULL AND @vDeptId != '')
	BEGIN
		
		Select RowId = ROW_NUMBER() over(Order by (Select 1)),*
		from (
				SELECT DISTINCT OrderKey = 1, [BookType] = '登録済み',U.UserId, [Name] = U.LNKanji + ' ' + U.FNKanji,F.FloorId,
					   FloorName = ISNULL(F.FloorName,''),SeatId = ISNULL(FM.SeatId,''),SeatDetails = ISNULL(FM.SeatDetails,''),
					   FloorMapId = FM.Id
				FROM Masters.tbl_Users U
				INNER JOIN SeatingLogToday L
					ON U.UserId = L.UserId AND L.IsBooked = 1
				INNER JOIN Masters.tbl_FloorMap FM
					ON FM.Id = L.FloorMapID
				INNER JOIN Masters.tbl_Floor F
					ON F.FloorId = FM.FloorId
				WHERE U.DeptId  = @vDeptId AND U.UserID = L.UserID AND L.[Status] <> 'Complete' AND L.FloorMapID = FM.Id
				UNION ALL
				SELECT DISTINCT OrderKey = 2, [BookType] = '在宅勤務',U.UserId,
								[Name] = U.LNKanji + ' ' + U.FNKanji,FloorId = NULL,
								FloorName = NULL,SeatId = NULL,SeatDetails = NULL,
								FloorMapId = NULL
				FROM Masters.tbl_Users U
				INNER JOIN SeatingLogToday L
					ON U.UserId = L.UserId AND L.IsWFH = 1
				WHERE U.DeptId  = @vDeptId AND U.UserID = L.UserID AND L.[Status] <> 'Complete'
				UNION ALL
				SELECT DISTINCT OrderKey = 3, [BookType] = '未登録',U.UserId, [Name] = U.LNKanji + ' ' + U.FNKanji,FloorId = NULL,
					   FloorName = '',SeatId = NULL,SeatDetails = '',
					   FloorMapId = NULL
				From Masters.tbl_Users U
				WHERE U.UserID NOT IN (
										Select Distinct U.UserId
										FROM Masters.tbl_Users U
										INNER JOIN SeatingLogToday L
											ON U.UserId = L.UserId AND L.IsBooked = 1
										INNER JOIN Masters.tbl_FloorMap FM
											ON FM.Id = L.FloorMapID
										WHERE U.DeptId  = @vDeptId AND U.UserID = L.UserID 
										     AND L.[Status] <> 'Complete' AND L.FloorMapID = FM.Id
										UNION ALL
										SELECT Distinct U.UserId
										FROM Masters.tbl_Users U
										INNER JOIN SeatingLogToday L
											ON U.UserId = L.UserId AND L.IsWFH = 1
										WHERE U.DeptId  = @vDeptId AND U.UserID = L.UserID AND L.[Status] <> 'Complete'

									  )
					AND U.DeptId  = @vDeptId
		) A

	END
	ELSE
	BEGIN

		Select RowId = ROW_NUMBER() over(Order by (Select 1)),*
		from (

			SELECT DISTINCT OrderKey = 1, [BookType] = '登録済み',U.UserId, [Name] = U.LNKanji + ' ' + U.FNKanji,F.FloorId,
				   FloorName = ISNULL(F.FloorName,''),SeatId = ISNULL(FM.SeatId,''),SeatDetails = ISNULL(FM.SeatDetails,''),
				   FloorMapId = FM.Id
			FROM Masters.tbl_Users U
			INNER JOIN SeatingLogToday L
				ON U.UserId = L.UserId AND L.IsBooked = 1
			INNER JOIN Masters.tbl_FloorMap FM
				ON FM.Id = L.FloorMapID
			INNER JOIN Masters.tbl_Floor F
				ON F.FloorId = FM.FloorId
			WHERE (U.FNKanji Like '%'+ @vFirstName + '%' OR U.LNKanji Like '%'+ @vLastName + '%') 
					AND U.UserID = L.UserID AND L.[Status] <> 'Complete' AND L.FloorMapID = FM.Id
			UNION ALL
			SELECT DISTINCT OrderKey = 2, [BookType] = '在宅勤務',U.UserId, [Name] = U.LNKanji + ' ' + U.FNKanji,
							FloorId = NULL,FloorName = '',SeatId = NULL,SeatDetails = NULL,FloorMapId = NULL
			FROM Masters.tbl_Users U
			INNER JOIN SeatingLogToday L
				ON U.UserId = L.UserId AND L.IsWFH = 1
			WHERE (U.FNKanji Like '%'+ @vFirstName + '%' OR U.LNKanji Like '%'+ @vLastName + '%') 
					AND U.UserID = L.UserID AND L.[Status] <> 'Complete'
			UNION
			SELECT DISTINCT OrderKey = 3, [BookType] = '未登録',U.UserId, [Name] = U.LNKanji + ' ' + U.FNKanji,FloorId = NULL,
				   FloorName = '',SeatId = NULL,SeatDetails = '',
				   FloorMapId = NULL
			From Masters.tbl_Users U
			WHERE U.UserID NOT IN (
									SELECT U.UserId
									FROM Masters.tbl_Users U
									INNER JOIN SeatingLogToday L
										ON U.UserId = L.UserId AND L.IsBooked = 1
									INNER JOIN Masters.tbl_FloorMap FM
										ON FM.Id = L.FloorMapID
									WHERE (U.FNKanji Like '%'+ @vFirstName + '%' OR U.LNKanji Like '%'+ @vLastName + '%') 
										  AND U.UserID = L.UserID AND L.[Status] <> 'Complete' AND L.FloorMapID = FM.Id
									UNION ALL
									SELECT U.UserId
									FROM Masters.tbl_Users U
									INNER JOIN SeatingLogToday L
										ON U.UserId = L.UserId AND L.IsWFH = 1
									WHERE (U.FNKanji Like '%'+ @vFirstName + '%' OR U.LNKanji Like '%'+ @vLastName + '%') 
											AND U.UserID = L.UserID AND L.[Status] <> 'Complete'
								  )
				AND (U.FNKanji Like '%'+ @vFirstName + '%' OR U.LNKanji Like '%'+ @vLastName + '%')
			) A

	END

	
END
GO
/****** Object:  StoredProcedure [dbo].[spr_Seat_Search_BKp]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [dbo].[spr_Seat_Search] '','Abhish12','','',13
-- =============================================
CREATE PROCEDURE [dbo].[spr_Seat_Search_BKp]
	@vLastName		nvarchar(max),
	@vFirstName		nvarchar(max),
	@vFloorId		VARCHAR(MAX),
	@vDeptId		VARCHAR(MAX),
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @Qry NVARCHAR(MAX) = '',@mWhereCond NVARCHAR(MAX) = ''

	Declare @mTable Table
	(
		BookType		 VARCHAR(MAX),
		UserId			 BIGINT,
		[Name]			 NVARCHAR(500),
		FloorId			 BIGINT,
		FloorName		 NVARCHAR(500),
		SeatId			 BIGINT,
		SeatDetails		 NVARCHAR(500),
		FloorMapId		 BIGINT
	)

	IF(@vFloorId IS NOT NULL AND @vFloorId != '')
	BEGIN
		
		SET @Qry = 'Select [BookType] = ''在宅勤務'',UserId = Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
						   FloorId = US.FloorId,FloorName = '''',SeatId = NULL,SeatDetails = '''',
						   FloorMapId = NULL
					from [Masters].[tbl_UserAccess_Users] USA
					INNER JOIN [Masters].[tbl_UserAccess] US
						ON USA.UserAccessId = US.USerAccessId
					INNER JOIN Masters.tbl_Users Usr
			    		ON USA.UserId = Usr.UserId
					Where US.FloorId IN ('+ @vFloorId +')'
	END
	ELSE IF(@vDeptId IS NOT NULL AND @vDeptId != '')
	BEGIN
		
		SET @Qry = 'Select [BookType] = ''在宅勤務'',UserId = Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
						   FloorId = US.FloorId,FloorName = '''',SeatId = NULL,SeatDetails = '''',
						   FloorMapId = NULL
					from [Masters].[tbl_Users] Usr 
					INNER JOIN [Masters].[tbl_UserAccess_Users] USA
						ON USA.UserId = Usr.UserId
					INNER JOIN [Masters].[tbl_UserAccess] US
						ON USA.UserAccessId = US.USerAccessId
					Where Usr.DeptId = ' + CONVERT(VARCHAR,@vDeptId)
	END
	ELSE
	BEGIN

		SET @Qry = ' Select [BookType] = ''在宅勤務'',UserId = Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
							FloorId = US.FloorId,FloorName = '''',SeatId = NULL,SeatDetails = '''',
							FloorMapId = NULL
					from Masters.tbl_Users Usr
					INNER JOIN [Masters].[tbl_UserAccess_Users] USA
						ON USA.UserId = Usr.UserId
					INNER JOIN [Masters].[tbl_UserAccess] US
						ON USA.UserAccessId = US.USerAccessId
					Where Usr.IsActive = 1
					'

		IF(@vLastName != '')
		BEGIN
			SET @mWhereCond += ' AND Usr.LNKanji Like ''%' + @vLastName + '%''' 
		END

		IF(@vFirstName != '')
		BEGIN
			SET @mWhereCond += ' AND Usr.FNKanji Like ''%' + @vFirstName + '%''' 
		END

		SET @Qry = @Qry + @mWhereCond

	END

	IF((@vFloorId IS NOT NULL AND @vFloorId != '') OR (@vDeptId IS NOT NULL AND @vDeptId != '')
		OR (@mWhereCond != NULL OR @mWhereCond != ''))
	BEGIN
		
		INSERT INTO @mTable
		EXEC(@Qry)


		Select RowId = ROW_NUMBER() over(Order by (Select 1)),*
		from (
				SELECT  DISTINCT 
						OrderKey = CASE 
										 WHEN (A.Id IS NOT NULL AND A.IsBooked = 1) THEN '1' 
										 WHEN (A.Id IS NOT NULL AND A.IsWFH = 1)  THEN '2' 
										 ELSE '3' 
									END,
						[BookType] = CASE 
										 WHEN (A.Id IS NOT NULL AND A.IsBooked = 1) THEN '登録済み' 
										 WHEN (A.Id IS NOT NULL AND A.IsWFH = 1)  THEN '在宅勤務' 
										 ELSE '未登録' 
									END,
						Usr.UserId,[Name] = Usr.[Name],
						FloorId = Usr.FloorId,FloorName = ISNULL(FLR.FloorName,''),
						SeatId = ISNULL(FM.SeatId,''),SeatDetails = ISNULL(FM.SeatDetails,''),
						FloorMapId = FM.Id
				FROM @mTable Usr
				LEFT OUTER JOIN [dbo].[SeatingLogToday] A
					ON A.UserId = Usr.UserId AND A.UsageEndTime = '' AND A.[Status] = '' AND (A.IsBooked = 1 OR A.IsWFH = 1)
					   AND A.FloorId = Usr.FloorId
				LEFT OUTER JOIN [Masters].[tbl_FloorMap] FM
					ON A.FloorMapId = FM.Id AND FM.FloorId = A.FloorId
				LEFT OUTER JOIN Masters.tbl_Floor FLR
					ON FLR.FloorId = Usr.FloorId AND FLR.IsActive = 1
			) A
		Order by A.OrderKey,[Name]

	END

END
GO
/****** Object:  StoredProcedure [dbo].[spr_Seat_Search_BKp0705]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [dbo].[spr_Seat_Search] '','','','1',13
-- =============================================
CREATE PROCEDURE [dbo].[spr_Seat_Search_BKp0705]
	@vLastName		nvarchar(max),
	@vFirstName		nvarchar(max),
	@vFloorId		VARCHAR(MAX),
	@vDeptId		VARCHAR(MAX),
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @Qry NVARCHAR(MAX) = '',@mWhereCond NVARCHAR(MAX) = ''

	Declare @mTable Table
	(
		BookType		 VARCHAR(MAX),
		UserId			 BIGINT,
		[Name]			 NVARCHAR(500),
		FloorId			 BIGINT,
		FloorName		 NVARCHAR(500),
		SeatId			 BIGINT,
		SeatDetails		 NVARCHAR(500),
		FloorMapId		 BIGINT
	)

	IF(@vFloorId IS NOT NULL AND @vFloorId != '')
	BEGIN
		
		SET @Qry = 'Select [BookType] = ''在宅勤務'',UserId = Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
						   FloorId = US.FloorId,FloorName = '''',SeatId = NULL,SeatDetails = '''',
						   FloorMapId = NULL
					from [Masters].[tbl_UserAccess_Users] USA
					INNER JOIN [Masters].[tbl_UserAccess] US
						ON USA.UserAccessId = US.USerAccessId
					INNER JOIN Masters.tbl_Users Usr
			    		ON USA.UserId = Usr.UserId
					Where US.FloorId IN ('+ @vFloorId +')'
	END
	ELSE IF(@vDeptId IS NOT NULL AND @vDeptId != '')
	BEGIN
		
		SET @Qry = 'Select [BookType] = ''在宅勤務'',UserId = Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
						   FloorId = US.FloorId,FloorName = '''',SeatId = NULL,SeatDetails = '''',
						   FloorMapId = NULL
					from Masters.tbl_Users Usr
			    		ON USA.UserId = Usr.UserId
					Where Usr.DeptId = ' + CONVERT(VARCHAR,@vDeptId)
	END
	ELSE
	BEGIN

		SET @Qry = ' Select [BookType] = ''在宅勤務'',UserId = Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
							FloorId = US.FloorId,FloorName = '''',SeatId = NULL,SeatDetails = '''',
							FloorMapId = NULL
					from Masters.tbl_Users Usr
					INNER JOIN [Masters].[tbl_UserAccess_Users] USA
						ON USA.UserId = Usr.UserId
					INNER JOIN [Masters].[tbl_UserAccess] US
						ON USA.UserAccessId = US.USerAccessId
					Where Usr.IsActive = 1
					'

		IF(@vLastName != '')
		BEGIN
			SET @mWhereCond += ' AND Usr.LNKanji Like ''%' + @vLastName + '%''' 
		END

		IF(@vFirstName != '')
		BEGIN
			SET @mWhereCond += ' AND Usr.FNKanji Like ''%' + @vFirstName + '%''' 
		END

		SET @Qry = @Qry + @mWhereCond

	END

	IF((@vFloorId IS NOT NULL AND @vFloorId != '') OR (@vDeptId IS NOT NULL AND @vDeptId != '')
		OR (@mWhereCond != NULL OR @mWhereCond != ''))
	BEGIN
		
		INSERT INTO @mTable
		EXEC(@Qry)

		Select RowId = ROW_NUMBER() over(Order by (Select 1)),*
		from (
				 SELECT  DISTINCT 
						OrderKey = 1,
						[BookType] = '登録済み',
						Usr.UserId,[Name] = Usr.[Name],
						FloorId = Usr.FloorId,FloorName = ISNULL(FLR.FloorName,''),
						SeatId = ISNULL(FM.SeatId,''),SeatDetails = ISNULL(FM.SeatDetails,''),
						FloorMapId = FM.Id
				FROM @mTable Usr
				INNER JOIN [dbo].[SeatingLogToday] A
					ON A.UserId = Usr.UserId AND A.UsageEndTime = '' AND A.[Status] = '' AND A.IsBooked = 1
					   AND A.FloorId = Usr.FloorId
				INNER JOIN [Masters].[tbl_FloorMap] FM
					ON A.FloorMapId = FM.Id AND FM.FloorId = A.FloorId
				INNER JOIN Masters.tbl_Floor FLR
					ON FLR.FloorId = Usr.FloorId AND FLR.IsActive = 1
				UNION ALL
				SELECT  DISTINCT 
						OrderKey = 2,
						[BookType] = '在宅勤務',
						Usr.UserId,[Name] = Usr.[Name],
						FloorId = NULL,FloorName = '',
						SeatId = NULL,SeatDetails = '',
						FloorMapId = NULL
				FROM @mTable Usr
				INNER JOIN [dbo].[SeatingLogToday] A
					ON A.UserId = Usr.UserId AND A.UsageEndTime = '' AND A.[Status] = '' AND A.IsWFH = 1
				UNION ALL
				SELECT  DISTINCT 
						OrderKey = 3,
						[BookType] = '未登録',
						Usr.UserId,[Name] = Usr.[Name],
						FloorId = NULL,FloorName = '',
						SeatId = NULL,SeatDetails = '',
						FloorMapId = NULL
				FROM @mTable Usr
				Where Usr.UserId NOT IN (
											Select Usr.UserId
											FROM @mTable Usr
											INNER JOIN [dbo].[SeatingLogToday] A
												ON A.UserId = Usr.UserId AND A.UsageEndTime = '' AND A.[Status] = '' AND A.IsBooked = 1
													AND A.FloorId = Usr.FloorId
											INNER JOIN [Masters].[tbl_FloorMap] FM
												ON A.FloorMapId = FM.Id AND FM.FloorId = A.FloorId
											INNER JOIN Masters.tbl_Floor FLR
												ON FLR.FloorId = Usr.FloorId AND FLR.IsActive = 1
											UNION ALL
											Select Usr.UserId
											FROM @mTable Usr
											INNER JOIN [dbo].[SeatingLogToday] A
												ON A.UserId = Usr.UserId AND A.UsageEndTime = '' 
												AND A.[Status] = '' AND A.IsWFH = 1

				)
				
			) A
		Order by A.OrderKey,[Name]

	END

END
GO
/****** Object:  StoredProcedure [dbo].[spr_Seat_SearchBkp]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [dbo].[spr_Seat_Search] '','A',NULL,1
-- =============================================
CREATE PROCEDURE [dbo].[spr_Seat_SearchBkp]
	@vLastName		nvarchar(max),
	@vFirstName		nvarchar(max),
	@vFloorId		VARCHAR(MAX),
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @Qry NVARCHAR(MAX) = '',@mWhereCond NVARCHAR(MAX) = ''

	Declare @mTable Table
	(
		RowId			 BIGINT,
		UserId			 BIGINT,
		[Name]			 NVARCHAR(500),
		FloorId			 BIGINT,
		FloorName		 NVARCHAR(500),
		SeatId			 BIGINT,
		SeatDetails		 NVARCHAR(500),
		CurrentX		 INT,
		CurrentY		 INT,
		[StartTime]		 VARCHAR(50),
		[EndTime]		 VARCHAR(50),
		[UsageStartTime] Datetime,
		Width			 INT,
		Height			 INT,
		FloorMapId		 BIGINT,
		IsWFH			 VARCHAR(50)
	)

	IF(@vFloorId IS NOT NULL AND @vFloorId != '')
	BEGIN
		
		SET @Qry = 'Select RowId = ROW_NUMBER() over(order by A.UsageStartTime),
						  Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
						  A.FloorId,
						  FloorName = CASE WHEN A.IsWFH = 1 THEN ''在宅勤務'' ELSE FLR.FloorName END,FM.SeatId,FM.SeatDetails,
						  CurrentX = CONVERT(VARCHAR,CurrentX),
						  CurrentY = CONVERT(VARCHAR,CurrentY),
						  [StartTime] = dbo.GetFormattedDate(A.UsageStartTime),
						  [EndTime] = dbo.GetFormattedDate(A.UsageEndTime),
						  A.UsageStartTime,FM.Width,FM.Height,
						  A.FloorMapId,
						  IsWFH = CASE WHEN A.IsWFH = 1 THEN ''Yes'' ELSE ''No'' END
					from [dbo].[SeatingLogToday] A
					INNER JOIN Masters.tbl_Users Usr	
			    		On A.UserId = Usr.UserId
					LEFT OUTER JOIN [Masters].[tbl_FloorMap] FM
			    		ON A.FloorMapId = FM.Id AND FM.FloorId = A.FloorId
					LEFT OUTER JOIN Masters.tbl_Floor FLR
			    		ON FLR.FloorId = A.FloorId
					Where A.UsageEndTime = '''' AND A.FloorId IN ('+ @vFloorId +')'

	END
	ELSE
	BEGIN

		SET @Qry = ' Select RowId = ROW_NUMBER() over(order by A.UsageStartTime),
						    Usr.UserId,[Name] = Usr.LNKanji + '' '' + Usr.FNKanji,
						    A.FloorId,
						    FloorName = CASE WHEN A.IsWFH = 1 THEN ''在宅勤務'' ELSE FLR.FloorName END,FM.SeatId,FM.SeatDetails,
						    CurrentX = CONVERT(VARCHAR,CurrentX),
						    CurrentY = CONVERT(VARCHAR,CurrentY),
						    [StartTime] = dbo.GetFormattedDate(A.UsageStartTime),
						    [EndTime] = dbo.GetFormattedDate(A.UsageEndTime),
						    A.UsageStartTime,FM.Width,FM.Height,
						    A.FloorMapId,
						    IsWFH = CASE WHEN A.IsWFH = 1 THEN ''Yes'' ELSE ''No'' END
					from Masters.tbl_Users Usr
					LEFT OUTER JOIN [dbo].[SeatingLogToday] A
			    		On A.UserId = Usr.UserId
					LEFT OUTER JOIN [Masters].[tbl_FloorMap] FM
			    		ON A.FloorMapId = FM.Id AND FM.FloorId = A.FloorId
					LEFT OUTER JOIN Masters.tbl_Floor FLR
			    		ON FLR.FloorId = A.FloorId
					Where A.UsageEndTime = '''''
	END

	IF(@vLastName != '')
	BEGIN
		SET @mWhereCond += ' AND Usr.LNKanji Like ''%' + @vLastName + '%''' 
	END

	IF(@vFirstName != '')
	BEGIN
		SET @mWhereCond += ' AND Usr.FNKanji Like ''%' + @vFirstName + '%''' 
	END

	SET @Qry = @Qry + @mWhereCond
	
	PRINT @Qry

	IF(@mWhereCond != '' OR @vFloorId != '')
	BEGIN

		INSERT INTO @mTable
		EXEC(@Qry)

		Select RowId,UserId,[Name],FloorId,FloorName,SeatId,SeatDetails,CurrentX,CurrentY,
			 [StartTime],[EndTime],[UsageStartTime],Width,Height,FloorMapId,IsWFH			 
		from @mTable
			
	END	  	
END
GO
/****** Object:  StoredProcedure [dbo].[spr_SeatBook_CheckOut]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spr_SeatBook_CheckOut]
	@vCurrUserId	INT
AS
BEGIN
	
	SET NOCOUNT ON;

	IF EXISTS (Select 1
			   FROM [dbo].[SeatingLogToday] A
			   Where A.UserId = @vCurrUserId AND A.UsageEndTime = '' AND A.IsWFH = 1)
	BEGIN
		
		Update A
		SET A.IsWFH = 0,
			A.UpdatedBy = @vCurrUserId,
			A.UpdatedOn = GETDATE(),
			A.[Status] = 'Complete',
			A.UsageEndTime = GETDATE()
		FROM [dbo].[SeatingLogToday] A
		WHere A.UserId = @vCurrUserId AND A.UsageEndTime = '' AND A.IsWFH = 1

		--Update A
		--SET A.IsWFH = 0,
		--	A.UpdatedBy = @vCurrUserId,
		--	A.UpdatedOn = GETDATE(),
		--	A.[Status] = 'Complete',
		--	A.UsageEndTime = GETDATE()
		--FROM [dbo].[SeatingLogHistory] A
		--WHere A.UserId = @vCurrUserId AND A.UsageEndTime = '' AND A.IsWFH = 1
			

	END
	ELSE
	BEGIN

		Update A
		SET A.IsBooked = 0,
			A.UpdatedBy = @vCurrUserId,
			A.UpdatedOn = GETDATE(),
			A.[Status] = 'Complete',
			A.UsageEndTime = GETDATE()
		FROM [dbo].[SeatingLogToday] A
		WHere A.UserId = @vCurrUserId AND A.UsageEndTime = '' AND A.IsBooked = 1

		--Update A
		--SET A.IsBooked = 0,
		--	A.UpdatedBy = @vCurrUserId,
		--	A.UpdatedOn = GETDATE(),
		--	A.[Status] = 'Complete',
		--	A.UsageEndTime = GETDATE()
		--FROM [dbo].[SeatingLogHistory] A
		--WHere A.UserId = @vCurrUserId AND A.UsageEndTime = '' AND A.IsBooked = 1

	END
    
END
GO
/****** Object:  StoredProcedure [dbo].[spr_SeatBook_CheckRights]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 5
-- =============================================
CREATE PROCEDURE [dbo].[spr_SeatBook_CheckRights]
	@vCurrUsrId		INT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mIsCheckout VARCHAR(1),@mIsWFH VARCHAR(1),@mIsWorking varchar(1)

	Select @mIsWFH = '1'
	from dbo.SeatingLogToday A
	Where A.UserId = @vCurrUsrId AND A.UsageStartTime != ''  AND A.UsageEndTime = '' AND A.IsWFH = 1

	Select @mIsWorking = '1'
	from dbo.SeatingLogToday A
	Where A.UserId = @vCurrUsrId AND A.UsageStartTime != '' AND A.UsageEndTime = '' AND (A.IsWFH IS NULL OR A.IsWFH = '0')

	Select @mIsCheckout = '1'
	from dbo.SeatingLogToday A
	Where A.UserId = @vCurrUsrId AND A.UsageStartTime != ''  AND A.UsageEndTime = ''

	Select IsWFH = ISNULL(@mIsWFH,'0'),IsCheckout = ISNULL(@mIsCheckout,'0'),IsWorking = ISNULL(@mIsWorking,'0')
    
END
GO
/****** Object:  StoredProcedure [dbo].[spr_User_Authenticate]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [dbo].[spr_User_Authenticate] 'Abhish','SSO'
-- =================================================
CREATE PROCEDURE [dbo].[spr_User_Authenticate]
	@vUsername	Nvarchar(500),
	@vPassword	Nvarchar(500)
AS
BEGIN

	--INSERT INTO ##Temp
	--Select @vUsername,@vPassword
	
	SET NOCOUNT ON;

	IF EXISTS(Select 1
			  from Masters.tbl_Users A
			    --Where A.Username = @vUsername AND (A.[Password] = @vPassword OR @vPassword = 'SSO') AND A.IsActive = 1)
			  Where A.Username = @vUsername AND A.IsActive = 1)
	BEGIN
		
		-- System Admin & Employee
		Select IsUserExists = 'Y',ReturnMsg = 'Success',
			   A.UserId,A.Username,[Name] = A.LNKanji + ' ' + A.FNKanji,
			   RoleCode = B.RoleCode,RoleName = B.Rolename,
			   ProfPic = ISNULL(ID.ImagePath,'')
		from Masters.tbl_Users A
		INNER JOIN [dbo].[tbl_Roles] B
			On A.RoleId = B.RoleId
		LEFT OUTER JOIN [Masters].[tbl_ControllerMap_FloorAdmin] CM
			ON CM.UserId = A.UserId AND CM.IsActive = 1
		LEFT OUTER JOIN [dbo].[tbl_ProfPicImageDtls] ID
			ON ID.PId = A.UserId
		----Where A.Username = @vUsername AND (A.[Password] = @vPassword OR @vPassword = 'SSO') AND CM.Id IS NULL
		----UNION ALL
		Where A.Username = @vUsername   AND CM.Id IS NULL
		UNION ALL
		-- Floor Admin
		Select DISTINCT IsUserExists = 'Y',ReturnMsg = 'Success',
			   A.UserId,A.Username,[Name] = A.LNKanji + ' ' + A.FNKanji,
			   RoleCode = B.RoleCode,RoleName = B.Rolename,
			   ProfPic = ISNULL(ID.ImagePath,'')
		from Masters.tbl_Users A
		INNER JOIN [dbo].[tbl_Roles] B
			On 1 = B.RoleId
		INNER JOIN [Masters].[tbl_ControllerMap_FloorAdmin] CM
			ON CM.UserId = A.UserId AND CM.IsActive = 1
		LEFT OUTER JOIN [dbo].[tbl_ProfPicImageDtls] ID
			ON ID.PId = A.UserId
			--Where A.Username = @vUsername AND (A.[Password] = @vPassword OR @vPassword = 'SSO')
		Where A.Username = @vUsername  

	END
	ELSE
	BEGIN
		
		Select IsUserExists = 'N',ReturnMsg = 'Username or Password is Invalid !!!'

	END
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_ControllerMap_GetById]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_ControllerMap_GetById] 11
-- =============================================
CREATE PROCEDURE [Masters].[spr_ControllerMap_GetById]
	@vControllerMapId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select ControllerId, ControllerName, ControllerDesc, [Status] = CONVERT(VARCHAR,[Status]), 
		   CreatedBy, CreatedOn, UpdatedBy, UpdatedOn
	from [Masters].[tbl_ControllerMap] A
	Where A.ControllerId = @vControllerMapId

	Select RowId = ROW_NUMBER() over(order by A.Id),
		   FloorId = A.UserId,A.RoleCode,FloorName = B.FNKanji + ' ' + B.LNKanji,
		   IsType = 'E'
	from [Masters].[tbl_ControllerMap_FloorAdmin] A
	INNER JOIN [Masters].[tbl_Users] B
		On B.UserId = A.UserId
	Where A.ControllerMapId = @vControllerMapId AND A.IsActive = 1
	Order by A.Id
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_ControllerMap_GetList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_ControllerMap_GetList] 0
-- =============================================
CREATE PROCEDURE [Masters].[spr_ControllerMap_GetList]
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT RowId = ROW_NUMBER() over(order by ControllerId desc),
		   ControllerId,ControllerName, ControllerDesc,
		   [Status] = CASE WHEN [Status] = 1 THEN 'Active' ELSE 'InActive' END,
		   CreatedBy, CreatedOn = [dbo].[GetFormattedDate](CreatedOn), UpdatedBy, UpdatedOn,
		   OrgCreatedOn = CreatedOn
	FROM Masters.tbl_ControllerMap
	ORDER BY OrgCreatedOn DESC

END
GO
/****** Object:  StoredProcedure [Masters].[spr_ControllerMap_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_ControllerMap_Save]
	@vControllerId		BIGINT,
	@vControllerName	NVARCHAR(255),
	@vControllerDesc	NVARCHAR(MAX),
	@vFloorListUT		[FloorListUT] READONLY,
	@vIsEdit			varchar(1),
	@vCurrUserId		varchar(MAX)
AS
BEGIN
	
	SET NOCOUNT ON;

    Declare @mControllerId BIGINT,@vPId	INT

	IF(@vIsEdit = 'N')
	BEGIN
		
		Select @mControllerId = ISNULL(MAX(ControllerId),0) + 1
		FROM [Masters].[tbl_ControllerMap]

		INSERT INTO [Masters].[tbl_ControllerMap]
		(
			ControllerId, ControllerName, ControllerDesc, [Status], CreatedBy, CreatedOn
		)
		VALUES
		(
			@mControllerId,@vControllerName,@vControllerDesc,1,ISNULL(@vCurrUserId,0),GETDATE()
		)

		SET @vPId = @mControllerId

	END
	ELSE
	BEGIN
		
		UPDATE A
		SET A.ControllerName  = @vControllerName,
			A.ControllerDesc  = @vControllerDesc,
			A.UpdatedBy = @vCurrUserId,
			A.UpdatedOn = GETDATE()
		FROM [Masters].[tbl_ControllerMap] A
		Where A.ControllerId = @vControllerId

		SET @vPId = @vControllerId

	END

	Declare @mId INT,@mLen varchar(10)

	Select @mId = ISNULL(MAX(Id),0)
	FROM [Masters].[tbl_ControllerMap_FloorAdmin]

	Select @mLen = LEN(@mId)

	INSERT INTO [Masters].[tbl_ControllerMap_FloorAdmin]
	(
		Id,ControllerMapId, UserId, RoleCode, RoleId, CreatedBy, CreatedOn
	)
	Select RowId = ROW_NUMBER() over(order by (select 1)) + @mId,@vPId,A.FloorId,
		   '', --'FA' + CASE WHEN @mLen <= 3 THEN RIGHT('000' + CONVERT(VARCHAR(MAX),ROW_NUMBER() over(order by (select 1)) + @mId),3) ELSE CONVERT(VARCHAR(MAX),@mId) END
		   1,
		   @vCurrUserId,GETDATE()
	from @vFloorListUT A
	LEFT OUTER JOIN [Masters].[tbl_ControllerMap_FloorAdmin] B
		ON A.FloorId = B.UserId AND B.ControllerMapId = @vPId
	Where A.IsType = 'N' AND B.Id IS NULL

	Update A
	SET A.IsActive = 0
	FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
	INNER JOIN @vFloorListUT B
		ON A.UserId = B.FloorId
	WHere B.IsType = 'D'

END
GO
/****** Object:  StoredProcedure [Masters].[spr_Floor_GetById]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_Floor_GetById] '29',7
-- =============================================
CREATE PROCEDURE [Masters].[spr_Floor_GetById]
	@vFloorId		BIGINT,
	@vCurrUsrId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mControllerName varchar(50) = '',@mControllerId BIGINT,
			@mRoleCode varchar(max),@mCurrUsrId	BIGINT

	Select @mRoleCode = R.RoleCode
	from [Masters].[tbl_Users] A
	INNER JOIN [dbo].[tbl_Roles] R
		On A.RoleId = R.RoleId
	Where UserId = @vCurrUsrId

	IF (@mRoleCode = 'SystemAdm')
	BEGIN	

		Select @mCurrUsrId = F.CreatedBy
		from Masters.tbl_Floor F
		Where F.FloorId = @vFloorId

		PRINT @mCurrUsrId
		
		Select @mControllerName = ISNULL(CM.ControllerName,''),@mControllerId = A.ControllerMapId
		FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
		INNER JOIN [Masters].[tbl_ControllerMap] CM
			ON CM.ControllerId = A.ControllerMapId
		Where A.UserId = @mCurrUsrId

	END
	ELSE
	BEGIN

		Select @mControllerName = ISNULL(CM.ControllerName,''),@mControllerId = A.ControllerMapId
		FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
		INNER JOIN [Masters].[tbl_ControllerMap] CM
			ON CM.ControllerId = A.ControllerMapId
		Where A.UserId = @vCurrUsrId
		
	END

	Select ControllerId = @mControllerId,ControllerName = @mControllerName,
		   A.FloorId,A.FloorName,FloorCode = ISNULL(A.FloorCode,''),A.FloorSrNO,
		   A.FloorDesc,A.RevNo,A.CreatedBy,
		   B.ImageName,B.ImageDesc,B.ImagePath,B.ImgId,B.CreatedBy,
		   UsernameFontsize = ISNULL(A.UsernameFontsize,'11'),
		   IsActive = CONVERT(VARCHAR,A.IsActive)
	from [Masters].[tbl_Floor] A
	INNER JOIN [dbo].[tbl_ImageDtls] B
		On A.FloorId = B.PId
	Where A.FloorId = @vFloorId
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_Floor_GetList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_Floor_GetList] 7
-- =============================================
CREATE PROCEDURE [Masters].[spr_Floor_GetList]
	@vCurrUserId	BIGINT,
	@vIsActive		VARCHAR(1)
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mControllerId BIGINT,@mRoleCode varchar(max)

	Select @mRoleCode = R.RoleCode
	from [Masters].[tbl_Users] A
	INNER JOIN [dbo].[tbl_Roles] R
		On A.RoleId = R.RoleId
	Where UserId = @vCurrUserId
	
	PRINT @mRoleCode

	IF (@mRoleCode = 'SystemAdm')
	BEGIN
		
		IF(@vIsActive = 1)
		BEGIN

			SELECT RowId = ROW_NUMBER() over(order by CONVERT(INT,FloorSrNO) DESC,RevNo desc),
					FloorId,FloorMapId = 0,FloorCode,FloorName, FloorDesc, FloorImageId, RevNo,
					CreatedBy, CreatedOn = [dbo].[GetFormattedDate](CreatedOn), UpdatedBy, UpdatedOn
			FROM [Masters].[tbl_Floor] A
			WHere A.IsActive = 1
			ORDER BY CONVERT(INT,FloorSrNO) DESC,RevNo DESC

		END
		ELSE
		BEGIN

			SELECT RowId = ROW_NUMBER() over(order by CONVERT(INT,FloorSrNO) DESC,RevNo desc),
					   FloorId,FloorMapId = 0,FloorCode,FloorName, FloorDesc, FloorImageId, RevNo,
					   CreatedBy, CreatedOn = [dbo].[GetFormattedDate](CreatedOn), UpdatedBy, UpdatedOn
			FROM [Masters].[tbl_Floor] A
			WHere A.IsActive = 0
			ORDER BY CONVERT(INT,FloorSrNO) DESC,RevNo DESC

		END

	END
	ELSE
	BEGIN
		
		Select @mControllerId = ControllerMapId
		FROM [Masters].[tbl_ControllerMap_FloorAdmin]
		Where UserId = @vCurrUserId

		Select UserId
		INTO #Temp
		FROM [Masters].[tbl_ControllerMap_FloorAdmin] 
		Where ControllerMapId = @mControllerId AND [IsActive] = 1

		IF(@vIsActive = 1)
		BEGIN

			SELECT RowId = ROW_NUMBER() over(order by CONVERT(INT,FloorSrNO) DESC,RevNo desc),
				   FloorId,FloorMapId = 0,FloorCode,FloorName, FloorDesc, FloorImageId, RevNo,
				   CreatedBy, CreatedOn = [dbo].[GetFormattedDate](CreatedOn), UpdatedBy, UpdatedOn
			FROM [Masters].[tbl_Floor] A
			WHere A.IsActive = 1 AND  A.CreatedBy IN (Select UserId
								 FROM #Temp)
			ORDER BY CONVERT(INT,FloorSrNO) DESC,RevNo DESC

		END
		ELSE
		BEGIN
			
			SELECT RowId = ROW_NUMBER() over(order by CONVERT(INT,FloorSrNO) DESC,RevNo desc),
				   FloorId,FloorMapId = 0,FloorCode,FloorName, FloorDesc, FloorImageId, RevNo,
				   CreatedBy, CreatedOn = [dbo].[GetFormattedDate](CreatedOn), UpdatedBy, UpdatedOn
			FROM [Masters].[tbl_Floor] A
			WHere A.IsActive = 0 AND  A.CreatedBy IN (Select UserId
								 FROM #Temp)
			ORDER BY CONVERT(INT,FloorSrNO) DESC,RevNo DESC

		END

		Drop Table #Temp
		
	END

END
GO
/****** Object:  StoredProcedure [Masters].[spr_Floor_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_Floor_Save]
	@vFloorId			BIGINT,
	--@vControllerId		BIGINT,
	@vFloorCode			NVARCHAR(MAX),
	@vFloorSrNO			NVARCHAR(MAX),
	@vFloorName			NVARCHAR(255),
	@vFloorDesc			NVARCHAR(MAX),
	@vFloorImageId		BIGINT,
	@vRevNo				BIGINT,
	@vUsernameFontsize	INT,
	@vIsEdit			VARCHAR(1),
	@vCurrUsrId			BIGINT,
	@vIsActive			VARCHAR(1)
AS
BEGIN
	
	SET NOCOUNT ON;

	IF(@vIsEdit = 'N')
	BEGIN
		
		Declare  @mFloorId		 BIGINT,@mFloorCode	varchar(max),@mLen INT,@mFloorSrNO VARCHAR(MAX),
				 @mControllerId	 BIGINT

		Select @mFloorId = ISNULL(MAX(FloorId),0) + 1
		FROM [Masters].[tbl_Floor]

		Select @mLen = LEN(@mFloorId)

		IF(@vFloorId IS NULL)
		BEGIN
			
			Select @mFloorSrNO = CASE 
									WHEN @mLen <= 3 THEN RIGHT('000' + CONVERT(VARCHAR(MAX),ISNULL(MAX(CONVERT(INT,FloorSrno)) + 1,1)),3) 
									ELSE CONVERT(VARCHAR(MAX),ISNULL(MAX(CONVERT(INT,FloorSrno)) + 1,1))
							  END
			FROM [Masters].[tbl_Floor]

			SET @mFloorCode = 'FL' + CONVERT(VARCHAR(MAX),@mFloorSrNO)

		END
		ELSE
		BEGIN

			SET @mFloorCode = @vFloorCode
			SET @mFloorSrNO = @vFloorSrNO

		END

		Select @vRevNo = ISNULL(MAX(RevNo) + 1,0)
		FROM [Masters].[tbl_Floor]
		WHere FloorCode = @vFloorCode

		Update A
		SET A.IsActive = 0
		FROM [Masters].[tbl_Floor] A
		WHere A.FloorCode = @vFloorCode

		--IF(@vControllerId IS NOT NULL AND @vControllerId != 0)
		--BEGIN
		--	Select @mControllerId = @vControllerId
		--END
		--ELSE
		--BEGIN

		--	Select @mControllerId = ISNULL(ControllerMapId,0)
		--	FROM [Masters].[tbl_ControllerMap_FloorAdmin]
		--	Where UserId = @vCurrUsrId	

		--END
		

		INSERT INTO [Masters].[tbl_Floor]
		(
			FloorId,FloorCode,FloorSrNo,FloorName, FloorDesc, FloorImageId, RevNo,
			UsernameFontsize,CreatedBy, CreatedOn,ControllerId,IsActive
		)
		VALUES
		(
			@mFloorId,@mFloorCode,@mFloorSrNO,@vFloorName,@vFloorDesc,@vFloorImageId,@vRevNo,
			@vUsernameFontsize,@vCurrUsrId,GETDATE(),@mControllerId,@vIsActive
		)

		Select FloorId = @mFloorId

	END
	ELSE
	BEGIN
		
		Update A
		SET A.FloorName			= @vFloorName,
			A.FloorDesc			= @vFloorDesc,
			A.UpdatedBy			= @vCurrUsrId,
			A.UpdatedOn			= GETDATE(),
			A.UsernameFontsize  = @vUsernameFontsize,
			--A.ControllerId      = CASE WHEN @vControllerId IS NOT NULL THEN @vControllerId ELSE ControllerId END,
			A.IsActive			= @vIsActive
		FROM [Masters].[tbl_Floor] A
		Where A.FloorId = @vFloorId

		Select FloorId = @vFloorId

	END
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_FloorAdmin_List]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_FloorAdmin_List]
	--@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT FloorAdmId = A.UserId,FloorAdmName = A.Username
	FROM [Masters].[tbl_Users] A
	Where A.RoleId = 2 AND A.IsActive = 1
	ORDER BY CreatedOn DESC

END
GO
/****** Object:  StoredProcedure [Masters].[spr_FloorMap_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_FloorMap_Save]
	@vId				BIGINT,
	@vFloorId			BIGINT,
	@vWidth				Nvarchar(50),
	@vheight			Nvarchar(50),
	@vSeatId			NVARCHAR(MAX),
	@vSeatDetails		Nvarchar(500),
	@vCurrentX			Nvarchar(500),
	@vCurrentY			Nvarchar(500),
	@vIsActive			BIT,
	@vCurrUsrId			BIGINT,
	@vIsEdit			VARCHAR(1)
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mId	BIGINT

	IF(@vIsEdit = 'N')
	BEGIN
			
		Select @mId = ISNULL(MAX(Id),0) + 1
		FROM [Masters].[tbl_FloorMap]

		INSERT INTO [Masters].[tbl_FloorMap]
		(
			Id, FloorId, Width, Height, SeatId, SeatDetails, 
			CurrentX,CurrentY, [Status], CreatedBy, CreatedOn
		)
		VALUES
		(
			@mId,@vFloorId,@vWidth,@vheight,@vSeatId,@vSeatDetails,
			@vCurrentX,@vCurrentY,@vIsActive,@vCurrUsrId,GETDATE()
		)

	END
	ELSE
	BEGIN
			
		Update A
		SET A.Width			= @vWidth,
			A.Height		= @vheight,
			A.SeatId		= @vSeatId,
			A.SeatDetails	= @vSeatDetails,
			A.CurrentX		= @vCurrentX,
			A.CurrentY		= @vCurrentY,
			A.[Status]		= @vIsActive,
			A.UpdatedBy		= @vCurrUsrId,
			A.UpdatedOn		= GETDATE()
		FROM [Masters].[tbl_FloorMap] A
		Where A.Id = @vId
	END


    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_GetAllControllerList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_GetAllControllerList]
AS
BEGIN
	
	SET NOCOUNT ON;

	Select ControllerId = CONVERT(VARCHAR,ControllerId),ControllerName
	FROM [Masters].[tbl_ControllerMap]
	Where [Status] = 1
	Order by CreatedOn 

    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_GetAllDepartment]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_GetAllDepartment]
	--@vCurrUserId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select DeptId = CONVERT(VARCHAR,DeptId),DeptName
	FROM [Masters].[tbl_Department]
	Order by DeptId desc
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_GetAllFloor]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_GetAllFloor] '1'
-- =============================================
CREATE PROCEDURE [Masters].[spr_GetAllFloor]
	@vCurrUserId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select FloorId = CONVERT(VARCHAR,A.UserId),[FloorName] = A.FNKanji + ' ' + A.LNKanji + ' (' + A.Username + ')'
	FROM [Masters].[tbl_Users] A
	LEFT OUTER JOIN [Masters].[tbl_ControllerMap_FloorAdmin] B
		On A.UserId = B.UserId
	Where A.IsActive = 1 AND A.RoleId != 3 AND B.Id IS NULL
	Order by A.FNKanji
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_GetAllFloorList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_GetAllFloor] '1'
-- =============================================
CREATE PROCEDURE [Masters].[spr_GetAllFloorList]
	--@vCurrUserId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select FloorId = CONVERT(VARCHAR,A.FloorId),[FloorName] = A.FloorName
	FROM [Masters].[tbl_Floor] A
	Order by A.FloorId desc
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_GetAllRoles]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_GetAllRoles]
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT RoleId = CONVERT(VARCHAR,RoleId),Rolename
	FROM [dbo].[tbl_Roles] A
	ORDER BY A.Rolename

END
GO
/****** Object:  StoredProcedure [Masters].[spr_GetFloorMapDtls]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_GetFloorMapDtls] 19,NULL,'BS'
-- ===============================================
CREATE PROCEDURE [Masters].[spr_GetFloorMapDtls]
	@vFloorId	BIGINT,
	@vId		BIGINT,
	@vType		VARCHAR(10)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	Select  DISTINCT 
					A.Id, A.FloorId, Width, Height, SeatId, SeatDetails, CurrentX, CurrentY, A.[Status], 
				    B.UsageStartTime,
					[BGColor] = CASE 
									WHEN (B.Id IS NOT NULL AND @vType = 'Srch' AND B.FloorMapId = @vId AND (B.IsBooked = 1 OR B.IsWFH = 1)) THEN 'yellow'
									WHEN (B.Id IS NOT NULL AND B.IsBooked = 1) THEN 'Orange'
									ELSE  'rgba(0, 0, 255, 0.25)' 
								END,
					[FNName] = ISNULL(Usr.FNKanji,''),[LNName] = ISNULL(Usr.LNKanji,''),
					IsBooked = CASE WHEN B.IsBooked = 1 THEN '1' ELSE  '0' END,
					Usr.UserDisplay, Usr.UserTitle,
					ProfilePhoto = ISNULL(ProfPic.ImageName,''),ProfilePhotoPath = ISNULL(ProfPic.ImagePath,''),
					ProfPic.ImgId,UsernameFontsize = F.UsernameFontsize,
					FloorMapId  = ISNULL(B.FloorMapId,0),B.IsWFH,
					CreatedBy = ISNULL(B.CreatedBy,0),
					D.DeptName,Usr.UserTitle,Usr.LNKanji,Usr.FNKanji,
					Usr.UserId
	from [Masters].[tbl_FloorMap] A
	INNER JOIN Masters.tbl_Floor F
		On A.FloorId = F.FloorId
	LEFT OUTER JOIN [dbo].[SeatingLogToday] B
		ON A.Id = B.FloorMapId AND B.FloorId = F.FloorId AND (B.IsBooked = 1 OR B.IsWFH = 1) 
	LEFT OUTER JOIN Masters.tbl_Users Usr
		ON Usr.UserId = B.UserId
	LEFT OUTER JOIN Masters.tbl_Department D
		ON D.DeptId = Usr.DeptId
	LEFT OUTER JOIN [dbo].[tbl_ProfPicImageDtls] ProfPic
		ON Usr.UserId = ProfPic.PId
	Where A.FloorId = @vFloorId AND A.[Status] = 1
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_Image_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_Image_Save]
	@vImgId			BIGINT,
	@vPId			BIGINT,
	@vImageName		NVARCHAR(255),
	@vOrgImageName	NVARCHAR(MAX),
	@vImageDesc		NVARCHAR(MAX),
	@vImagePath		NVARCHAR(MAX),
	@vIsEdit		VARCHAR(1),
	@vCurrUsrId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mImgId	BIGINT

	IF(@vIsEdit = 'N')
	BEGIN
			
		Select @mImgId = ISNULL(MAX(ImgId),0) + 1
		FROM [dbo].[tbl_ImageDtls]

		INSERT INTO [dbo].[tbl_ImageDtls]
		(
			ImgId, PId, ImageName,OrgImageName, ImageDesc, ImagePath, CreatedBy, CreatedOn
		)
		VALUES
		(
			@mImgId,@vPId,@vImageName,@vOrgImageName,@vImageDesc,@vImagePath,@vCurrUsrId,GETDATE()
		)

	END
	ELSE
	BEGIN
		
		Update A
		SET A.ImageName	= @vImageName,
			A.OrgImageName = @vImageName,
			A.ImageDesc	= @vImageDesc,
			A.ImagePath	= @vImagePath
		FROM [dbo].[tbl_ImageDtls] A
		Where A.ImgId = @vImgId

	END

    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_Role_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_Role_Save]
	@vRoleId			BIGINT,
	@vRoleName			NVARCHAR(255),
	@vIsEdit			VARCHAR(1),
	@vCurrUserId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mRoleId BIGINT

	IF(@vIsEdit = 'N')
	BEGIN
		
		Select @mRoleId = ISNULL(MAX(RoleId),0) + 1
		FROM [dbo].[tbl_Roles]

		INSERT INTO [dbo].[tbl_Roles]
		(
			RoleId, Rolename, CreatedBy, CreatedOn
		)
		VALUES
		(
			@mRoleId,@vRoleName,ISNULL(@vCurrUserId,0),GETDATE()
		)

	END
	ELSE
	BEGIN
		
		UPDATE A
		SET A.Rolename  = @vRoleName,
			A.UpdatedBy = @vCurrUserId,
			A.UpdatedOn = GETDATE()
		FROM [dbo].[tbl_Roles] A
		Where A.RoleId = @vRoleId

	END
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_Roles_GetList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_Roles_GetList]
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT RowId = ROW_NUMBER() over(order by RoleId desc),RoleId,Rolename, 
		  [Status] = CASE WHEN IsActive = 1 THEN 'Active' ELSE 'InActive' END,CreatedBy,
		  CreatedOn = [dbo].[GetFormattedDate](CreatedOn)
	FROM dbo.tbl_Roles
	ORDER BY CreatedOn DESC

END
GO
/****** Object:  StoredProcedure [Masters].[spr_SeatBook_GetList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_SeatBook_GetList] 3
-- =============================================
CREATE PROCEDURE [Masters].[spr_SeatBook_GetList]
	@vCurrUserId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select RowId = Row_number() over(order by B.UsageStartTime desc),FloorName = ISNULL(FL.FloorName,'Work From Home'),
		   BookedOn = dbo.GetFormattedDate(B.UsageStartTime)
	from [dbo].[SeatingLogToday] B
	LEFT OUTER JOIN Masters.tbl_Floor FL
		On FL.FloorId = B.FloorId
	Where B.UserId = @vCurrUserId AND (B.IsBooked = 1 OR (B.IsWFH = 1 AND B.UsageStartTime != ''))
	ORDER BY B.UsageStartTime desc



END
GO
/****** Object:  StoredProcedure [Masters].[spr_User_FloorMap]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_User_FloorMap]
	@vUserId			BIGINT,
	@vUserFloorListUT	[UserFloorListUT] READONLY,
	@vIsEdit			varchar(1),
	@vCurrUserId		varchar(MAX)
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mId BIGINT

	Select @mId = ISNULL(MAX(Id),0)
	From [Masters].[tbl_Users_Floors]

	INSERT INTO [Masters].[tbl_Users_Floors]
	(	
		Id, UserId, FloorId, FlrSelect, IsActive, CreatedBy, CreatedOn
	)
	Select RowId = ROW_NUMBER() over(order by (select 1)) + @mId,@vUserId,parsename(replace(A.FloorId, ':', '.' ), 1),[Select],1,@vCurrUserId,GETDATE()
	from @vUserFloorListUT A
	LEFT OUTER JOIN [Masters].[tbl_Users_Floors] B
		on A.FloorId = B.FloorId
	Where IsType = 'N' AND B.FloorId IS NULL

	Update A
	SET A.IsActive = 0
	FROM [Masters].[tbl_Users_Floors] A
	INNER JOIN @vUserFloorListUT B
		ON A.FloorId = B.FloorId
	WHere B.IsType = 'D' AND A.UserId = @vUserId

END
GO
/****** Object:  StoredProcedure [Masters].[spr_User_GetUserById]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_User_GetUserById] '2'
-- =============================================
CREATE PROCEDURE [Masters].[spr_User_GetUserById]
	@vUserId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT RowId = ROW_NUMBER() over(order by UserId),UserId,Username,[Password],FNKanji,LNKanji,
		   FNFurigana,LNFurigana,FNRomaji,LNRomaji,RoleId = CONVERT(VARCHAR,RoleId),
		   DeptId = CONVERT(VARCHAR,DeptId),
		   FloorId = CONVERT(VARCHAR,A.FloorId),
		   [OrgStatus] = CASE WHEN A.IsActive = 1 THEN 'Active' ELSE 'InActive' END,
		   [Status] = CONVERT(VARCHAR,A.IsActive),
		   A.CreatedBy,CreatedOn = [dbo].[GetFormattedDate](A.CreatedOn),
		   A.UserDisplay, A.UserTitle,ProfilePhoto = ISNULL(B.ImageName,''),ProfilePhotoPath = ISNULL(B.ImagePath,''),
		   B.ImgId,HomeMapId = ISNULL(CONVERT(VARCHAR,A.HomeMapFloorId),'0')
	FROM Masters.tbl_Users A
	LEFT OUTER JOIN [dbo].[tbl_ProfPicImageDtls] B
		ON A.UserId = B.PId
	Where A.UserId = @vUserId
	ORDER BY A.CreatedOn DESC

END
GO
/****** Object:  StoredProcedure [Masters].[spr_User_GetUserList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_User_GetUserList] 7
-- =============================================
CREATE PROCEDURE [Masters].[spr_User_GetUserList]
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mControllerId BIGINT,@mRoleCode varchar(max)

	Select @mRoleCode = R.RoleCode
	from [Masters].[tbl_Users] A
	INNER JOIN [dbo].[tbl_Roles] R
		On A.RoleId = R.RoleId
	Where UserId = @vCurrUserId

	IF (@mRoleCode = 'SystemAdm')
	BEGIN

		SELECT RowId = ROW_NUMBER() over(order by UserId desc),UserId,Username,FNKanji,LNKanji,
			   FNFurigana,LNFurigana,FNRomaji,LNRomaji,
			   [Status] = CASE WHEN IsActive = 1 THEN 'Active' ELSE 'InActive' END,
			   CreatedBy,CreatedOn = dbo.GetFormattedDate(CreatedOn),OrgCreatedOn = CreatedOn
		FROM Masters.tbl_Users
		ORDER BY OrgCreatedOn DESC

	END
	ELSE
	BEGIN
		
		Select @mControllerId = ControllerMapId
		FROM [Masters].[tbl_ControllerMap_FloorAdmin]
		Where UserId = @vCurrUserId

		Select UserId
		INTO #Temp
		FROM [Masters].[tbl_ControllerMap_FloorAdmin] 
		Where ControllerMapId = @mControllerId AND [IsActive] = 1

		SELECT RowId = ROW_NUMBER() over(order by UserId desc),UserId,Username,FNKanji,LNKanji,
			   FNFurigana,LNFurigana,FNRomaji,LNRomaji,
			   [Status] = CASE WHEN IsActive = 1 THEN 'Active' ELSE 'InActive' END,
			   CreatedBy,CreatedOn = dbo.GetFormattedDate(CreatedOn),OrgCreatedOn = CreatedOn
		FROM Masters.tbl_Users A
		Where A.HomeMapFloorId IS NOT NULL AND A.CreatedBy IN (Select UserId 
															   FROM #Temp)
		ORDER BY OrgCreatedOn DESC


	END

END
GO
/****** Object:  StoredProcedure [Masters].[spr_User_ProfPicImage_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_User_ProfPicImage_Save]
	@vImgId			BIGINT,
	@vPId			BIGINT,
	@vImageName		NVARCHAR(255),
	@vOrgImageName	NVARCHAR(MAX),
	@vImageDesc		NVARCHAR(MAX),
	@vImagePath		NVARCHAR(MAX),
	@vIsEdit		VARCHAR(1),
	@vCurrUsrId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mImgId	BIGINT

	IF NOT EXISTS(Select 1
				  FROM [dbo].[tbl_ProfPicImageDtls] A
				  Where A.PId = @vPId)
	BEGIN
			
		Select @mImgId = ISNULL(MAX(ImgId),0) + 1
		FROM [dbo].[tbl_ProfPicImageDtls]

		INSERT INTO [dbo].[tbl_ProfPicImageDtls]
		(
			ImgId, PId, ImageName,OrgImageName, ImageDesc, ImagePath, CreatedBy, CreatedOn
		)
		VALUES
		(
			@mImgId,@vPId,@vImageName,@vOrgImageName,@vImageDesc,@vImagePath,@vCurrUsrId,GETDATE()
		)

	END
	ELSE
	BEGIN
		
		Update A
		SET A.ImageName	= @vImageName,
			A.OrgImageName = @vImageName,
			A.ImageDesc	= @vImageDesc,
			A.ImagePath	= @vImagePath
		FROM [dbo].[tbl_ProfPicImageDtls] A
		Where A.ImgId = @vImgId

	END
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_User_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_User_Save]
	@vUserId			BIGINT,
	@vFNKanji			NVARCHAR(255),
	@vLNKanji			NVARCHAR(255),
	@vFNFurigana		NVARCHAR(255),
	@vLNFurigana		NVARCHAR(255),
	@vFNRomaji			NVARCHAR(255),
	@vLNRomaji			NVARCHAR(255),
	@vIsActive			BIT,
	@vRoleId			BIGINT,
	@vDeptId			BIGINT,
	@vFloorId			BIGINT,
	@vUsername			NVARCHAR(500),
	@vPassword			NVARCHAR(500),
	@vUserDisp			NVARCHAR(500),
	@vUserTitle			NVARCHAR(500),
	@vHomeMapId			BIGINT,
	@vIsEdit			NVARCHAR(1),
	@vCurrUserId		BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	IF(@vIsEdit = 'N')
	BEGIN

		Declare @mUserId BIGINT
		
		Select @mUserId = ISNULL(MAX(UserId),0) + 1
		FROM [Masters].[tbl_Users]

		INSERT INTO [Masters].[tbl_Users]
		(
			UserId, Username, FNKanji, LNKanji, FNFurigana, LNFurigana, 
			FNRomaji, LNRomaji,RoleId,DeptId,FloorId,[Password],UserDisplay,UserTitle,CreatedBy, CreatedOn
		)
		VALUES
		(
			@mUserId,@vUsername,@vFNKanji,@vLNKanji,@vFNFurigana,@vLNFurigana,@vFNRomaji,
			@vLNRomaji,@vRoleId,@vDeptId,@vFloorId,@vPassword,@vUserDisp,@vUserTitle,
			ISNULL(@vCurrUserId,0),GETDATE()
		)

		Select UserId = @mUserId

	END
	ELSE
	BEGIN
		
		UPDATE A
		SET A.FNKanji		 = @vFNKanji,
			A.LNKanji		 = @vLNKanji,
			A.FNFurigana	 = @vFNFurigana,
			A.LNFurigana	 = @vLNFurigana,
			A.FNRomaji		 = @vFNRomaji,
			A.LNRomaji		 = @vLNRomaji,
			A.DeptId		 = CASE WHEN @vDeptId IS NOT NULL THEN @vDeptId ELSE A.[DeptId] END,
			A.FloorId		 = CASE WHEN @vFloorId IS NOT NULL THEN @vFloorId ELSE A.[FloorId] END,
			A.Username		 = CASE WHEN @vUsername IS NOT NULL THEN @vUsername ELSE A.[Username] END,
			A.[Password]	 = CASE WHEN @vPassword IS NOT NULL THEN @vPassword ELSE A.[Password] END,
			A.UpdatedBy		 = @vCurrUserId,
			A.UpdatedOn		 = GETDATE(),
			A.UserDisplay	 = CASE WHEN @vUserDisp IS NOT NULL THEN @vUserDisp ELSE A.UserDisplay END,
			A.UserTitle		 = CASE WHEN @vUserTitle IS NOT NULL THEN @vUserTitle ELSE A.UserTitle END,
			A.IsActive		 = CASE WHEN @vIsActive IS NOT NULL THEN @vIsActive ELSE A.IsActive END,
			A.HomeMapFloorId = CASE WHEN @vHomeMapId IS NOT NULL THEN @vHomeMapId ELSE A.HomeMapFloorId END
		FROM [Masters].[tbl_Users] A
		Where A.UserId = @vUserId

		Select UserId = @vUserId

	END
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_GetAllFloor]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_UserAccess_GetAllFloor] 11,NULL
-- =================================================
CREATE PROCEDURE [Masters].[spr_UserAccess_GetAllFloor]
	@vUserId	BIGINT,
	@vType		VARCHAR(50) = 'SeatBook'
AS
BEGIN
	
	SET NOCOUNT ON;


	Declare @mControllerMapId BIGINT,@mRoleCode varchar(50) = ''

	Select @mRoleCode = ISNULL(R.RoleCode,'')
	FROM Masters.tbl_Users A
	INNER JOIN dbo.tbl_Roles R
		On A.RoleId = R.RoleId
	Where A.UserId = @vUserId

	PRINT @mRoleCode

	IF(@vType = 'UsrAccess')
	BEGIN
		
		Select @mControllerMapId = ControllerMapId
		FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
		Where A.UserId = @vUserId

		Select DISTINCT FloorId =CONVERT(VARCHAR,A.FloorId),[FloorName] = A.FloorName
		from Masters.tbl_Floor A
		WHere A.IsActive = 1 AND A.CreatedBy IN (Select A.UserId
													FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
													Where A.ControllerMapId = @mControllerMapId)
		Order by A.FloorName

			
	END
	ELSE IF(@vType = 'SeatSrch')
	BEGIN
		
		IF(@mRoleCode = 'SystemAdm')
		BEGIN

			Select RowId = ROW_NUMBER() over(order by A.FloorName),*
			FROM (
					Select DISTINCT FloorCode,A.FloorId,[FloorName] = A.FloorName,A.FloorDesc
					from Masters.tbl_Floor A
					INNER JOIN [Masters].[tbl_UserAccess] B
						ON A.FloorId = B.FloorId
			WHere A.IsActive = 1) A
			Order by A.FloorName	

		END
		ELSE
		BEGIN
			
			Select RowId = ROW_NUMBER() over(order by A.FloorName),*
			FROM (
					Select DISTINCT FloorCode,A.FloorId,[FloorName] = A.FloorName,A.FloorDesc
					from Masters.tbl_Floor A
					INNER JOIN [Masters].[tbl_UserAccess] B
						ON A.FloorId = B.FloorId
					INNER JOIN [Masters].[tbl_UserAccess_Users] Usr
						On B.UserAccessId = Usr.UserAccessId AND Usr.IsActive = 1
			WHere A.IsActive = 1 AND Usr.UserId = @vUserId ) A
			Order by A.FloorName	

		END

	END
	ELSE
	BEGIN
		
		IF(@mRoleCode = 'SystemAdm')
		BEGIN
			
			Select RowId = ROW_NUMBER() over(order by A.FloorName),*
			FROM (
				   Select DISTINCT FloorCode, A.FloorId,[FloorName] = A.FloorName,A.FloorDesc
				   from Masters.tbl_Floor A
				   INNER JOIN [Masters].[tbl_UserAccess] B
				   	ON A.FloorId = B.FloorId
				   INNER JOIN [Masters].[tbl_UserAccess_Users] Usr
				   	On B.UserAccessId = Usr.UserAccessId AND Usr.IsActive = 1
				   WHere A.IsActive = 1 AND Usr.ActionType IN ('Vw','UVw')) A
			Order by A.FloorName
			
		END
		ELSE
		BEGIN
			
			Select RowId = ROW_NUMBER() over(order by A.FloorName),*
			FROM (
					Select DISTINCT FloorCode,A.FloorId,[FloorName] = A.FloorName,A.FloorDesc
					from Masters.tbl_Floor A
					INNER JOIN [Masters].[tbl_UserAccess] B
						ON A.FloorId = B.FloorId
					INNER JOIN [Masters].[tbl_UserAccess_Users] Usr
						On B.UserAccessId = Usr.UserAccessId AND Usr.IsActive = 1
					WHere A.IsActive = 1 AND Usr.ActionType IN ('UVw') AND Usr.UserId = @vUserId ) A
			Order by A.FloorName

		END

	END

END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_GetAllFloorBkp]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_UserAccess_GetAllFloor] 4,'UsrAccess'
-- =================================================
CREATE PROCEDURE [Masters].[spr_UserAccess_GetAllFloorBkp]
	@vUserId	BIGINT,
	@vType		VARCHAR(50) = 'SeatBook'
AS
BEGIN
	
	SET NOCOUNT ON;

	--Declare @mRoleCode varchar(50),@mControllerMapId BIGINT

	--Select @mRoleCode = CASE WHEN FA.UserId IS NOT NULL THEN 1 ELSE U.RoleId END
	--FROM Masters.tbl_Users U
	--LEFT OUTER JOIN [Masters].[tbl_ControllerMap_FloorAdmin] FA
	--	On U.UserId = FA.UserId
	--Where U.UserId = @vUserId

	--IF(@mRoleCode = 1)
	--BEGIN
		
	--	Select @mControllerMapId = ControllerMapId
	--	FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
	--	Where A.UserId = @vUserId

	--	Select DISTINCT A.FloorId,[FloorName] = A.FloorName
	--	from Masters.tbl_Floor A
	--	WHere A.IsActive = 1 AND A.CreatedBy IN (Select A.UserId
	--											 FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
	--											 Where A.ControllerMapId = @mControllerMapId)
	--	Order by A.FloorName

	--END
	--ELSE
	--BEGIN

		Declare @mControllerMapId BIGINT

		IF(@vType = 'UsrAccess')
		BEGIN
			
			Select @mControllerMapId = ControllerMapId
			FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
			Where A.UserId = @vUserId

			Select DISTINCT A.FloorId,[FloorName] = A.FloorName
			from Masters.tbl_Floor A
			WHere A.IsActive = 1 AND A.CreatedBy IN (Select A.UserId
														FROM [Masters].[tbl_ControllerMap_FloorAdmin] A
														Where A.ControllerMapId = @mControllerMapId)
			Order by A.FloorName

				
		END
		ELSE
		BEGIN
			
			Select RowId = ROW_NUMBER() over(order by A.FloorName),FloorCode,
				   A.FloorId,[FloorName] = A.FloorName,A.FloorDesc
			from Masters.tbl_Floor A
			INNER JOIN [Masters].[tbl_UserAccess] B
				ON A.FloorId = B.FloorId
			INNER JOIN [Masters].[tbl_UserAccess_Users] Usr
				On B.UserAccessId = Usr.UserAccessId
			WHere A.IsActive = 1 AND Usr.ActionType IN ('Vw','UVw') AND Usr.UserId = @vUserId
			Order by A.FloorName

		END

		

	--END
	
END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_GetAllMapFloor]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_GetAllHomeMapFloor] 10
-- =============================================
CREATE PROCEDURE [Masters].[spr_UserAccess_GetAllMapFloor]
	@vCurrUsrId	   BIGINT
AS
BEGIN

	--INSERT INTO ##Temp
	--Select @vCurrUsrId

	
	SET NOCOUNT ON;

	Declare @mControllerId BIGINT,@mRoleCode varchar(max)

	Select @mRoleCode = R.RoleCode
	from [Masters].[tbl_Users] A
	INNER JOIN [dbo].[tbl_Roles] R
		On A.RoleId = R.RoleId
	Where UserId = @vCurrUsrId

	Select DISTINCT FloorId = CONVERT(VARCHAR,A.FloorId),[FloorName] = A.FloorName
	from Masters.tbl_Floor A
	INNER JOIN [Masters].[tbl_UserAccess] B
		ON A.FloorId = B.FloorId
	INNER JOIN [Masters].[tbl_UserAccess_Users] Usr
		On B.UserAccessId = Usr.UserAccessId
	WHere A.IsActive = 1 AND Usr.ActionType IN ('UVw') AND Usr.UserId = @vCurrUsrId
	Order by [FloorName]	
	
END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_GetAllUsers]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =================================================
CREATE PROCEDURE [Masters].[spr_UserAccess_GetAllUsers]
AS
BEGIN
	
	SET NOCOUNT ON;

	Select A.UserId,[Name] = ISNULL(LNKanji,'') + ' ' + ISNULL(FNKanji,'') + ' (' + A.Username + ')'
	from Masters.tbl_Users A
	INNER JOIN dbo.tbl_Roles R
		On A.RoleId = R.RoleId
	WHere A.IsActive = 1
	Order by [Name]
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_GetById]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_UserAccess_GetById] 2
-- =============================================
CREATE PROCEDURE [Masters].[spr_UserAccess_GetById]
	@vUserAccessId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Select A.UserAccessId, A.FloorId,B.FloorName, A.FloorDesc, IsActive = CONVERT(VARCHAR,A.IsActive),
			A.CreatedBy, A.CreatedOn
	from [Masters].[tbl_UserAccess] A
	INNER JOIN Masters.tbl_Floor B
		On A.FloorId = B.FloorId
	Where A.UserAccessId = @vUserAccessId

	Select RowId = ROW_NUMBER() over(order by A.ActionDate),A.Id,A.UserId,UserName = U.LNKanji + ' ' + U.FNKanji+ ' (' + U.Username + ')',
		   [Select] = A.ActionType,IsType = 'E', IsActive = CASE WHEN A.IsActive = 1 THEN 'Active' ELSE 'InActive' END,
		   ActionDate
	FROM [Masters].[tbl_UserAccess_Users] A
	INNER JOIN Masters.tbl_Users U
		On U.UserId  = A.UserId AND A.UserAccessId = @vUserAccessId
	Where A.UserAccessId = @vUserAccessId AND A.IsActive = 1
	Order by A.ActionDate
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_GetList]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- [Masters].[spr_UserAccess_GetList] '1'
-- ===============================================
CREATE PROCEDURE [Masters].[spr_UserAccess_GetList]
	@vCurrUserId	BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mRoleCode varchar(50) = '',@mControllerId BIGINT

	Select @mRoleCode = ISNULL(R.RoleCode,'')
	FROM Masters.tbl_Users A
	INNER JOIN dbo.tbl_Roles R
		On A.RoleId = R.RoleId
	Where A.UserId = @vCurrUserId

	IF(@mRoleCode = 'SystemAdm')
	BEGIN
		
		SELECT RowId = ROW_NUMBER() over(order by A.CreatedOn desc),
			   UserAccessId,
			   F.FloorName,A.FloorDesc,
			   CreatedBy = U.FNKanji + ' ' + U.LNKanji,
			   IsActive = CASE WHEN A.IsActive = 1 THEN 'Active' ELSE 'InActive' END,
			   CreatedOn = [dbo].[GetFormattedDate](A.CreatedOn)
		FROM [Masters].[tbl_UserAccess] A
		INNER JOIN [Masters].[tbl_Floor] F
			On A.FloorId = F.FloorId
		INNER JOIN Masters.tbl_Users U
			ON U.UserId = A.CreatedBy
		ORDER BY A.CreatedOn desc
		
		
	END
	ELSE
	BEGIN
		
		Select @mControllerId = ControllerMapId
		FROM [Masters].[tbl_ControllerMap_FloorAdmin]
		Where UserId = @vCurrUserId

		Select UserId
		INTO #Temp
		FROM [Masters].[tbl_ControllerMap_FloorAdmin] 
		Where ControllerMapId = @mControllerId

		SELECT RowId = ROW_NUMBER() over(order by A.CreatedOn desc),
			   UserAccessId,
			   F.FloorName,A.FloorDesc,
			   CreatedBy = U.FNKanji + ' ' + U.LNKanji,
			   IsActive = CASE WHEN A.IsActive = 1 THEN 'Active' ELSE 'InActive' END,
			   CreatedOn = [dbo].[GetFormattedDate](A.CreatedOn)
		FROM [Masters].[tbl_UserAccess] A
		INNER JOIN [Masters].[tbl_Floor] F
			On A.FloorId = F.FloorId
		INNER JOIN Masters.tbl_Users U
			ON U.UserId = A.CreatedBy
		Where A.CreatedBy IN (Select UserId
							 FROM #Temp)
		ORDER BY A.CreatedOn desc
		
	END
	

	

END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_Save]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Masters].[spr_UserAccess_Save]
	@vUserAccessId	BIGINT, 
	@vFloorId		BIGINT, 
	@vFloorDesc		NVARCHAR(MAX),
	@vIsActive		VARCHAR(1),
	@vCurrUserId	BIGINT,
	@vIsEdit		VARCHAR(1)
AS
BEGIN
	
	SET NOCOUNT ON;

	IF(@vIsEdit = 'N')
	BEGIN
		
		Declare @mUserAccessId BIGINT

		Select @mUserAccessId = ISNULL(MAX(UserAccessId),0) + 1
		FROM [Masters].[tbl_UserAccess]

		INSERT INTO [Masters].[tbl_UserAccess]
		(
			UserAccessId, FloorId, FloorDesc, IsActive, CreatedBy, CreatedOn
		)
		VALUES
		(
			@mUserAccessId,@vFloorId,@vFloorDesc,@vIsActive,@vCurrUserId,GETDATE()
		)

		Select UserAccessId = @mUserAccessId

	END
	ELSE
	BEGIN
		
		Update A
		SET A.FloorDesc = @vFloorDesc,
			A.IsActive  = @vIsActive,
			A.UpdatedBy	= @vCurrUserId,
			A.UpdatedOn	= GETDATE()
		FROM [Masters].[tbl_UserAccess] A
		Where A.UserAccessId = @vUserAccessId

		Select UserAccessId = @vUserAccessId

	END
    
END
GO
/****** Object:  StoredProcedure [Masters].[spr_UserAccess_SaveUsers]    Script Date: 2023-06-19 7:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- ==================================================
CREATE PROCEDURE [Masters].[spr_UserAccess_SaveUsers]
	@vUserAccessId		BIGINT, 
	@vUserAccessListUT  UserAccessListUT READONLY
AS
BEGIN
	
	SET NOCOUNT ON;

	Declare @mId BIGINT

	Select @mId = ISNULL(MAX(ID),0 ) + 1
	FROM [Masters].[tbl_UserAccess_Users]

	INSERT INTO [Masters].[tbl_UserAccess_Users]
	(
		Id, UserAccessId, UserId, ActionType, IsActive, ActionDate
	)
	Select RowId = Row_number() over(order by (select 1)) + @mId,@vUserAccessId,A.UserId,[Select],1,GETDATE()
	FROM @vUserAccessListUT A
	LEFT OUTER JOIN [Masters].[tbl_UserAccess_Users] B
		On @vUserAccessId = B.UserAccessId AND B.UserId = A.UserId AND B.IsActive = 1
	Where A.IsType = 'N' AND B.UserId IS NULL

	Update A
	SET A.ActionType = B.[Select],
		A.UpdateDate = GETDATE()
	FROM [Masters].[tbl_UserAccess_Users] A
	INNER JOIN @vUserAccessListUT B
		On @vUserAccessId = A.UserAccessId AND B.UserId = A.UserId AND A.Id = B.Id
	Where B.IsType = 'E'

	Update A
	SET A.IsActive = 0
	FROM [Masters].[tbl_UserAccess_Users] A
	INNER JOIN @vUserAccessListUT B
		On @vUserAccessId = A.UserAccessId AND B.UserId = A.UserId
	Where B.IsType = 'D'
    
END
GO
USE [master]
GO
ALTER DATABASE [Seat_myospaz] SET  READ_WRITE 
GO
