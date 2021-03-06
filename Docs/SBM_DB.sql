USE [master]
GO
/****** Object:  Database [SBM]    Script Date: 20/01/2017 17:11:40 ******/
CREATE DATABASE [SBM]
GO
ALTER DATABASE [SBM] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SBM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SBM] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [SBM] SET ANSI_NULLS ON 
GO
ALTER DATABASE [SBM] SET ANSI_PADDING ON 
GO
ALTER DATABASE [SBM] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [SBM] SET ARITHABORT ON 
GO
ALTER DATABASE [SBM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SBM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SBM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SBM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SBM] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [SBM] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [SBM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SBM] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [SBM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SBM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SBM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SBM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SBM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SBM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SBM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SBM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SBM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SBM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SBM] SET  MULTI_USER 
GO
ALTER DATABASE [SBM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SBM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SBM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SBM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SBM] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SBM', N'ON'
GO
ALTER DATABASE [SBM] SET QUERY_STORE = OFF
GO
USE [SBM]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [SBM]
GO
/****** Object:  User [SBM]    Script Date: 20/01/2017 17:11:45 ******/
CREATE USER [SBM] FOR LOGIN [sbm] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [SBM]
GO
/****** Object:  Table [dbo].[SBM_EVENT]    Script Date: 20/01/2017 17:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_EVENT](
	[ID_EVENT] [tinyint] NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_EVENT] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_EVENT_LOG]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_EVENT_LOG](
	[ID_EVENT_LOG] [int] IDENTITY(1,1) NOT NULL,
	[ID_EVENT] [tinyint] NOT NULL,
	[DESCRIPTION] [nvarchar](4000) NOT NULL,
	[TIME_STAMP] [datetimeoffset](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_EVENT_LOG] ASC
) 
) 

GO
/****** Object:  View [dbo].[SBM_VW-EventLog]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SBM_VW-EventLog] AS
	SELECT A.ID_EVENT_LOG, 
           A.ID_EVENT, 
           B.[DESCRIPTION] AS [EVENT], 
           A.[DESCRIPTION], 
           CONVERT(VARCHAR(20), [TIME_STAMP], 13) AS [TIME_STAMP]
      FROM SBM_EVENT_LOG AS A
INNER JOIN SBM_EVENT AS B ON B.ID_EVENT = A.ID_EVENT


GO
/****** Object:  Table [dbo].[SBM_DONE]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_DONE](
	[ID_DISPATCHER] [int] NOT NULL,
	[ID_SERVICE] [smallint] NOT NULL,
	[ID_OWNER] [smallint] NOT NULL,
	[ID_PRIVATE] [nvarchar](40) NULL,
	[ID_REMOTING] [int] NOT NULL,
	[PARAMETERS] [nvarchar](4000) NULL,
	[REQUESTED] [datetimeoffset](7) NULL,
	[STARTED] [datetimeoffset](7) NULL,
	[ENDED] [datetimeoffset](7) NULL,
	[ID_DONE_STATUS] [tinyint] NOT NULL,
	[RESULT] [nvarchar](4000) NULL,
	[HANDLE] [uniqueidentifier] NULL,
 CONSTRAINT [PK_SBM_DONE] PRIMARY KEY CLUSTERED 
(
	[ID_DISPATCHER] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_DONE_STATUS]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_DONE_STATUS](
	[ID_DONE_STATUS] [tinyint] NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
	[ALIAS_ID] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_DONE_STATUS] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_OWNER]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_OWNER](
	[ID_OWNER] [smallint] IDENTITY(1,1) NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
	[TOKEN] [nvarchar](15) NOT NULL,
	[ENABLED] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_OWNER] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_REMOTING]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_REMOTING](
	[ID_REMOTING] [int] IDENTITY(1,1) NOT NULL,
	[ID_SERVICE] [smallint] NOT NULL,
	[TARGET_SERVER] [nvarchar](50) NOT NULL,
	[SERVER_ALIAS] [nvarchar](80) NOT NULL,
	[MAX_RESPONSE_TIME] [smallint] NOT NULL,
	[ENABLED] [bit] NOT NULL,
 CONSTRAINT [PK_SBM_REMOTING] PRIMARY KEY CLUSTERED 
(
	[ID_REMOTING] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_SERVICE]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_SERVICE](
	[ID_SERVICE] [smallint] IDENTITY(1,1) NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
	[VERSION] [nvarchar](5) NOT NULL,
	[PUBLISHED] [datetimeoffset](7) NULL,
	[ID_SERVICE_TYPE] [smallint] NOT NULL,
	[ASSEMBLY_FILE] [nvarchar](60) NOT NULL,
	[ASSEMBLY_PATH] [nvarchar](250) NOT NULL,
	[MAX_TIME_RUN] [smallint] NOT NULL,
	[SINGLE_EXEC] [bit] NOT NULL,
	[DOMAIN] [nvarchar](80) NULL,
	[USER] [nvarchar](80) NULL,
	[PASSWORD] [varbinary](4000) NULL,
	[x86] [bit] NOT NULL,
	[ID_PARENT_SERVICE] [smallint] NULL,
	[ENABLED] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_SERVICE] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_SERVICE_TYPE]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_SERVICE_TYPE](
	[ID_SERVICE_TYPE] [smallint] NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
	[ALIAS_ID] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_SBM_SERVICE_TYPE] PRIMARY KEY CLUSTERED 
(
	[ID_SERVICE_TYPE] ASC
) 
) 

GO
/****** Object:  View [dbo].[SBM_VW-Done]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SBM_VW-Done] AS
    SELECT [ID_DISPATCHER] AS [ID]
	      ,D.[ID_SERVICE]
          ,S.[DESCRIPTION] AS [SERVICE]
          ,T.[DESCRIPTION] As [SERVICE TYPE]
		  ,D.[ID_OWNER]
          ,O.[DESCRIPTION] as [OWNER]
          ,[ID_PRIVATE]
          ,[PARAMETERS]
          ,CONVERT(VARCHAR(20), [REQUESTED], 13) AS [REQUESTED]
          ,CONVERT(VARCHAR(20), [STARTED], 13) AS [STARTED]
          ,CONVERT(VARCHAR(20), [ENDED], 13) AS [ENDED]
          ,RIGHT('0' + CONVERT(VARCHAR(6), DATEDIFF(SECOND, [STARTED], ISNULL([ENDED], DATEADD(HOUR, 5, GETDATE()))) / 3600), 2) + ':' +
           RIGHT('0' + CONVERT(VARCHAR(2), (DATEDIFF(SECOND, [STARTED], ISNULL([ENDED], DATEADD(HOUR, 5, GETDATE()))) % 3600) / 60), 2) + ':' +
           RIGHT('0' + CONVERT(VARCHAR(2), DATEDIFF(SECOND, [STARTED], ISNULL([ENDED], DATEADD(HOUR, 5, GETDATE()))) % 60), 2) AS [TIME RUN]
          ,R.[SERVER_ALIAS] AS SERVER
          ,DS.[DESCRIPTION] AS [DONE STATUS]
          ,[RESULT]
      FROM [SBM_DONE] AS D
INNER JOIN SBM_DONE_STATUS AS DS ON DS.[ID_DONE_STATUS] = D.[ID_DONE_STATUS]
INNER JOIN SBM_SERVICE AS S ON S.[ID_SERVICE] = D.[ID_SERVICE]
INNER JOIN SBM_OWNER AS O ON O.[ID_OWNER] = D.[ID_OWNER]
INNER JOIN SBM_SERVICE_TYPE AS T ON T.[ID_SERVICE_TYPE] = S.[ID_SERVICE_TYPE]
INNER JOIN SBM_REMOTING AS R ON R.[ID_REMOTING] = D.[ID_REMOTING]



GO
/****** Object:  Table [dbo].[SBM_SERVICE_TIMER]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_SERVICE_TIMER](
	[ID_SERVICE_TIMER] [int] IDENTITY(1,1) NOT NULL,
	[ID_SERVICE] [smallint] NOT NULL,
	[ID_OWNER] [smallint] NOT NULL,
	[ID_PRIVATE] [nvarchar](40) NULL,
	[DESCRIPTION] [nvarchar](100) NULL,
	[PARAMETERS] [nvarchar](4000) NULL,
	[RUN_INTERVAL] [smallint] NOT NULL,
	[LAST_TIME_RUN] [datetimeoffset](7) NULL,
	[NEXT_TIME_RUN] [datetimeoffset](7) NULL,
	[ENABLED] [bit] NOT NULL,
	[CRONTAB] [nvarchar](50) NULL,
 CONSTRAINT [PK_SBM_SERVICE_TIMER] PRIMARY KEY CLUSTERED 
(
	[ID_SERVICE_TIMER] ASC
) 
) 

GO
/****** Object:  View [dbo].[SBM_VW-Schedule]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SBM_VW-Schedule] AS
   SELECT  A.ID_SERVICE_TIMER AS ID,
           A.ID_SERVICE,
           C.[DESCRIPTION] AS [SERVICE],
           T.[DESCRIPTION] As [SERVICE TYPE],
		   A.[DESCRIPTION] AS [PURPOSE],
           A.ID_OWNER,
           B.[DESCRIPTION] AS [OWNER],
           A.ID_PRIVATE,
           A.[PARAMETERS],
           A.RUN_INTERVAL,
           A.CRONTAB,
           CONVERT(VARCHAR(20), [LAST_TIME_RUN], 13) AS [LAST_TIME_RUN],
           CONVERT(VARCHAR(20), [NEXT_TIME_RUN], 13) AS [NEXT_TIME_RUN],
           CASE WHEN A.[ENABLED] = 1 THEN 'Si' ELSE 'NO' END AS [ENABLED],
           CASE WHEN R.TARGET_SERVER IS NULL THEN '127.0.0.1' ELSE R.TARGET_SERVER END AS [SERVER],
           CASE WHEN R.SERVER_ALIAS IS NULL THEN 'localhost' ELSE R.SERVER_ALIAS END AS [ALIAS]
      FROM SBM_SERVICE_TIMER AS A
INNER JOIN SBM_OWNER AS B ON B.ID_OWNER = A.ID_OWNER
INNER JOIN SBM_SERVICE AS C ON C.ID_SERVICE = A.ID_SERVICE
INNER JOIN SBM_SERVICE_TYPE AS T ON T.[ID_SERVICE_TYPE] = C.[ID_SERVICE_TYPE]
 LEFT JOIN SBM_REMOTING AS R ON R.[ID_SERVICE] = A.[ID_SERVICE] 
 

GO
/****** Object:  Table [dbo].[SBM_SERVICE_OWNER]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_SERVICE_OWNER](
	[ID_SERVICE] [smallint] NOT NULL,
	[ID_OWNER] [smallint] NOT NULL,
	[SECURITY_LEVEL] [tinyint] NOT NULL,
 CONSTRAINT [PK_SBM_SERVICE_OWNER] PRIMARY KEY CLUSTERED 
(
	[ID_SERVICE] ASC,
	[ID_OWNER] ASC
) 
) 

GO
/****** Object:  View [dbo].[SBM_VW-ServiceOwner]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SBM_VW-ServiceOwner] AS
    SELECT A.ID_SERVICE,
           C.[DESCRIPTION] AS [SERVICE],
           A.ID_OWNER,
           B.[DESCRIPTION] AS [OWNER],
           ISNULL(C.ID_PARENT_SERVICE, A.[ID_SERVICE]) AS [PARENT_ID],
           ISNULL(D.[DESCRIPTION], '[Self]') AS [PARENT_SERVICE]
      FROM SBM_SERVICE_OWNER AS A
INNER JOIN SBM_OWNER AS B ON B.ID_OWNER = A.ID_OWNER
INNER JOIN SBM_SERVICE AS C ON C.ID_SERVICE = A.ID_SERVICE
 LEFT JOIN SBM_SERVICE AS D ON D.ID_SERVICE = C.ID_PARENT_SERVICE
 

GO
/****** Object:  View [dbo].[SBM_VW-Service]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SBM_VW-Service] AS
    SELECT A.[ID_SERVICE]
          ,A.[DESCRIPTION]
          ,A.[VERSION]
          ,CONVERT(VARCHAR(20), SWITCHOFFSET(A.[PUBLISHED], '-03:00'), 13) AS [PUBLISHED]
          ,C.[DESCRIPTION] As [SERVICE TYPE]
          ,A.[ASSEMBLY_FILE]
          ,A.[ASSEMBLY_PATH]
          ,A.[MAX_TIME_RUN]
          ,CASE WHEN A.[SINGLE_EXEC] = 0 THEN 'No' ELSE 'Si' END AS [ONE_EXEC]
          ,CASE WHEN A.[ENABLED] = 0 THEN 'No' ELSE 'Si' END AS [ENABLED]
          ,ISNULL(A.[DOMAIN], '') AS [DOMAIN]
          ,ISNULL(A.[USER], '') AS [USER]
          ,ISNULL(A.[PASSWORD], 0x) AS [PASSWORD]
          ,CASE WHEN A.[x86] = 0 THEN 'No' ELSE 'Si' END AS [x86]
          ,ISNULL(A.ID_PARENT_SERVICE, A.[ID_SERVICE]) AS [PARENT_ID]
          ,ISNULL(B.[DESCRIPTION], '[Self]') AS [PARENT_SERVICE]
          ,CASE WHEN R.TARGET_SERVER IS NULL THEN '127.0.0.1' ELSE R.TARGET_SERVER END AS [SERVER]
          ,CASE WHEN R.SERVER_ALIAS IS NULL THEN 'localhost' ELSE R.SERVER_ALIAS END AS [ALIAS]
      FROM [SBM_SERVICE] AS A
 LEFT JOIN SBM_SERVICE AS B ON B.ID_SERVICE = A.ID_PARENT_SERVICE
INNER JOIN SBM_SERVICE_TYPE AS C ON C.[ID_SERVICE_TYPE] = A.[ID_SERVICE_TYPE]
 LEFT JOIN SBM_REMOTING AS R ON R.[ID_SERVICE] = A.[ID_SERVICE] 

GO
/****** Object:  UserDefinedFunction [dbo].[Crypt]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Crypt](	
	@phrase nvarchar(80),
	@text nvarchar(80)
)
RETURNS TABLE AS RETURN 
	SELECT EncryptByPassPhrase(@phrase,@text) AS CRYPTED




GO
/****** Object:  UserDefinedFunction [dbo].[Decrypt]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Decrypt](	
	@phrase nvarchar(80),
	@cypher varbinary(4000)
)
RETURNS TABLE AS RETURN 
	SELECT CAST(DecryptByPassPhrase(@phrase,@cypher) AS VARCHAR) AS DECRYPTED



GO
/****** Object:  Table [dbo].[SBM_DISPATCHER]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_DISPATCHER](
	[ID_DISPATCHER] [int] IDENTITY(1,1) NOT NULL,
	[ID_SERVICE] [smallint] NOT NULL,
	[ID_OWNER] [smallint] NOT NULL,
	[ID_PRIVATE] [nvarchar](40) NULL,
	[PARAMETERS] [nvarchar](4000) NULL,
	[REQUESTED] [datetimeoffset](7) NULL,
	[HANDLE] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_DISPATCHER] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_JOB]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_JOB](
	[ID_JOB] [smallint] IDENTITY(1,1) NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
	[VERSION] [nvarchar](5) NOT NULL,
	[PUBLISHED] [datetimeoffset](7) NULL,
	[SINGLE_EXEC] [bit] NOT NULL,
	[ENABLED] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_JOB] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_JOB_FAULT]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_JOB_FAULT](
	[ID_JOB_FAULT] [tinyint] NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
	[ALIAS_ID] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_JOB_FAULT] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_JOB_SET]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_JOB_SET](
	[ID_JOB_SET] [smallint] IDENTITY(1,1) NOT NULL,
	[ID_JOB] [smallint] NOT NULL,
	[STEP] [tinyint] NOT NULL,
	[ID_SERVICE] [smallint] NOT NULL,
	[ID_OWNER] [smallint] NOT NULL,
	[ID_PRIVATE] [nvarchar](40) NULL,
	[PARAMETERS] [nvarchar](4000) NULL,
	[WAIT] [bit] NOT NULL,
	[ID_FAULT_TOLERANCE] [tinyint] NOT NULL,
	[ENABLED] [bit] NOT NULL,
 CONSTRAINT [PK_SBM_JOB_SET] PRIMARY KEY CLUSTERED 
(
	[ID_JOB] ASC,
	[STEP] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_JOB_STEP_DONE]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_JOB_STEP_DONE](
	[ID_JOB] [smallint] NOT NULL,
	[ID_DISPATCHER_JOB] [int] NOT NULL,
	[STEP] [tinyint] NOT NULL,
	[ID_DISPATCHER_STEP] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_JOB] ASC,
	[ID_DISPATCHER_JOB] ASC,
	[STEP] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_OBJ_POOL]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_OBJ_POOL](
	[ID_DISPATCHER] [int] NOT NULL,
	[ID_SERVICE] [smallint] NOT NULL,
	[ID_SERVICE_INTERNAL] [tinyint] NULL,
	[PID] [nvarchar](20) NOT NULL,
	[STARTED] [datetimeoffset](7) NOT NULL,
	[MAX_TIME_RUN] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_DISPATCHER] ASC
) 
) 

GO
/****** Object:  Table [dbo].[SBM_SERVICE_INTERNAL]    Script Date: 20/01/2017 17:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SBM_SERVICE_INTERNAL](
	[ID_SERVICE_INTERNAL] [tinyint] IDENTITY(1,1) NOT NULL,
	[DESCRIPTION] [nvarchar](100) NOT NULL,
	[VERSION] [nvarchar](5) NOT NULL,
	[ASSEMBLY_FILE] [nvarchar](60) NOT NULL,
	[CONFIG] [nvarchar](4000) NULL,
	[MAX_TIME_RUN] [smallint] NOT NULL,
	[SINGLE_EXEC] [bit] NOT NULL,
	[IS_PUBLIC] [bit] NOT NULL,
	[ENABLED] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_SERVICE_INTERNAL] ASC
) 
) 

GO
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (1, N'In Queue', N'InQ')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (2, N'In Process', N'InProc')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (3, N'Completed Successfully', N'DoneOk')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (4, N'Completed with errors', N'DoneNoOk')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (5, N'Canceled, fatal error', N'X-FErr')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (6, N'Canceled, process timeout', N'X-TMO')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (7, N'Canceled, Internal error', N'X-IErr')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (8, N'Service disabled', N'SrvOff')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (9, N'Service unknown', N'SrvUnK')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (10, N'Canceled, user request', N'X-UserR')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (11, N'Canceled, service already running', N'X-SrvRun')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (12, N'Canceled, Parent service not ready', N'X-PSrvNR')
INSERT [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS], [DESCRIPTION], [ALIAS_ID]) VALUES (13, N'Canceled, invalid Owner', N'X-XOwn')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (0, N'Unspecified')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (1, N'SBM started')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (2, N'Service pool full, not enough resources')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (3, N'New scheduled service in queue')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (4, N'Process killed, timeout')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (5, N'Error killing running process')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (6, N'Service already running')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (7, N'Audit')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (8, N'Healthy')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (9, N'SBM ended')
INSERT [dbo].[SBM_EVENT] ([ID_EVENT], [DESCRIPTION]) VALUES (10, N'Too late to run from scheduler')
SET IDENTITY_INSERT [dbo].[SBM_OWNER] ON 

INSERT [dbo].[SBM_OWNER] ([ID_OWNER], [DESCRIPTION], [TOKEN], [ENABLED]) VALUES (0, N'System', N'69i57j0l5', 1)
SET IDENTITY_INSERT [dbo].[SBM_OWNER] OFF
SET IDENTITY_INSERT [dbo].[SBM_REMOTING] ON 

INSERT [dbo].[SBM_REMOTING] ([ID_REMOTING], [ID_SERVICE], [TARGET_SERVER], [SERVER_ALIAS], [MAX_RESPONSE_TIME], [ENABLED]) VALUES (0, 0, N'localhost', N'127.0.0.1', 0, 1)
SET IDENTITY_INSERT [dbo].[SBM_REMOTING] OFF
SET IDENTITY_INSERT [dbo].[SBM_SERVICE] ON 

INSERT [dbo].[SBM_SERVICE] ([ID_SERVICE], [DESCRIPTION], [VERSION], [PUBLISHED], [ID_SERVICE_TYPE], [ASSEMBLY_FILE], [ASSEMBLY_PATH], [MAX_TIME_RUN], [SINGLE_EXEC], [DOMAIN], [USER], [PASSWORD], [x86], [ID_PARENT_SERVICE], [ENABLED]) VALUES (0, N'Internal Service Broker', N'1.0', CAST(N'2017-01-01' AS DateTimeOffset), 0, N'NONE', N'NONE', 0, 0, NULL, NULL, NULL, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[SBM_SERVICE] OFF
SET IDENTITY_INSERT [dbo].[SBM_SERVICE_INTERNAL] ON 

INSERT [dbo].[SBM_SERVICE_INTERNAL] ([ID_SERVICE_INTERNAL], [DESCRIPTION], [VERSION], [ASSEMBLY_FILE], [CONFIG], [MAX_TIME_RUN], [SINGLE_EXEC], [IS_PUBLIC], [ENABLED]) VALUES (0, N'Remoting Agent Service', N'1.0', N'', N'', 0, 0, 0, 1)
INSERT [dbo].[SBM_SERVICE_INTERNAL] ([ID_SERVICE_INTERNAL], [DESCRIPTION], [VERSION], [ASSEMBLY_FILE], [CONFIG], [MAX_TIME_RUN], [SINGLE_EXEC], [IS_PUBLIC], [ENABLED]) VALUES (1, N'JOB Manager', N'1.0', N'', N'', 0, 0, 1, 1)
SET IDENTITY_INSERT [dbo].[SBM_SERVICE_INTERNAL] OFF
INSERT [dbo].[SBM_SERVICE_OWNER] ([ID_SERVICE], [ID_OWNER], [SECURITY_LEVEL]) VALUES (0, 0, 0)
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (0, N'System Internal', N'SYS')
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (1, N'Report', N'RPT')
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (2, N'Data Transformation & Replication', N'DTS')
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (3, N'Mail Delivery & Email Spool', N'MAIL')
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (4, N'Transaction & Synchronization', N'TRX')
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (5, N'Business Logic', N'BLog')
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (6, N'Interop', N'InTOP')
INSERT [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE], [DESCRIPTION], [ALIAS_ID]) VALUES (7, N'Generic', N'ANY')

/****** Object:  Index [SBM_SERVICE_TIMER_NEXT_IDX]    Script Date: 20/01/2017 17:11:49 ******/
CREATE NONCLUSTERED INDEX [SBM_SERVICE_TIMER_NEXT_IDX] ON [dbo].[SBM_SERVICE_TIMER]
(
	[NEXT_TIME_RUN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
ALTER TABLE [dbo].[SBM_DISPATCHER] ADD  CONSTRAINT [DF_SBM_DISPATCHER_REQUESTED]  DEFAULT (getutcdate()) FOR [REQUESTED]
GO
ALTER TABLE [dbo].[SBM_DONE] ADD  CONSTRAINT [DF_SBM_DONE_ID_REMOTING]  DEFAULT ((0)) FOR [ID_REMOTING]
GO
ALTER TABLE [dbo].[SBM_DONE] ADD  CONSTRAINT [DF_SBM_DONE_STARTED]  DEFAULT (getutcdate()) FOR [STARTED]
GO
ALTER TABLE [dbo].[SBM_DONE] ADD  DEFAULT ((2)) FOR [ID_DONE_STATUS]
GO
ALTER TABLE [dbo].[SBM_EVENT_LOG] ADD  DEFAULT ((0)) FOR [ID_EVENT]
GO
ALTER TABLE [dbo].[SBM_EVENT_LOG] ADD  DEFAULT ('') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[SBM_EVENT_LOG] ADD  CONSTRAINT [DF_SBM_EVENT_LOG_TIME_STAMP]  DEFAULT (getutcdate()) FOR [TIME_STAMP]
GO
ALTER TABLE [dbo].[SBM_JOB] ADD  CONSTRAINT [DF_SBM_JOB_PUBLISHED]  DEFAULT (getutcdate()) FOR [PUBLISHED]
GO
ALTER TABLE [dbo].[SBM_JOB] ADD  DEFAULT ((1)) FOR [SINGLE_EXEC]
GO
ALTER TABLE [dbo].[SBM_JOB] ADD  DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[SBM_JOB_SET] ADD  DEFAULT ((1)) FOR [WAIT]
GO
ALTER TABLE [dbo].[SBM_JOB_SET] ADD  DEFAULT ((1)) FOR [ID_FAULT_TOLERANCE]
GO
ALTER TABLE [dbo].[SBM_JOB_SET] ADD  DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[SBM_OWNER] ADD  DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[SBM_REMOTING] ADD  CONSTRAINT [DF_SBM_REMOTING_MAX_RESPONSE_TIME]  DEFAULT ((0)) FOR [MAX_RESPONSE_TIME]
GO
ALTER TABLE [dbo].[SBM_SERVICE] ADD  CONSTRAINT [DF_SBM_SERVICE_PUBLISHED]  DEFAULT (getutcdate()) FOR [PUBLISHED]
GO
ALTER TABLE [dbo].[SBM_SERVICE] ADD  DEFAULT ((1)) FOR [ID_SERVICE_TYPE]
GO
ALTER TABLE [dbo].[SBM_SERVICE] ADD  DEFAULT ((0)) FOR [MAX_TIME_RUN]
GO
ALTER TABLE [dbo].[SBM_SERVICE] ADD  DEFAULT ((1)) FOR [SINGLE_EXEC]
GO
ALTER TABLE [dbo].[SBM_SERVICE] ADD  DEFAULT ((0)) FOR [x86]
GO
ALTER TABLE [dbo].[SBM_SERVICE] ADD  DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[SBM_SERVICE_INTERNAL] ADD  DEFAULT ((0)) FOR [MAX_TIME_RUN]
GO
ALTER TABLE [dbo].[SBM_SERVICE_INTERNAL] ADD  DEFAULT ((1)) FOR [SINGLE_EXEC]
GO
ALTER TABLE [dbo].[SBM_SERVICE_INTERNAL] ADD  DEFAULT ((0)) FOR [IS_PUBLIC]
GO
ALTER TABLE [dbo].[SBM_SERVICE_INTERNAL] ADD  DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[SBM_SERVICE_OWNER] ADD  DEFAULT ((0)) FOR [SECURITY_LEVEL]
GO
ALTER TABLE [dbo].[SBM_SERVICE_TIMER] ADD  DEFAULT ((0)) FOR [RUN_INTERVAL]
GO
ALTER TABLE [dbo].[SBM_SERVICE_TIMER] ADD  DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[SBM_SERVICE_TYPE] ADD  DEFAULT ((1)) FOR [ID_SERVICE_TYPE]
GO
ALTER TABLE [dbo].[SBM_DISPATCHER]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE], [ID_OWNER])
REFERENCES [dbo].[SBM_SERVICE_OWNER] ([ID_SERVICE], [ID_OWNER])
GO
ALTER TABLE [dbo].[SBM_DONE]  WITH CHECK ADD FOREIGN KEY([ID_DONE_STATUS])
REFERENCES [dbo].[SBM_DONE_STATUS] ([ID_DONE_STATUS])
GO
ALTER TABLE [dbo].[SBM_DONE]  WITH CHECK ADD FOREIGN KEY([ID_OWNER])
REFERENCES [dbo].[SBM_OWNER] ([ID_OWNER])
GO
ALTER TABLE [dbo].[SBM_DONE]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE])
REFERENCES [dbo].[SBM_SERVICE] ([ID_SERVICE])
GO
ALTER TABLE [dbo].[SBM_DONE]  WITH CHECK ADD  CONSTRAINT [FK_SBM_DONE_SBM_REMOTING] FOREIGN KEY([ID_REMOTING])
REFERENCES [dbo].[SBM_REMOTING] ([ID_REMOTING])
GO
ALTER TABLE [dbo].[SBM_DONE] CHECK CONSTRAINT [FK_SBM_DONE_SBM_REMOTING]
GO
ALTER TABLE [dbo].[SBM_EVENT_LOG]  WITH CHECK ADD FOREIGN KEY([ID_EVENT])
REFERENCES [dbo].[SBM_EVENT] ([ID_EVENT])
GO
ALTER TABLE [dbo].[SBM_JOB_SET]  WITH CHECK ADD FOREIGN KEY([ID_FAULT_TOLERANCE])
REFERENCES [dbo].[SBM_JOB_FAULT] ([ID_JOB_FAULT])
GO
ALTER TABLE [dbo].[SBM_JOB_SET]  WITH CHECK ADD FOREIGN KEY([ID_JOB])
REFERENCES [dbo].[SBM_JOB] ([ID_JOB])
GO
ALTER TABLE [dbo].[SBM_JOB_SET]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE], [ID_OWNER])
REFERENCES [dbo].[SBM_SERVICE_OWNER] ([ID_SERVICE], [ID_OWNER])
GO
ALTER TABLE [dbo].[SBM_JOB_STEP_DONE]  WITH CHECK ADD FOREIGN KEY([ID_JOB], [STEP])
REFERENCES [dbo].[SBM_JOB_SET] ([ID_JOB], [STEP])
GO
ALTER TABLE [dbo].[SBM_OBJ_POOL]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE])
REFERENCES [dbo].[SBM_SERVICE] ([ID_SERVICE])
GO
ALTER TABLE [dbo].[SBM_OBJ_POOL]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE_INTERNAL])
REFERENCES [dbo].[SBM_SERVICE_INTERNAL] ([ID_SERVICE_INTERNAL])
GO
ALTER TABLE [dbo].[SBM_REMOTING]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE])
REFERENCES [dbo].[SBM_SERVICE] ([ID_SERVICE])
GO
ALTER TABLE [dbo].[SBM_SERVICE]  WITH CHECK ADD FOREIGN KEY([ID_PARENT_SERVICE])
REFERENCES [dbo].[SBM_SERVICE] ([ID_SERVICE])
GO
ALTER TABLE [dbo].[SBM_SERVICE]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE_TYPE])
REFERENCES [dbo].[SBM_SERVICE_TYPE] ([ID_SERVICE_TYPE])
GO
ALTER TABLE [dbo].[SBM_SERVICE_OWNER]  WITH CHECK ADD FOREIGN KEY([ID_OWNER])
REFERENCES [dbo].[SBM_OWNER] ([ID_OWNER])
GO
ALTER TABLE [dbo].[SBM_SERVICE_OWNER]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE])
REFERENCES [dbo].[SBM_SERVICE] ([ID_SERVICE])
GO
ALTER TABLE [dbo].[SBM_SERVICE_TIMER]  WITH CHECK ADD FOREIGN KEY([ID_OWNER])
REFERENCES [dbo].[SBM_OWNER] ([ID_OWNER])
GO
ALTER TABLE [dbo].[SBM_SERVICE_TIMER]  WITH CHECK ADD FOREIGN KEY([ID_SERVICE])
REFERENCES [dbo].[SBM_SERVICE] ([ID_SERVICE])
GO
/****** Object:  StoredProcedure [dbo].[sp_enqueue]    Script Date: 20/01/2017 17:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andres Castiglia
-- Create date: 27-feb-2016
-- Description:	lazy
-- =============================================
CREATE PROCEDURE [dbo].[sp_enqueue]
	@RequestMsg NVARCHAR(4000)
AS
DECLARE 
	@Handle UNIQUEIDENTIFIER
BEGIN

	--BEGIN TRANSACTION;

	BEGIN DIALOG @Handle
		 FROM SERVICE SBM_DONE_SERVICE_INIT
		 TO SERVICE 'SBM_DONE_SERVICE_TARGET'
		 ON CONTRACT [//DISPATCHER/Contract]
		 WITH ENCRYPTION = OFF;

	SEND ON CONVERSATION @Handle
		MESSAGE TYPE  [//DISPATCHER/RequestMessage]
		(@RequestMsg);

	SELECT @Handle AS HANDLE;

	--COMMIT TRANSACTION;
END



GO
/****** Object:  StoredProcedure [dbo].[sp_join]    Script Date: 20/01/2017 17:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andres Castiglia
-- Create date: 27-feb-2016
-- Description:	lazy
-- =============================================
CREATE PROCEDURE [dbo].[sp_join]
	@Handle UNIQUEIDENTIFIER,
	@timeout bigint = 30000
AS
DECLARE 
	@RecvReplyMsg xml
BEGIN

	--BEGIN TRANSACTION;

	WAITFOR
	(RECEIVE TOP(1)
		@RecvReplyMsg = CAST(message_body AS xml)
		FROM SBM_DONE_QUEUE_INIT
		WHERE conversation_handle = @Handle
	), TIMEOUT @timeout;

	END CONVERSATION @Handle;

	SELECT @RecvReplyMsg;

	--COMMIT TRANSACTION;
END



GO
/****** Object:  StoredProcedure [dbo].[sp_received]    Script Date: 20/01/2017 17:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andres Castiglia
-- Create date: 27-feb-2016
-- Description:	lazy
-- =============================================
CREATE  PROCEDURE [dbo].[sp_received]
AS
DECLARE 
	@Handle UNIQUEIDENTIFIER,
	@RecvReqMsg varbinary(max),
	@RecvReqMsgName sysname,
	@xml xml
BEGIN
	SET NOCOUNT ON;
	SET ANSI_PADDING ON;

	WHILE (1=1)
	BEGIN
		BEGIN TRANSACTION;

		WAITFOR
			( RECEIVE TOP(1)
				@Handle = conversation_handle,
				@RecvReqMsg = message_body,
				@RecvReqMsgName = message_type_name
				FROM SBM_DONE_QUEUE_TARGET
			), TIMEOUT 5000;

		IF (@@ROWCOUNT = 0)
		BEGIN
			ROLLBACK TRANSACTION;
			BREAK;
		END

		IF @RecvReqMsgName = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog'

			END CONVERSATION @Handle;

		ELSE IF @RecvReqMsgName = N'http://schemas.microsoft.com/SQL/ServiceBroker/Error'

			END CONVERSATION @Handle;

		ELSE IF @RecvReqMsgName = N'//SBM/RequestMessage'
		BEGIN
	
			select @xml = cast(@RecvReqMsg as xml);

			INSERT INTO SBM_DISPATCHER (
				[ID_OWNER],
				[ID_SERVICE],
				[PARAMETERS],
				[ID_PRIVATE],
				[HANDLE],
				[REQUESTED])
			SELECT
				att.value('@id_owner', 'smallint'),
				att.value('@id_service', 'smallint'),
				att.value('@parameters', 'nvarchar(4000)'),
				att.value('@id_private', 'nvarchar(40)'),
				@Handle,
				SYSDATETIMEOFFSET()
			FROM
				@xml.nodes('/req') as req(att)
		   
			--DECLARE @ReplyMsg NVARCHAR(100);
			--SELECT @ReplyMsg = cast(@RecvReqMsg as nvarchar(max)); 
			--SEND ON CONVERSATION @Handle (@ReplyMsg);
		END
      
		COMMIT TRANSACTION;

	END
END



GO
/****** Object:  Trigger [dbo].[SBM_DONE_MESSAGE]    Script Date: 20/01/2017 17:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andres Castiglia
-- Create date: 27-Feb-2016
-- Description:	Lazy
-- =============================================
CREATE TRIGGER [dbo].[SBM_DONE_MESSAGE]
   ON  [dbo].[SBM_DONE]
   AFTER INSERT, UPDATE
AS  
DECLARE 
	@Handle UNIQUEIDENTIFIER,
	@ReplyMsg XML

BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF EXISTS (SELECT 1 FROM inserted WHERE [ENDED] IS NOT NULL AND [HANDLE] IS NOT NULL AND [HANDLE] != cast('00000000-0000-0000-0000-000000000000' as uniqueidentifier))
		BEGIN

			SELECT 
				@Handle = [HANDLE]
			FROM
				INSERTED;

			SET @ReplyMsg = (
				SELECT 
					*
				FROM
					INSERTED as res
				FOR XML AUTO); 
					
			SEND ON CONVERSATION @Handle 
				MESSAGE TYPE [//SBM/ReplyMessage]
				(@ReplyMsg)
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END



GO
ALTER TABLE [dbo].[SBM_DONE] ENABLE TRIGGER [SBM_DONE_MESSAGE]
GO
/****** Object:  Trigger [dbo].[SBM_DONE_TRIGGER]    Script Date: 20/01/2017 17:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[SBM_DONE_TRIGGER]
   ON [dbo].[SBM_DONE]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM
		SBM_DISPATCHER 
	WHERE
		SBM_DISPATCHER.ID_DISPATCHER IN (SELECT INSERTED.ID_DISPATCHER FROM INSERTED);
		
END



GO
ALTER TABLE [dbo].[SBM_DONE] ENABLE TRIGGER [SBM_DONE_TRIGGER]
GO
USE [master]
GO
ALTER DATABASE [SBM] SET  READ_WRITE 
GO
