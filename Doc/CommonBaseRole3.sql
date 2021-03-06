USE [master]
GO
/****** Object:  Database [CommonBaseRole]    Script Date: 2019/12/20 18:29:09 ******/
CREATE DATABASE [CommonBaseRole]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CommonBaseRole', FILENAME = N'D:\开发工具软件\SQL2014程序\MSSQL12.MSSQLSERVER\MSSQL\DATA\CommonBaseRole.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CommonBaseRole_log', FILENAME = N'D:\开发工具软件\SQL2014程序\MSSQL12.MSSQLSERVER\MSSQL\DATA\CommonBaseRole_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CommonBaseRole] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CommonBaseRole].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CommonBaseRole] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CommonBaseRole] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CommonBaseRole] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CommonBaseRole] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CommonBaseRole] SET ARITHABORT OFF 
GO
ALTER DATABASE [CommonBaseRole] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CommonBaseRole] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CommonBaseRole] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CommonBaseRole] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CommonBaseRole] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CommonBaseRole] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CommonBaseRole] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CommonBaseRole] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CommonBaseRole] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CommonBaseRole] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CommonBaseRole] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CommonBaseRole] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CommonBaseRole] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CommonBaseRole] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CommonBaseRole] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CommonBaseRole] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CommonBaseRole] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CommonBaseRole] SET RECOVERY FULL 
GO
ALTER DATABASE [CommonBaseRole] SET  MULTI_USER 
GO
ALTER DATABASE [CommonBaseRole] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CommonBaseRole] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CommonBaseRole] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CommonBaseRole] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CommonBaseRole] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CommonBaseRole', N'ON'
GO
USE [CommonBaseRole]
GO
/****** Object:  UserDefinedFunction [dbo].[f_GetMaxPage]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_GetMaxPage]
(
	-- Add the parameters for the function here
	@p_DataCount int, @p_PageSize int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	declare @MaxPage int, @ModVal int
	set @ModVal = @p_DataCount % @p_PageSize;
	set @MaxPage = floor( @p_DataCount / @p_PageSize + 1);

	if(@ModVal = 0)
	begin
	 set @MaxPage = @MaxPage - 1;
	end
	
	return @MaxPage;
	
END



GO
/****** Object:  Table [dbo].[AdminModule]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdminModule](
	[ModuleID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [varchar](20) NULL,
	[ModuleCode] [varchar](20) NULL,
	[ParentModuleID] [int] NULL,
	[MenuIcon] [varchar](20) NULL,
	[MenuTitle] [varchar](20) NULL,
	[MenuPath] [varchar](100) NULL,
	[SortIndex] [int] NULL,
	[IsUse] [int] NULL CONSTRAINT [DF__AdminModu__IsUse__145C0A3F]  DEFAULT ((1)),
	[IsButton] [int] NULL CONSTRAINT [DF_AdminModule_IsButton]  DEFAULT ((0)),
	[ValidFlag] [int] NULL CONSTRAINT [DF__AdminModu__Valid__15502E78]  DEFAULT ((1)),
	[CreateTime] [datetime] NULL,
	[CreateBy] [int] NULL,
	[LastUpdateTime] [datetime] NULL,
	[LastUpdateBy] [int] NULL,
 CONSTRAINT [PK__AdminMod__2B747787B174C141] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemRole]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemRole](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[RoleDesc] [nvarchar](1000) NULL,
	[AdminFlag] [int] NULL CONSTRAINT [DF__SystemRol__Admin__145C0A3F]  DEFAULT ((0)),
	[IsUse] [int] NULL CONSTRAINT [DF_SystemRole_IsUse]  DEFAULT ((1)),
	[ValidFlag] [int] NULL CONSTRAINT [DF__SystemRol__Valid__15502E78]  DEFAULT ((1)),
	[CreateTime] [datetime] NULL CONSTRAINT [DF__SystemRol__Creat__164452B1]  DEFAULT (getdate()),
	[CreateBy] [int] NULL,
	[LastUpdateTime] [datetime] NULL CONSTRAINT [DF__SystemRol__LastU__173876EA]  DEFAULT (getdate()),
	[LastUpdateBy] [int] NULL,
 CONSTRAINT [PK__SystemRo__8AFACE3A1273C1CD] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemRoleModule]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemRoleModule](
	[RoleMenuID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[ModuleID] [int] NULL,
	[ValidFlag] [int] NULL,
	[CreateTime] [datetime] NULL CONSTRAINT [DF__SystemRol__Creat__286302EC]  DEFAULT (getdate()),
	[CreateBy] [int] NULL,
	[LastUpdateTime] [datetime] NULL CONSTRAINT [DF__SystemRol__LastU__29572725]  DEFAULT (getdate()),
	[LastUpdateBy] [int] NULL,
 CONSTRAINT [PK__SystemRo__F8628796FAEE0363] PRIMARY KEY CLUSTERED 
(
	[RoleMenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemUser]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemUser](
	[UserID] [varchar](100) NOT NULL,
	[UserLoginName] [varchar](100) NOT NULL,
	[UserPassword] [varchar](1000) NOT NULL,
	[SystemUserLevel] [int] NULL,
	[Descripts] [varchar](100) NULL,
	[LoginTimes] [int] NULL,
	[LastLoginTime] [datetime] NULL,
	[LastLoginIP] [varchar](200) NULL,
	[IsUse] [int] NULL,
	[ValidFlag] [int] NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [int] NULL,
	[LastUpdateTime] [datetime] NULL,
	[LastUpdateBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemUserInfo]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemUserInfo](
	[InfoID] [varchar](100) NOT NULL,
	[UserID] [varchar](100) NOT NULL,
	[UserShowName] [varchar](100) NULL,
	[HeadPortrait] [varchar](200) NULL,
	[Phone] [varchar](20) NULL,
	[EMail] [varchar](100) NULL,
	[BirthDate] [date] NULL,
	[IDCard] [varchar](20) NULL,
	[QQ] [varchar](20) NULL,
	[WeChat] [varchar](20) NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [int] NULL,
	[LastUpdateTime] [datetime] NULL,
	[LastUpdateBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemUserRole]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemUserRole](
	[UserRoleID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](100) NULL,
	[RoleID] [int] NULL,
	[ValidFlag] [int] NULL,
	[CreateTime] [datetime] NULL CONSTRAINT [DF__SystemUse__Creat__2C3393D0]  DEFAULT (getdate()),
	[CreateBy] [int] NULL,
	[LastUpdateTime] [datetime] NULL CONSTRAINT [DF__SystemUse__LastU__2D27B809]  DEFAULT (getdate()),
	[LastUpdateBy] [int] NULL,
 CONSTRAINT [PK__SystemUs__3D978A55742ADEA0] PRIMARY KEY CLUSTERED 
(
	[UserRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AdminModule] ON 

INSERT [dbo].[AdminModule] ([ModuleID], [ModuleName], [ModuleCode], [ParentModuleID], [MenuIcon], [MenuTitle], [MenuPath], [SortIndex], [IsUse], [IsButton], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (1, N'系统设置', N'SystemSetting', 0, N'fa fa-gear', N'系统设置', NULL, 9, 1, NULL, 1, CAST(N'2019-10-11 15:33:16.613' AS DateTime), NULL, CAST(N'2019-10-11 15:33:16.613' AS DateTime), NULL)
INSERT [dbo].[AdminModule] ([ModuleID], [ModuleName], [ModuleCode], [ParentModuleID], [MenuIcon], [MenuTitle], [MenuPath], [SortIndex], [IsUse], [IsButton], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (2, N'菜单管理', N'MenuListPage', 1, N'fa fa-navicon', N'菜单管理', N'/System/MenuListPage', 0, 1, NULL, 1, CAST(N'2019-10-11 16:03:51.693' AS DateTime), 0, CAST(N'2019-10-29 18:12:37.280' AS DateTime), 1)
INSERT [dbo].[AdminModule] ([ModuleID], [ModuleName], [ModuleCode], [ParentModuleID], [MenuIcon], [MenuTitle], [MenuPath], [SortIndex], [IsUse], [IsButton], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (3, N'用户管理', N'SystemUserManage', 1, N'fa fa-user', N'用户管理', N'/User/SystemUserListPage', 8, 1, NULL, 1, CAST(N'2019-10-18 15:36:59.623' AS DateTime), 0, CAST(N'2019-11-06 18:43:36.383' AS DateTime), 1)
INSERT [dbo].[AdminModule] ([ModuleID], [ModuleName], [ModuleCode], [ParentModuleID], [MenuIcon], [MenuTitle], [MenuPath], [SortIndex], [IsUse], [IsButton], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (4, N'角色管理', N'SystemRoleManage', 1, N'fa fa-user-md', N'角色管理', N'/System/SystemRoleListPage', 5, 1, NULL, 1, CAST(N'2019-10-21 18:58:31.230' AS DateTime), NULL, CAST(N'2019-10-21 18:58:31.230' AS DateTime), NULL)
INSERT [dbo].[AdminModule] ([ModuleID], [ModuleName], [ModuleCode], [ParentModuleID], [MenuIcon], [MenuTitle], [MenuPath], [SortIndex], [IsUse], [IsButton], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (5, N'功能项管理', N'SystemFunctionManage', 1, N'fa fa-sliders', N'功能项管理', N'/System/SystemFunctionListPage', 3, 1, NULL, 1, CAST(N'2019-10-23 10:06:31.917' AS DateTime), NULL, CAST(N'2019-10-23 10:06:31.917' AS DateTime), NULL)
INSERT [dbo].[AdminModule] ([ModuleID], [ModuleName], [ModuleCode], [ParentModuleID], [MenuIcon], [MenuTitle], [MenuPath], [SortIndex], [IsUse], [IsButton], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (6, N'资源列表', N'ResourceList', 1, NULL, NULL, N'/Resource/ResourceFileListPage', 10, 1, NULL, 1, CAST(N'2019-11-06 15:53:52.447' AS DateTime), 1, CAST(N'2019-11-06 15:54:02.950' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[AdminModule] OFF
SET IDENTITY_INSERT [dbo].[SystemRole] ON 

INSERT [dbo].[SystemRole] ([RoleID], [RoleName], [RoleDesc], [AdminFlag], [IsUse], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (1, N'超级管理员', N'拥有一切权限', 1, 1, 1, CAST(N'2019-12-09 16:49:07.120' AS DateTime), NULL, CAST(N'2019-12-09 16:49:07.120' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[SystemRole] OFF
SET IDENTITY_INSERT [dbo].[SystemRoleModule] ON 

INSERT [dbo].[SystemRoleModule] ([RoleMenuID], [RoleID], [ModuleID], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (1, 1, 1, 1, CAST(N'2019-12-13 17:32:11.957' AS DateTime), NULL, CAST(N'2019-12-13 17:32:11.957' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[SystemRoleModule] OFF
INSERT [dbo].[SystemUser] ([UserID], [UserLoginName], [UserPassword], [SystemUserLevel], [Descripts], [LoginTimes], [LastLoginTime], [LastLoginIP], [IsUse], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (N'8CA4551D-F77C-4A97-820A-3E350EDBCC5F', N'Admin', N'728AD9902AECBA32E22F', 1, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SystemUserRole] ON 

INSERT [dbo].[SystemUserRole] ([UserRoleID], [UserID], [RoleID], [ValidFlag], [CreateTime], [CreateBy], [LastUpdateTime], [LastUpdateBy]) VALUES (1, N'8CA4551D-F77C-4A97-820A-3E350EDBCC5F', 1, NULL, CAST(N'2019-12-09 16:49:44.967' AS DateTime), NULL, CAST(N'2019-12-09 16:49:44.967' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[SystemUserRole] OFF
/****** Object:  StoredProcedure [dbo].[sp_GetSystemUserRoles]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GetSystemUserRoles]
@p_CurrentPage	INT = 1,
	@p_PageSize		INT = 1,
    @p_Condition	NVARCHAR(4000) = '',
    @p_Order		NVARCHAR(4000) = '',
    @p_DataCount	INT OUTPUT,
    @p_MaxPage		INT OUTPUT
	as
	BEGIN
	DECLARE @startRow INT, @endRow INT, @m_sql NVARCHAR(4000), @totalcount INT;

    SET @startRow = (@p_CurrentPage - 1) * @p_PageSize +1;
    SET @endRow = @startRow + @p_PageSize -1;

	SET @m_sql = 'select @a=count(*)
	from SystemUser su
	left join SystemUserInfo sui on su.UserID=sui.UserID
	left join SystemUserRole sur on sur.UserID=su.UserID
	left join SystemRole sr on sur.RoleID=sur.RoleID
	WHERE 1 > 0 ' + @p_Condition;
	PRINT @m_sql;
	EXEC sp_executesql @m_sql,N'@a INT OUTPUT',@p_DataCount OUTPUT;
	print @p_DataCount;
	print @p_PageSize;
	print @p_MaxPage;
	SET @p_MaxPage = dbo.f_GetMaxPage(@p_DataCount, @p_PageSize);
	
	declare @char varchar(50);
	SET @char = ',';
	SET @m_sql = 
	'SELECT s.*
		FROM
		(SELECT t.*
			FROM
			(SELECT top 100 PERCENT su.[UserID]
				,ROW_NUMBER() over(ORDER BY ' + @p_Order + ' su.[UserID]) rn
				,su.[UserLoginName]
				,su.[UserPassword]
				,su.[SystemUserLevel]
				,su.[Descripts]
				,su.[LoginTimes]
				,su.[LastLoginTime]
				,su.[LastLoginIP]
				,su.[IsUse]
				,su.[CreateTime]
				,su.[CreateBy]
				,su.[LastUpdateTime]
				,su.[LastUpdateBy]
				,sui.[InfoID]
				,sui.[UserShowName]
				,sui.[HeadPortrait]
				,sui.[Phone]
				,sui.[EMail]
				,sui.[BirthDate]
				,sui.[IDCard]
				,sui.[QQ]
				,sui.[WeChat]
				,sr.[RoleID]
				,sr.[RoleName]
				,sr.[RoleDesc]
				,sr.[AdminFlag]
			from SystemUser su
			left join SystemUserInfo sui on su.UserID=sui.UserID
			left join SystemUserRole sur on sur.UserID=su.UserID
			left join SystemRole sr on sur.RoleID=sur.RoleID
			WHERE 1 > 0 ' + @p_Condition + ') t
		WHERE t.rn <= ' + CONVERT(NVARCHAR(200), (@endRow)) + ') s
	WHERE s.rn >= ' + CONVERT(NVARCHAR(200), (@startRow));

	PRINT @m_sql;

	EXEC(@m_sql);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSystemUsers]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GetSystemUsers]
@p_CurrentPage	INT = 1,
	@p_PageSize		INT = 1,
    @p_Condition	NVARCHAR(4000) = '',
    @p_Order		NVARCHAR(4000) = '',
    @p_DataCount	INT OUTPUT,
    @p_MaxPage		INT OUTPUT
	as
	BEGIN
	DECLARE @startRow INT, @endRow INT, @m_sql NVARCHAR(4000), @totalcount INT;

    SET @startRow = (@p_CurrentPage - 1) * @p_PageSize +1;
    SET @endRow = @startRow + @p_PageSize -1;

	SET @m_sql = 'select @a=count(*)
	from SystemUser su
	left join SystemUserInfo sui on su.UserID=sui.UserID
	WHERE 1 > 0 ' + @p_Condition;
	PRINT @m_sql;
	EXEC sp_executesql @m_sql,N'@a INT OUTPUT',@p_DataCount OUTPUT;
	print @p_DataCount;
	print @p_PageSize;
	print @p_MaxPage;
	SET @p_MaxPage = dbo.f_GetMaxPage(@p_DataCount, @p_PageSize);
	
	declare @char varchar(50);
	SET @char = ',';
	SET @m_sql = 
	'SELECT s.*
		FROM
		(SELECT t.*
			FROM
			(SELECT top 100 PERCENT su.[UserID]
				,ROW_NUMBER() over(ORDER BY ' + @p_Order + ' su.[UserID]) rn
				,su.[UserLoginName]
				,su.[SystemUserLevel]
				,su.[Descripts]
				,su.[LoginTimes]
				,su.[LastLoginTime]
				,su.[LastLoginIP]
				,su.[IsUse]
				,su.[CreateTime]
				,su.[CreateBy]
				,su.[LastUpdateTime]
				,su.[LastUpdateBy]
				,sui.[InfoID]
				,sui.[UserShowName]
				,sui.[HeadPortrait]
				,sui.[Phone]
				,sui.[EMail]
				,sui.[BirthDate]
				,sui.[IDCard]
				,sui.[QQ]
				,sui.[WeChat]
			from SystemUser su
			left join SystemUserInfo sui on su.UserID=sui.UserID
			WHERE 1 > 0 ' + @p_Condition + ') t
		WHERE t.rn <= ' + CONVERT(NVARCHAR(200), (@endRow)) + ') s
	WHERE s.rn >= ' + CONVERT(NVARCHAR(200), (@startRow));

	PRINT @m_sql;

	EXEC(@m_sql);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTablePageData]    Script Date: 2019/12/20 18:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTablePageData]
	-- Add the parameters for the stored procedure here
	@p_CurrentPage as int = 1,
	@p_PageSize    as int = 1,
    @p_Condition   as varchar(4000) = '',
    @p_Order       varchar(4000) = '',
    @p_DataCount int   output,
    @p_MaxPage     int output,
	@p_TableName as varchar(4000),
	@p_KeyField as varchar(40) = 'id'
AS
BEGIN
	declare @startRow int, @endRow int, @m_sql nvarchar(4000), @totalcount int;

    set @startRow = (@p_CurrentPage - 1) * @p_PageSize +1;
    set @endRow = @startRow + @p_PageSize -1;

	set @m_sql = 'select @a = count(*) from ' + @p_TableName + ' s where 1 > 0 ' + @p_Condition;
	print @m_sql;
	exec sp_executesql @m_sql,N'@a int output',@p_DataCount output;

	set @p_MaxPage = dbo.f_GetMaxPage(@p_DataCount, @p_PageSize);

	set @m_sql = 
	'select s.rn, x.*
		from
		(select t.*
			from
			(select top 100 percent ' + @p_KeyField + ', row_number() over(order by ' + @p_Order +  ' s.' + @p_KeyField + ' asc) rn
				from ' + @p_TableName + ' s
			where 1 > 0 ' + @p_Condition + ') t
		where t.rn <= ' + convert(varchar(200), (@endRow)) + ') s
		inner join  ' + @p_TableName + ' x on x.' + @p_KeyField + ' = s.' + @p_KeyField + '
	where s.rn >= ' + convert(varchar(200), (@startRow));

	print @m_sql;

	exec(@m_sql);

END







GO
USE [master]
GO
ALTER DATABASE [CommonBaseRole] SET  READ_WRITE 
GO
