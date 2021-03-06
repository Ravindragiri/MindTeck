USE [Eatery]
GO
/****** Object:  StoredProcedure [dbo].[SP_SearchTables]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SearchTables] 
 @Tablenames VARCHAR(500) 
,@SearchStr NVARCHAR(500) 
,@GenerateSQLOnly Bit = 0 
,@SchemaNames VARCHAR(500) ='%' 
,@SearchCollation SYSNAME = '' 
AS 
 
/* 
    Parameters and usage 
 
    @Tablenames        -- Provide a single table name or multiple table name with comma seperated.  
                        If left blank , it will check for all the tables in the database 
                        Provide wild card tables names with comma seperated 
                        EX :'%tbl%,Dim%' -- This will search the table having names comtains "tbl" and starts with "Dim" 
                             
    @SearchStr        -- Provide the search string. Use the '%' to coin the search. Also can provide multiple search with comma seperated 
                        EX : X%--- will give data staring with X 
                             %X--- will give data ending with X 
                             %X%--- will give data containig  X 
                             %X%,Y%--- will give data containig  X or starting with Y 
                             %X%,%,,% -- Use a double comma to search comma in the data 
    @GenerateSQLOnly -- Provide 1 if you only want to generate the SQL statements without seraching the database.  
                        By default it is 0 and it will search. 
 
    @SchemaNames    -- Provide a single Schema name or multiple Schema name with comma seperated.  
                        If left blank , it will check for all the tables in the database 
                        Provide wild card Schema names with comma seperated 
                        EX :'%dbo%,Sales%' -- This will search the Schema having names comtains "dbo" and starts with "Sales" 
     
    @SearchCollation -- Provide a valid collation to be used for searching. 
                        If left blank , database default collation will be used. 
                        EX : 'sql_latin1_general_cp1_cs_as' -- This will do a case sensitive search as "cs_as" collation has been provided. 
 
    Samples : 
 
    1. To search data in a table 
 
        EXEC SP_SearchTables @Tablenames = 'T1' 
                         ,@SearchStr  = '%TEST%' 
 
        The above sample searches in table T1 with string containing TEST. 
 
    2. To search in a multiple table 
 
        EXEC SP_SearchTables @Tablenames = 'T2' 
                         ,@SearchStr  = '%TEST%' 
 
        The above sample searches in tables T1 & T2 with string containing TEST. 
     
    3. To search in a all table 
 
        EXEC SP_SearchTables @Tablenames = '%' 
                         ,@SearchStr  = '%TEST%' 
 
        The above sample searches in all table with string containing TEST. 
 
    4. Generate the SQL for the Select statements 
 
        EXEC SP_SearchTables @Tablenames        = 'T1' 
                         ,@SearchStr        = '%TEST%' 
                         ,@GenerateSQLOnly    = 1 
 
    5. To Search in tables with specfic name 
 
        EXEC SP_SearchTables @Tablenames        = '%T1%' 
                         ,@SearchStr        = '%TEST%' 
                         ,@GenerateSQLOnly    = 0 
 
    6. To Search in multiple tables with specfic names 
 
        EXEC SP_SearchTables @Tablenames        = '%T1%,Dim%' 
                         ,@SearchStr        = '%TEST%' 
                         ,@GenerateSQLOnly    = 0 
     
    7. To specify multiple search strings 
 
        EXEC SP_SearchTables @Tablenames        = '%T1%,Dim%' 
                         ,@SearchStr        = '%TEST%,TEST1%,%TEST2' 
                         ,@GenerateSQLOnly    = 0 
 
 
    8. To search comma itself in the tables use double comma ",," 
 
        EXEC SP_SearchTables @Tablenames        = '%T1%,Dim%' 
                         ,@SearchStr        = '%,,%' 
                         ,@GenerateSQLOnly    = 0 
 
        EXEC SP_SearchTables @Tablenames        = '%T1%,Dim%' 
                         ,@SearchStr        = '%with,,comma%' 
                         ,@GenerateSQLOnly    = 0 
 
    9. To Search by SchemaName 
 
        EXEC SP_SearchTables @Tablenames        = '%T1%,Dim%' 
                             ,@SearchStr        = '%,,%' 
                             ,@GenerateSQLOnly    = 0 
                             ,@SchemaNames        = '%dbo%,Sales%' 
 
    10. To search using a Collation 
 
        EXEC SP_SearchTables @Tablenames        = '%T1%,Dim%' 
                             ,@SearchStr        = '%,,%' 
                             ,@GenerateSQLOnly    = 0 
                             ,@SchemaNames        = '%dbo%,Sales%' 
                             ,@SearchCollation    = 'sql_latin1_general_cp1_cs_as' 
 
*/ 
 
    SET NOCOUNT ON 
 
    DECLARE @MatchFound BIT 
 
    SELECT @MatchFound = 0 
 
    DECLARE @CheckTableNames Table 
    ( 
    Schemaname sysname 
    ,Tablename sysname 
    ) 
 
    DECLARE @SearchStringTbl TABLE 
    ( 
    SearchString VARCHAR(500) 
    ) 
 
    DECLARE @SQLTbl TABLE 
    ( 
     Tablename        SYSNAME 
    ,WHEREClause    NVARCHAR(MAX) 
    ,SQLStatement   NVARCHAR(MAX) 
    ,Execstatus        BIT  
    ) 
 
    DECLARE @SQL NVARCHAR(MAX) 
    DECLARE @TableParamSQL VARCHAR(MAX) 
    DECLARE @SchemaParamSQL VARCHAR(MAX) 
    DECLARE @TblSQL VARCHAR(MAX) 
    DECLARE @tmpTblname sysname 
    DECLARE @ErrMsg NVARCHAR(MAX) 
 
 
     
    IF LTRIM(RTRIM(@Tablenames)) = '' 
    BEGIN 
 
        SELECT @Tablenames = '%' 
    END 
 
    IF LTRIM(RTRIM(@SchemaNames)) ='' 
    BEGIN 
 
        SELECT @SchemaNames = '%' 
    END 
 
    IF CHARINDEX(',',@Tablenames) > 0  
        SELECT @TableParamSQL = 'SELECT ''' + REPLACE(@Tablenames,',','''as TblName UNION SELECT ''') + '''' 
    ELSE 
        SELECT @TableParamSQL = 'SELECT ''' + @Tablenames + ''' as TblName ' 
 
    IF CHARINDEX(',',@SchemaNames) > 0  
        SELECT @SchemaParamSQL = 'SELECT ''' + REPLACE(@SchemaNames,',','''as SchemaName UNION SELECT ''') + '''' 
    ELSE 
        SELECT @SchemaParamSQL = 'SELECT ''' + @SchemaNames + ''' as SchemaName ' 
 
 
 
        SELECT @TblSQL = 'SELECT SCh.NAME,T.NAME 
                            FROM SYS.TABLES T 
                            JOIN SYS.SCHEMAS SCh 
                               ON SCh.SCHEMA_ID = T.SCHEMA_ID 
                            JOIN (' + @TableParamSQL + ') tblsrc 
                             ON T.name LIKE tblsrc.tblname  
                            JOIN (' + @SchemaParamSQL + ') schemasrc 
                             ON SCh.name LIKE schemasrc.SchemaName  
                              
                             ' 
         
        INSERT INTO @CheckTableNames 
        (Schemaname,Tablename) 
        EXEC(@TblSQL) 
 
 
    IF NOT EXISTS(SELECT 1 FROM @CheckTableNames) 
    BEGIN 
         
        SELECT @ErrMsg = 'No tables are found in this database ' + DB_NAME() + ' for the specified filter' 
        PRINT @ErrMsg 
        RETURN 
 
    END 
 
    IF LTRIM(RTRIM(@SearchCollation)) <> '' 
    BEGIN 
        IF NOT EXISTS ( 
                    SELECT 1 FROM SYS.fn_helpcollations() 
                    WHERE UPPER(NAME) = UPPER(@SearchCollation) 
                 ) 
        BEGIN  
                SELECT @ErrMsg = 'Invalid Collation (' + @SearchCollation + ').Please specify a valid collation or specify Blank to work with Default Collation.' 
                PRINT @ErrMsg 
                RETURN 
        END 
    END 
 
 
    IF LTRIM(RTRIM(@SearchStr)) ='' 
    BEGIN 
 
        SELECT @ErrMsg = 'Please specify the search string in @SearchStr Parameter' 
        PRINT @ErrMsg 
        RETURN 
    END 
    ELSE 
    BEGIN  
        SELECT @SearchStr = REPLACE(@SearchStr,',,,',',#DOUBLECOMMA#') 
        SELECT @SearchStr = REPLACE(@SearchStr,',,','#DOUBLECOMMA#') 
 
        SELECT @SearchStr = REPLACE(@SearchStr,'''','''''') 
 
        SELECT @SQL = 'SELECT N''' + REPLACE(@SearchStr,',','''as SearchString UNION SELECT ''') + '''' 
 
         
 
        INSERT INTO @SearchStringTbl 
        (SearchString) 
        EXEC(@SQL) 
 
        UPDATE @SearchStringTbl 
           SET SearchString = REPLACE(SearchString ,'#DOUBLECOMMA#',',') 
    END 
 
     
     
    INSERT INTO @SQLTbl 
    ( Tablename,WHEREClause) 
    SELECT QUOTENAME(SCh.name) + '.' + QUOTENAME(ST.NAME), 
            ( 
                SELECT '[' + SC.Name + ']' + ' LIKE N''' + REPLACE(SearchSTR.SearchString,'''','''''') + ''' OR ' + CHAR(10) 
                  FROM SYS.columns SC 
                  JOIN SYS.types STy 
                    ON STy.system_type_id = SC.system_type_id 
                   AND STy.user_type_id =SC.user_type_id 
                  CROSS JOIN @SearchStringTbl SearchSTR 
                 WHERE STY.name in ('varchar','char','nvarchar','nchar','text') 
                   AND SC.object_id = ST.object_id 
                 ORDER BY SC.name 
                FOR XML PATH('') 
            ) 
      FROM  SYS.tables ST 
      JOIN @CheckTableNames chktbls 
        ON chktbls.Tablename = ST.name  
      JOIN SYS.schemas SCh 
        ON ST.schema_id = SCh.schema_id 
       AND Sch.name        = chktbls.Schemaname 
     WHERE ST.name <> 'SearchTMP' 
      GROUP BY ST.object_id, QUOTENAME(SCh.name) + '.' +  QUOTENAME(ST.NAME) ; 
     
 
      UPDATE @SQLTbl 
         SET SQLStatement = 'SELECT * INTO SearchTMP FROM ' + Tablename + ' WHERE ' + substring(WHEREClause,1,len(WHEREClause)-5) 
 
 
          
      DELETE FROM @SQLTbl 
       WHERE WHEREClause IS NULL 
     
    WHILE EXISTS (SELECT 1 FROM @SQLTbl WHERE ISNULL(Execstatus ,0) = 0) 
    BEGIN 
 
        SELECT TOP 1 @tmpTblname = Tablename , @SQL = SQLStatement 
          FROM @SQLTbl  
         WHERE ISNULL(Execstatus ,0) = 0 
 
         IF LTRIM(RTRIM(@SearchCollation)) <> '' 
         BEGIN 
            SELECT @SQL = @SQL + CHAR(13) + ' COLLATE ' + @SearchCollation 
         END  
 
 
         IF @GenerateSQLOnly = 0 
         BEGIN 
 
            IF OBJECT_ID('SearchTMP','U') IS NOT NULL 
                DROP TABLE SearchTMP 
                 
            EXEC (@SQL) 
 
            IF EXISTS(SELECT 1 FROM SearchTMP) 
            BEGIN 
                SELECT Tablename=@tmpTblname,* FROM SearchTMP 
                SELECT @MatchFound = 1 
            END 
 
         END 
         ELSE 
         BEGIN 
             PRINT REPLICATE('-',100) 
             PRINT @tmpTblname 
             PRINT REPLICATE('-',100) 
             PRINT replace(@SQL,'INTO SearchTMP','') 
         END 
 
         UPDATE @SQLTbl 
            SET Execstatus = 1 
          WHERE Tablename = @tmpTblname 
 
    END 
 
    IF @MatchFound = 0  
    BEGIN 
        SELECT @ErrMsg = 'No Matches are found in this database ' + DB_NAME() + ' for the specified filter' 
        PRINT @ErrMsg 
        RETURN 
    END 
     
    SET NOCOUNT OFF 
 

GO
/****** Object:  StoredProcedure [dbo].[spGetNearLocations]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetNearLocations]
    @latitude decimal(18,14),
    @longtitude decimal(18,14),
    @distance decimal(18,4),
	@userType int   
AS
BEGIN
    SET NOCOUNT ON;
    -- @p1 is the point you want to calculate the distance from which is passed as parameters
    declare @p1 geography = geography::Point(@latitude,@longtitude, 4326);
 
    SELECT *, @p1.STDistance(geography::Point([Latitude], [Longitude], 4326)) as [DistanceInKilometers]
    FROM [Users]
    WHERE @p1.STDistance(geography::Point([Latitude], [Longitude], 4326)) < @distance
    AND UserType = @userType
		
END
GO
/****** Object:  StoredProcedure [dbo].[spGetNearRestaurants]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetNearRestaurants]
    @latitude decimal(18,14),
    @longtitude decimal(18,14),
    @distance decimal(18,4),
	@userType int   
AS
BEGIN
    SET NOCOUNT ON;
    -- @p1 is the point you want to calculate the distance from which is passed as parameters
    declare @p1 geography = geography::Point(@latitude,@longtitude, 4326);
 
    SELECT 
		u.ID as UserID,
		u.FirstName,
		u.PhoneNumber,
		u.CountryCode,
		u.Latitude,
		u.Longitude,
		u.Email,
		r.ID as ServiceProviderID,
		r.Title,
		r.JobDescription,
		r.Experience,
		r.ExpectedWages,
		r.Province,
		r.City,
		r.Address,
		r.PinCode,
		@p1.STDistance(geography::Point(r.[Latitude], r.[Longitude], 4326)) as [DistanceInKilometers]
    FROM 
		[Users] u INNER JOIN 
		dbo.Restaurants r ON u.ID = r.UserID
    WHERE 
		@p1.STDistance(geography::Point(r.[Latitude], r.[Longitude], 4326)) < @distance
		
END
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Name] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Consumers]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Consumers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[State] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[PinCode] [varchar](50) NULL,
 CONSTRAINT [PK_Consumer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MenuItemRatings]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuItemRatings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RatingValue] [int] NULL,
	[MenuItemID] [int] NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuItems]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MenuItems](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RestaurantID] [int] NULL,
	[Title] [varchar](150) NULL,
	[Description] [varchar](500) NULL,
	[Rating] [int] NULL,
	[Price] [money] NULL,
	[IsPublished] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RestaurantOperationTimings]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RestaurantOperationTimings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RestaurantID] [int] NULL,
	[DayOfWeek] [int] NULL,
	[TimeOpen] [varchar](50) NULL,
	[Timeclosed] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_RestaurantOperationTimings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RestaurantRatings]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestaurantRatings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RatingValue] [int] NULL,
	[RestaurantID] [int] NULL,
 CONSTRAINT [PK_RestaurantRating] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Restaurants](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[Description] [varchar](150) NULL,
	[Rating] [int] NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Province] [varchar](50) NULL,
	[PinCode] [varchar](10) NULL,
	[Latitude] [decimal](11, 8) NULL,
	[Longitude] [decimal](11, 8) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_ServiceProvider] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/11/2020 06:14:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NULL,
	[UserName] [varchar](50) NULL,
	[UserType] [int] NULL,
	[Password] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](250) NULL,
	[PasswordSalt] [varchar](250) NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
	[CountryCode] [varchar](15) NULL,
	[Latitude] [decimal](11, 8) NULL,
	[Longitude] [decimal](11, 8) NULL,
	[Email] [varchar](256) NULL,
	[DateOfBirth] [date] NULL,
	[Country] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

GO
INSERT [dbo].[Categories] ([ID], [Code], [Name]) VALUES (1, N'C1', N'Category 1')
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Consumers] ON 

GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (1, 114, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (2, 115, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (3, 116, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (4, 117, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (5, 118, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (6, 119, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (7, 120, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (8, 121, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (9, 122, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (10, 123, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (11, 124, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (12, 125, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (13, 126, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (14, 127, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (15, 128, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (16, 129, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (17, 130, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (18, 131, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (19, 132, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (20, 133, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (21, 134, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (22, 135, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (23, 136, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (24, 137, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (25, 138, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (26, 139, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (27, 140, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (28, 141, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (29, 142, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (30, 143, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (31, 144, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (32, 145, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (33, 146, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (34, 147, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (35, 148, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (36, 149, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (37, 150, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (38, 151, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (39, 152, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (40, 153, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (41, 154, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (42, 155, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (43, 156, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (44, 157, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (45, 158, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (46, 159, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (47, 160, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (48, 161, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (49, 162, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (50, 163, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (51, 164, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (52, 165, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (53, 166, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (54, 167, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (55, 168, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (56, 169, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (57, 170, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (58, 171, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (59, 172, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (60, 173, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (61, 174, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (62, 175, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (63, 176, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (64, 177, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (65, 178, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (66, 179, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (67, 180, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (68, 181, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (69, 182, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (70, 183, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (71, 184, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (72, 185, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (73, 186, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (74, 187, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (75, 188, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (76, 189, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (77, 190, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (78, 191, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (79, 192, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (80, 193, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (81, 194, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (82, 195, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (83, 196, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (84, 197, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (85, 198, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (86, 199, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (87, 200, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (88, 201, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (89, 202, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (90, 203, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (91, 204, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (92, 205, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (93, 206, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (94, 207, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (95, 208, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (96, 209, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (97, 210, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (98, 211, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (99, 212, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (100, 213, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Consumers] OFF
GO
SET IDENTITY_INSERT [dbo].[MenuItems] ON 

GO
INSERT [dbo].[MenuItems] ([ID], [RestaurantID], [Title], [Description], [Rating], [Price], [IsPublished], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, 8, N'Paneer Tikka', N'Paneer Tikka', NULL, NULL, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MenuItems] ([ID], [RestaurantID], [Title], [Description], [Rating], [Price], [IsPublished], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, 8, N'Chole Bhature', N'Chole Bhature', NULL, NULL, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MenuItems] ([ID], [RestaurantID], [Title], [Description], [Rating], [Price], [IsPublished], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, 8, N'Masala Channa', N'Masala Channa', NULL, NULL, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MenuItems] ([ID], [RestaurantID], [Title], [Description], [Rating], [Price], [IsPublished], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (4, 8, N'Dal Makhani', N'Dal Makhani', NULL, NULL, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MenuItems] ([ID], [RestaurantID], [Title], [Description], [Rating], [Price], [IsPublished], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, 8, N'Dhaba Dal', N'Dhaba Dal', NULL, NULL, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[MenuItems] ([ID], [RestaurantID], [Title], [Description], [Rating], [Price], [IsPublished], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (6, 0, N'Sarson ka Saag', NULL, NULL, NULL, 1, CAST(N'2020-11-02 16:30:05.803' AS DateTime), 12, CAST(N'2020-11-02 18:11:54.720' AS DateTime), 12)
GO
SET IDENTITY_INSERT [dbo].[MenuItems] OFF
GO
SET IDENTITY_INSERT [dbo].[RestaurantOperationTimings] ON 

GO
INSERT [dbo].[RestaurantOperationTimings] ([ID], [RestaurantID], [DayOfWeek], [TimeOpen], [Timeclosed], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (1, 117, 1, N'10am', N'10pm', CAST(N'2020-11-02 13:54:35.927' AS DateTime), 12, NULL, NULL)
GO
INSERT [dbo].[RestaurantOperationTimings] ([ID], [RestaurantID], [DayOfWeek], [TimeOpen], [Timeclosed], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (2, 117, 2, N'10am', N'10pm', CAST(N'2020-11-02 13:54:41.583' AS DateTime), 12, NULL, NULL)
GO
INSERT [dbo].[RestaurantOperationTimings] ([ID], [RestaurantID], [DayOfWeek], [TimeOpen], [Timeclosed], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (3, 117, 3, N'10am', N'10pm', CAST(N'2020-11-02 13:54:43.690' AS DateTime), 12, NULL, NULL)
GO
INSERT [dbo].[RestaurantOperationTimings] ([ID], [RestaurantID], [DayOfWeek], [TimeOpen], [Timeclosed], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (4, 117, 4, N'10am', N'10pm', CAST(N'2020-11-02 13:54:50.767' AS DateTime), 12, NULL, NULL)
GO
INSERT [dbo].[RestaurantOperationTimings] ([ID], [RestaurantID], [DayOfWeek], [TimeOpen], [Timeclosed], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (5, 117, 5, N'10am', N'10pm', CAST(N'2020-11-02 13:54:51.847' AS DateTime), 12, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[RestaurantOperationTimings] OFF
GO
SET IDENTITY_INSERT [dbo].[Restaurants] ON 

GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (8, 12, N'Restaurant 8', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (9, 14, N'Restaurant 9', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (10, 15, N'Restaurant 10', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (11, 16, N'Restaurant 11', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (12, 17, N'Restaurant 12', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.19272833 AS Decimal(11, 8)), CAST(103.82373871 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (13, 18, N'Restaurant 13', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (14, 19, N'Restaurant 14', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25011511 AS Decimal(11, 8)), CAST(103.90623428 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (15, 20, N'Restaurant 15', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44261881 AS Decimal(11, 8)), CAST(103.89103538 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (16, 21, N'Restaurant 16', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31553288 AS Decimal(11, 8)), CAST(103.74009211 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (17, 22, N'Restaurant 17', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40592937 AS Decimal(11, 8)), CAST(103.64249514 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (18, 23, N'Restaurant 18', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41993126 AS Decimal(11, 8)), CAST(103.84888449 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (19, 24, N'Restaurant 19', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46068936 AS Decimal(11, 8)), CAST(103.78114420 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (20, 25, N'Restaurant 20', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41831340 AS Decimal(11, 8)), CAST(103.97510895 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (21, 26, N'Restaurant 21', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22163845 AS Decimal(11, 8)), CAST(103.89643681 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (22, 27, N'Restaurant 22', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28526724 AS Decimal(11, 8)), CAST(103.79201028 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (23, 28, N'Restaurant 23', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41953412 AS Decimal(11, 8)), CAST(103.94708372 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (24, 29, N'Restaurant 24', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18106905 AS Decimal(11, 8)), CAST(103.75069463 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (25, 30, N'Restaurant 25', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32227363 AS Decimal(11, 8)), CAST(103.63587108 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (26, 31, N'Restaurant 26', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (27, 32, N'Restaurant 27', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46093731 AS Decimal(11, 8)), CAST(104.07640525 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (28, 33, N'Restaurant 28', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.45769511 AS Decimal(11, 8)), CAST(103.87404491 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (29, 34, N'Restaurant 29', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18541278 AS Decimal(11, 8)), CAST(103.85239312 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (30, 35, N'Restaurant 30', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.36429830 AS Decimal(11, 8)), CAST(103.96979685 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (31, 36, N'Restaurant 31', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34684671 AS Decimal(11, 8)), CAST(103.79950778 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (32, 37, N'Restaurant 32', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22487852 AS Decimal(11, 8)), CAST(103.85890199 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (33, 38, N'Restaurant 33', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17981108 AS Decimal(11, 8)), CAST(103.89998519 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (34, 39, N'Restaurant 34', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35894004 AS Decimal(11, 8)), CAST(103.90024795 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (35, 40, N'Restaurant 35', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17887209 AS Decimal(11, 8)), CAST(104.07640756 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (36, 41, N'Restaurant 36', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35449174 AS Decimal(11, 8)), CAST(103.81520640 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (37, 42, N'Restaurant 37', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26875677 AS Decimal(11, 8)), CAST(103.97542928 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (38, 43, N'Restaurant 38', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26502879 AS Decimal(11, 8)), CAST(103.87230513 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (39, 44, N'Restaurant 39', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38631678 AS Decimal(11, 8)), CAST(103.94318642 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (40, 45, N'Restaurant 40', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32125776 AS Decimal(11, 8)), CAST(103.75549026 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (41, 46, N'Restaurant 41', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31542410 AS Decimal(11, 8)), CAST(103.93298565 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (42, 47, N'Restaurant 42', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30413397 AS Decimal(11, 8)), CAST(103.77902536 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (43, 48, N'Restaurant 43', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20824078 AS Decimal(11, 8)), CAST(103.70336211 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (44, 49, N'Restaurant 44', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39324790 AS Decimal(11, 8)), CAST(104.01490449 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (45, 50, N'Restaurant 45', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24722367 AS Decimal(11, 8)), CAST(103.93230100 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (46, 51, N'Restaurant 46', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44596866 AS Decimal(11, 8)), CAST(104.06984106 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (47, 52, N'Restaurant 47', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33916158 AS Decimal(11, 8)), CAST(103.97660834 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (48, 53, N'Restaurant 48', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25309238 AS Decimal(11, 8)), CAST(103.95040257 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (49, 54, N'Restaurant 49', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29544031 AS Decimal(11, 8)), CAST(103.69872029 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (50, 55, N'Restaurant 50', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38175284 AS Decimal(11, 8)), CAST(103.60194207 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (51, 56, N'Restaurant 51', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35595497 AS Decimal(11, 8)), CAST(103.81284033 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (52, 57, N'Restaurant 52', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.37627680 AS Decimal(11, 8)), CAST(103.69001311 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (53, 58, N'Restaurant 53', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34390362 AS Decimal(11, 8)), CAST(104.07187365 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (54, 59, N'Restaurant 54', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33820170 AS Decimal(11, 8)), CAST(103.92062605 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (55, 60, N'Restaurant 55', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30419111 AS Decimal(11, 8)), CAST(103.81850443 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (56, 61, N'Restaurant 56', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38534317 AS Decimal(11, 8)), CAST(103.80547964 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (57, 62, N'Restaurant 57', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41728640 AS Decimal(11, 8)), CAST(103.94385460 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (58, 63, N'Restaurant 58', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46639001 AS Decimal(11, 8)), CAST(103.69150560 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (59, 64, N'Restaurant 59', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32943117 AS Decimal(11, 8)), CAST(103.73463511 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (60, 65, N'Restaurant 60', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38809977 AS Decimal(11, 8)), CAST(103.85229884 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (61, 66, N'Restaurant 61', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28703308 AS Decimal(11, 8)), CAST(103.93605531 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (62, 67, N'Restaurant 62', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28421386 AS Decimal(11, 8)), CAST(103.84213673 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (63, 68, N'Restaurant 63', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35034157 AS Decimal(11, 8)), CAST(103.94726058 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (64, 69, N'Restaurant 64', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23827571 AS Decimal(11, 8)), CAST(103.90082125 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (65, 70, N'Restaurant 65', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25557321 AS Decimal(11, 8)), CAST(104.04450772 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (66, 71, N'Restaurant 66', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42842729 AS Decimal(11, 8)), CAST(104.05629821 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (67, 72, N'Restaurant 67', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30431980 AS Decimal(11, 8)), CAST(103.85270264 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (68, 73, N'Restaurant 68', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25044307 AS Decimal(11, 8)), CAST(104.01074453 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (69, 74, N'Restaurant 69', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32282175 AS Decimal(11, 8)), CAST(103.82952501 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (70, 75, N'Restaurant 70', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32228854 AS Decimal(11, 8)), CAST(103.98950220 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (71, 76, N'Restaurant 71', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33861725 AS Decimal(11, 8)), CAST(103.71802808 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (72, 77, N'Restaurant 72', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23805289 AS Decimal(11, 8)), CAST(103.64502575 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (73, 78, N'Restaurant 73', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35364531 AS Decimal(11, 8)), CAST(103.68516565 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (74, 79, N'Restaurant 74', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33833638 AS Decimal(11, 8)), CAST(103.74539993 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (75, 80, N'Restaurant 75', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34478495 AS Decimal(11, 8)), CAST(103.66901067 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (76, 81, N'Restaurant 76', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22718543 AS Decimal(11, 8)), CAST(103.99367350 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (77, 82, N'Restaurant 77', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25866562 AS Decimal(11, 8)), CAST(103.83671574 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (78, 83, N'Restaurant 78', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32331701 AS Decimal(11, 8)), CAST(103.98000873 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (79, 84, N'Restaurant 79', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42610681 AS Decimal(11, 8)), CAST(103.85713250 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (80, 85, N'Restaurant 80', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26775915 AS Decimal(11, 8)), CAST(103.98689315 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (81, 86, N'Restaurant 81', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18162710 AS Decimal(11, 8)), CAST(103.97805944 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (82, 87, N'Restaurant 82', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24759309 AS Decimal(11, 8)), CAST(103.84594426 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (83, 88, N'Restaurant 83', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23993196 AS Decimal(11, 8)), CAST(103.60332419 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (84, 89, N'Restaurant 84', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30945915 AS Decimal(11, 8)), CAST(103.86766005 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (85, 90, N'Restaurant 85', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.27215428 AS Decimal(11, 8)), CAST(103.85359360 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (86, 91, N'Restaurant 86', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42872717 AS Decimal(11, 8)), CAST(103.82315809 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (87, 92, N'Restaurant 87', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24530872 AS Decimal(11, 8)), CAST(103.77362606 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (88, 93, N'Restaurant 88', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34289228 AS Decimal(11, 8)), CAST(103.78859005 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (89, 94, N'Restaurant 89', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40171316 AS Decimal(11, 8)), CAST(103.88681181 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (90, 95, N'Restaurant 90', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20099018 AS Decimal(11, 8)), CAST(103.94621956 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (91, 96, N'Restaurant 91', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33927389 AS Decimal(11, 8)), CAST(103.84289079 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (92, 97, N'Restaurant 92', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44339518 AS Decimal(11, 8)), CAST(103.66303369 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (93, 98, N'Restaurant 93', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26175830 AS Decimal(11, 8)), CAST(103.81149482 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (94, 99, N'Restaurant 94', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28255705 AS Decimal(11, 8)), CAST(103.65787805 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (95, 100, N'Restaurant 95', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44850235 AS Decimal(11, 8)), CAST(104.05252956 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (96, 101, N'Restaurant 96', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.19106253 AS Decimal(11, 8)), CAST(103.98642649 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (97, 102, N'Restaurant 97', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29546995 AS Decimal(11, 8)), CAST(103.77930457 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (98, 103, N'Restaurant 98', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28722690 AS Decimal(11, 8)), CAST(103.63038165 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (99, 104, N'Restaurant 99', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31183747 AS Decimal(11, 8)), CAST(104.01998277 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (100, 105, N'Restaurant 100', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46760802 AS Decimal(11, 8)), CAST(103.93286834 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (101, 106, N'Restaurant 101', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44161321 AS Decimal(11, 8)), CAST(103.71427776 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (102, 107, N'Restaurant 102', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (103, 108, N'Restaurant 103', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (104, 109, N'Restaurant 104', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (105, 110, N'Restaurant 105', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (106, 111, N'Restaurant 106', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (107, 112, N'Restaurant 107', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (108, 113, N'Restaurant 108', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Restaurants] ([ID], [UserID], [Title], [Description], [Rating], [Address], [City], [Province], [PinCode], [Latitude], [Longitude], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) VALUES (117, 12, NULL, NULL, NULL, N'', N'', N'', N'', NULL, NULL, CAST(N'2020-11-02 13:54:29.083' AS DateTime), 12, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Restaurants] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (12, N'Name', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577208', NULL, CAST(1.19272833 AS Decimal(11, 8)), CAST(103.82373871 AS Decimal(11, 8)), N'rg.goswami@gmail.com', NULL, NULL, N'0', NULL, N'0', NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (14, N'Name 1', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577210', NULL, CAST(1.25011511 AS Decimal(11, 8)), CAST(103.90623428 AS Decimal(11, 8)), N'rg.goswami1@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (15, N'Name 2', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577211', NULL, CAST(1.44261881 AS Decimal(11, 8)), CAST(103.89103538 AS Decimal(11, 8)), N'rg.goswami2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (16, N'Name 3', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577212', NULL, CAST(1.31553288 AS Decimal(11, 8)), CAST(103.74009211 AS Decimal(11, 8)), N'rg.goswami3@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (17, N'Name 4', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577213', NULL, CAST(1.40592937 AS Decimal(11, 8)), CAST(103.64249514 AS Decimal(11, 8)), N'rg.goswami4@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (18, N'Name 5', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577214', NULL, CAST(1.41993126 AS Decimal(11, 8)), CAST(103.84888449 AS Decimal(11, 8)), N'rg.goswami5@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (19, N'Name 6', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577215', NULL, CAST(1.46068936 AS Decimal(11, 8)), CAST(103.78114420 AS Decimal(11, 8)), N'rg.goswami6@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (20, N'Name 7', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577216', NULL, CAST(1.41831340 AS Decimal(11, 8)), CAST(103.97510895 AS Decimal(11, 8)), N'rg.goswami7@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (21, N'Name 8', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577217', NULL, CAST(1.22163845 AS Decimal(11, 8)), CAST(103.89643681 AS Decimal(11, 8)), N'rg.goswami8@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (22, N'Name 9', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577218', NULL, CAST(1.28526724 AS Decimal(11, 8)), CAST(103.79201028 AS Decimal(11, 8)), N'rg.goswami9@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (23, N'Name 10', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577219', NULL, CAST(1.41953412 AS Decimal(11, 8)), CAST(103.94708372 AS Decimal(11, 8)), N'rg.goswami10@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (24, N'Name 11', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577220', NULL, CAST(1.18106905 AS Decimal(11, 8)), CAST(103.75069463 AS Decimal(11, 8)), N'rg.goswami11@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (25, N'Name 12', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577221', NULL, CAST(1.32227363 AS Decimal(11, 8)), CAST(103.63587108 AS Decimal(11, 8)), N'rg.goswami12@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (26, N'Name 13', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577222', NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), N'rg.goswami13@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (27, N'Name 14', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577223', NULL, CAST(1.46093731 AS Decimal(11, 8)), CAST(104.07640525 AS Decimal(11, 8)), N'rg.goswami14@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (28, N'Name 15', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577224', NULL, CAST(1.45769511 AS Decimal(11, 8)), CAST(103.87404491 AS Decimal(11, 8)), N'rg.goswami15@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (29, N'Name 16', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577225', NULL, CAST(1.18541278 AS Decimal(11, 8)), CAST(103.85239312 AS Decimal(11, 8)), N'rg.goswami16@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (30, N'Name 17', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577226', NULL, CAST(1.36429830 AS Decimal(11, 8)), CAST(103.96979685 AS Decimal(11, 8)), N'rg.goswami17@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (31, N'Name 18', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577227', NULL, CAST(1.34684671 AS Decimal(11, 8)), CAST(103.79950778 AS Decimal(11, 8)), N'rg.goswami18@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (32, N'Name 19', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577228', NULL, CAST(1.22487852 AS Decimal(11, 8)), CAST(103.85890199 AS Decimal(11, 8)), N'rg.goswami19@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (33, N'Name 20', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577229', NULL, CAST(1.17981108 AS Decimal(11, 8)), CAST(103.89998519 AS Decimal(11, 8)), N'rg.goswami20@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (34, N'Name 21', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577230', NULL, CAST(1.35894004 AS Decimal(11, 8)), CAST(103.90024795 AS Decimal(11, 8)), N'rg.goswami21@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (35, N'Name 22', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577231', NULL, CAST(1.17887209 AS Decimal(11, 8)), CAST(104.07640756 AS Decimal(11, 8)), N'rg.goswami22@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (36, N'Name 23', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577232', NULL, CAST(1.35449174 AS Decimal(11, 8)), CAST(103.81520640 AS Decimal(11, 8)), N'rg.goswami23@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (37, N'Name 24', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577233', NULL, CAST(1.26875677 AS Decimal(11, 8)), CAST(103.97542928 AS Decimal(11, 8)), N'rg.goswami24@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (38, N'Name 25', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577234', NULL, CAST(1.26502879 AS Decimal(11, 8)), CAST(103.87230513 AS Decimal(11, 8)), N'rg.goswami25@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (39, N'Name 26', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577235', NULL, CAST(1.38631678 AS Decimal(11, 8)), CAST(103.94318642 AS Decimal(11, 8)), N'rg.goswami26@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (40, N'Name 27', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577236', NULL, CAST(1.32125776 AS Decimal(11, 8)), CAST(103.75549026 AS Decimal(11, 8)), N'rg.goswami27@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (41, N'Name 28', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577237', NULL, CAST(1.31542410 AS Decimal(11, 8)), CAST(103.93298565 AS Decimal(11, 8)), N'rg.goswami28@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (42, N'Name 29', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577238', NULL, CAST(1.30413397 AS Decimal(11, 8)), CAST(103.77902536 AS Decimal(11, 8)), N'rg.goswami29@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (43, N'Name 30', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577239', NULL, CAST(1.20824078 AS Decimal(11, 8)), CAST(103.70336211 AS Decimal(11, 8)), N'rg.goswami30@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (44, N'Name 31', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577240', NULL, CAST(1.39324790 AS Decimal(11, 8)), CAST(104.01490449 AS Decimal(11, 8)), N'rg.goswami31@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (45, N'Name 32', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577241', NULL, CAST(1.24722367 AS Decimal(11, 8)), CAST(103.93230100 AS Decimal(11, 8)), N'rg.goswami32@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (46, N'Name 33', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577242', NULL, CAST(1.44596866 AS Decimal(11, 8)), CAST(104.06984106 AS Decimal(11, 8)), N'rg.goswami33@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (47, N'Name 34', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577243', NULL, CAST(1.33916158 AS Decimal(11, 8)), CAST(103.97660834 AS Decimal(11, 8)), N'rg.goswami34@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (48, N'Name 35', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577244', NULL, CAST(1.25309238 AS Decimal(11, 8)), CAST(103.95040257 AS Decimal(11, 8)), N'rg.goswami35@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (49, N'Name 36', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577245', NULL, CAST(1.29544031 AS Decimal(11, 8)), CAST(103.69872029 AS Decimal(11, 8)), N'rg.goswami36@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (50, N'Name 37', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577246', NULL, CAST(1.38175284 AS Decimal(11, 8)), CAST(103.60194207 AS Decimal(11, 8)), N'rg.goswami37@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (51, N'Name 38', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577247', NULL, CAST(1.35595497 AS Decimal(11, 8)), CAST(103.81284033 AS Decimal(11, 8)), N'rg.goswami38@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (52, N'Name 39', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577248', NULL, CAST(1.37627680 AS Decimal(11, 8)), CAST(103.69001311 AS Decimal(11, 8)), N'rg.goswami39@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (53, N'Name 40', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577249', NULL, CAST(1.34390362 AS Decimal(11, 8)), CAST(104.07187365 AS Decimal(11, 8)), N'rg.goswami40@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (54, N'Name 41', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577250', NULL, CAST(1.33820170 AS Decimal(11, 8)), CAST(103.92062605 AS Decimal(11, 8)), N'rg.goswami41@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (55, N'Name 42', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577251', NULL, CAST(1.30419111 AS Decimal(11, 8)), CAST(103.81850443 AS Decimal(11, 8)), N'rg.goswami42@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (56, N'Name 43', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577252', NULL, CAST(1.38534317 AS Decimal(11, 8)), CAST(103.80547964 AS Decimal(11, 8)), N'rg.goswami43@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (57, N'Name 44', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577253', NULL, CAST(1.41728640 AS Decimal(11, 8)), CAST(103.94385460 AS Decimal(11, 8)), N'rg.goswami44@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (58, N'Name 45', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577254', NULL, CAST(1.46639001 AS Decimal(11, 8)), CAST(103.69150560 AS Decimal(11, 8)), N'rg.goswami45@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (59, N'Name 46', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577255', NULL, CAST(1.32943117 AS Decimal(11, 8)), CAST(103.73463511 AS Decimal(11, 8)), N'rg.goswami46@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (60, N'Name 47', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577256', NULL, CAST(1.38809977 AS Decimal(11, 8)), CAST(103.85229884 AS Decimal(11, 8)), N'rg.goswami47@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (61, N'Name 48', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577257', NULL, CAST(1.28703308 AS Decimal(11, 8)), CAST(103.93605531 AS Decimal(11, 8)), N'rg.goswami48@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (62, N'Name 49', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577258', NULL, CAST(1.28421386 AS Decimal(11, 8)), CAST(103.84213673 AS Decimal(11, 8)), N'rg.goswami49@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (63, N'Name 50', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577259', NULL, CAST(1.35034157 AS Decimal(11, 8)), CAST(103.94726058 AS Decimal(11, 8)), N'rg.goswami50@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (64, N'Name 51', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577260', NULL, CAST(1.23827571 AS Decimal(11, 8)), CAST(103.90082125 AS Decimal(11, 8)), N'rg.goswami51@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (65, N'Name 52', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577261', NULL, CAST(1.25557321 AS Decimal(11, 8)), CAST(104.04450772 AS Decimal(11, 8)), N'rg.goswami52@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (66, N'Name 53', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577262', NULL, CAST(1.42842729 AS Decimal(11, 8)), CAST(104.05629821 AS Decimal(11, 8)), N'rg.goswami53@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (67, N'Name 54', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577263', NULL, CAST(1.30431980 AS Decimal(11, 8)), CAST(103.85270264 AS Decimal(11, 8)), N'rg.goswami54@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (68, N'Name 55', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577264', NULL, CAST(1.25044307 AS Decimal(11, 8)), CAST(104.01074453 AS Decimal(11, 8)), N'rg.goswami55@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (69, N'Name 56', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577265', NULL, CAST(1.32282175 AS Decimal(11, 8)), CAST(103.82952501 AS Decimal(11, 8)), N'rg.goswami56@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (70, N'Name 57', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577266', NULL, CAST(1.32228854 AS Decimal(11, 8)), CAST(103.98950220 AS Decimal(11, 8)), N'rg.goswami57@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (71, N'Name 58', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577267', NULL, CAST(1.33861725 AS Decimal(11, 8)), CAST(103.71802808 AS Decimal(11, 8)), N'rg.goswami58@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (72, N'Name 59', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577268', NULL, CAST(1.23805289 AS Decimal(11, 8)), CAST(103.64502575 AS Decimal(11, 8)), N'rg.goswami59@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (73, N'Name 60', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577269', NULL, CAST(1.35364531 AS Decimal(11, 8)), CAST(103.68516565 AS Decimal(11, 8)), N'rg.goswami60@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (74, N'Name 61', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577270', NULL, CAST(1.33833638 AS Decimal(11, 8)), CAST(103.74539993 AS Decimal(11, 8)), N'rg.goswami61@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (75, N'Name 62', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577271', NULL, CAST(1.34478495 AS Decimal(11, 8)), CAST(103.66901067 AS Decimal(11, 8)), N'rg.goswami62@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (76, N'Name 63', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577272', NULL, CAST(1.22718543 AS Decimal(11, 8)), CAST(103.99367350 AS Decimal(11, 8)), N'rg.goswami63@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (77, N'Name 64', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577273', NULL, CAST(1.25866562 AS Decimal(11, 8)), CAST(103.83671574 AS Decimal(11, 8)), N'rg.goswami64@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (78, N'Name 65', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577274', NULL, CAST(1.32331701 AS Decimal(11, 8)), CAST(103.98000873 AS Decimal(11, 8)), N'rg.goswami65@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (79, N'Name 66', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577275', NULL, CAST(1.42610681 AS Decimal(11, 8)), CAST(103.85713250 AS Decimal(11, 8)), N'rg.goswami66@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (80, N'Name 67', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577276', NULL, CAST(1.26775915 AS Decimal(11, 8)), CAST(103.98689315 AS Decimal(11, 8)), N'rg.goswami67@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (81, N'Name 68', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577277', NULL, CAST(1.18162710 AS Decimal(11, 8)), CAST(103.97805944 AS Decimal(11, 8)), N'rg.goswami68@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (82, N'Name 69', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577278', NULL, CAST(1.24759309 AS Decimal(11, 8)), CAST(103.84594426 AS Decimal(11, 8)), N'rg.goswami69@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (83, N'Name 70', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577279', NULL, CAST(1.23993196 AS Decimal(11, 8)), CAST(103.60332419 AS Decimal(11, 8)), N'rg.goswami70@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (84, N'Name 71', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577280', NULL, CAST(1.30945915 AS Decimal(11, 8)), CAST(103.86766005 AS Decimal(11, 8)), N'rg.goswami71@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (85, N'Name 72', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577281', NULL, CAST(1.27215428 AS Decimal(11, 8)), CAST(103.85359360 AS Decimal(11, 8)), N'rg.goswami72@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (86, N'Name 73', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577282', NULL, CAST(1.42872717 AS Decimal(11, 8)), CAST(103.82315809 AS Decimal(11, 8)), N'rg.goswami73@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (87, N'Name 74', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577283', NULL, CAST(1.24530872 AS Decimal(11, 8)), CAST(103.77362606 AS Decimal(11, 8)), N'rg.goswami74@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (88, N'Name 75', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577284', NULL, CAST(1.34289228 AS Decimal(11, 8)), CAST(103.78859005 AS Decimal(11, 8)), N'rg.goswami75@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (89, N'Name 76', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577285', NULL, CAST(1.40171316 AS Decimal(11, 8)), CAST(103.88681181 AS Decimal(11, 8)), N'rg.goswami76@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (90, N'Name 77', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577286', NULL, CAST(1.20099018 AS Decimal(11, 8)), CAST(103.94621956 AS Decimal(11, 8)), N'rg.goswami77@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (91, N'Name 78', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577287', NULL, CAST(1.33927389 AS Decimal(11, 8)), CAST(103.84289079 AS Decimal(11, 8)), N'rg.goswami78@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (92, N'Name 79', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577288', NULL, CAST(1.44339518 AS Decimal(11, 8)), CAST(103.66303369 AS Decimal(11, 8)), N'rg.goswami79@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (93, N'Name 80', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577289', NULL, CAST(1.26175830 AS Decimal(11, 8)), CAST(103.81149482 AS Decimal(11, 8)), N'rg.goswami80@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (94, N'Name 81', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577290', NULL, CAST(1.28255705 AS Decimal(11, 8)), CAST(103.65787805 AS Decimal(11, 8)), N'rg.goswami81@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (95, N'Name 82', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577291', NULL, CAST(1.44850235 AS Decimal(11, 8)), CAST(104.05252956 AS Decimal(11, 8)), N'rg.goswami82@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (96, N'Name 83', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577292', NULL, CAST(1.19106253 AS Decimal(11, 8)), CAST(103.98642649 AS Decimal(11, 8)), N'rg.goswami83@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (97, N'Name 84', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577293', NULL, CAST(1.29546995 AS Decimal(11, 8)), CAST(103.77930457 AS Decimal(11, 8)), N'rg.goswami84@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (98, N'Name 85', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577294', NULL, CAST(1.28722690 AS Decimal(11, 8)), CAST(103.63038165 AS Decimal(11, 8)), N'rg.goswami85@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (99, N'Name 86', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577295', NULL, CAST(1.31183747 AS Decimal(11, 8)), CAST(104.01998277 AS Decimal(11, 8)), N'rg.goswami86@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (100, N'Name 87', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577296', NULL, CAST(1.46760802 AS Decimal(11, 8)), CAST(103.93286834 AS Decimal(11, 8)), N'rg.goswami87@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (101, N'Name 88', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577297', NULL, CAST(1.44161321 AS Decimal(11, 8)), CAST(103.71427776 AS Decimal(11, 8)), N'rg.goswami88@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (102, N'Name 89', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577298', NULL, CAST(1.24405470 AS Decimal(11, 8)), CAST(103.68329081 AS Decimal(11, 8)), N'rg.goswami89@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (103, N'Name 90', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577299', NULL, CAST(1.37385733 AS Decimal(11, 8)), CAST(103.64200612 AS Decimal(11, 8)), N'rg.goswami90@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (104, N'Name 91', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577300', NULL, CAST(1.25849636 AS Decimal(11, 8)), CAST(103.68927361 AS Decimal(11, 8)), N'rg.goswami91@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (105, N'Name 92', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577301', NULL, CAST(1.40206418 AS Decimal(11, 8)), CAST(103.90033787 AS Decimal(11, 8)), N'rg.goswami92@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (106, N'Name 93', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577302', NULL, CAST(1.43019968 AS Decimal(11, 8)), CAST(104.05004512 AS Decimal(11, 8)), N'rg.goswami93@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (107, N'Name 94', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577303', NULL, CAST(1.46125909 AS Decimal(11, 8)), CAST(103.66689382 AS Decimal(11, 8)), N'rg.goswami94@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (108, N'Name 95', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577304', NULL, CAST(1.18025825 AS Decimal(11, 8)), CAST(103.80093319 AS Decimal(11, 8)), N'rg.goswami95@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (109, N'Name 96', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577305', NULL, CAST(1.37639886 AS Decimal(11, 8)), CAST(103.71670966 AS Decimal(11, 8)), N'rg.goswami96@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (110, N'Name 97', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577306', NULL, CAST(1.21132850 AS Decimal(11, 8)), CAST(103.70390242 AS Decimal(11, 8)), N'rg.goswami97@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (111, N'Name 98', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577307', NULL, CAST(1.30097436 AS Decimal(11, 8)), CAST(103.81754609 AS Decimal(11, 8)), N'rg.goswami98@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (112, N'Name 99', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577308', NULL, CAST(1.31112167 AS Decimal(11, 8)), CAST(104.06216647 AS Decimal(11, 8)), N'rg.goswami99@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (113, N'Name 100', NULL, NULL, 1, N'11223344', NULL, NULL, N'86577309', NULL, CAST(1.22665211 AS Decimal(11, 8)), CAST(104.03362886 AS Decimal(11, 8)), N'rg.goswami100@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (114, N'Consumers 1', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577310', NULL, CAST(1.46695922 AS Decimal(11, 8)), CAST(103.97840957 AS Decimal(11, 8)), N'rg.goswami1@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (115, N'Consumers 2', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577311', NULL, CAST(1.41969825 AS Decimal(11, 8)), CAST(103.62719993 AS Decimal(11, 8)), N'rg.goswami2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (116, N'Consumers 3', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577312', NULL, CAST(1.37175808 AS Decimal(11, 8)), CAST(103.97408728 AS Decimal(11, 8)), N'rg.goswami3@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (117, N'Consumers 4', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577313', NULL, CAST(1.40231479 AS Decimal(11, 8)), CAST(103.82193779 AS Decimal(11, 8)), N'rg.goswami4@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (118, N'Consumers 5', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577314', NULL, CAST(1.27300539 AS Decimal(11, 8)), CAST(103.79921623 AS Decimal(11, 8)), N'rg.goswami5@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (119, N'Consumers 6', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577315', NULL, CAST(1.23677616 AS Decimal(11, 8)), CAST(103.67092247 AS Decimal(11, 8)), N'rg.goswami6@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (120, N'Consumers 7', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577316', NULL, CAST(1.23267109 AS Decimal(11, 8)), CAST(103.90602949 AS Decimal(11, 8)), N'rg.goswami7@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (121, N'Consumers 8', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577317', NULL, CAST(1.19539333 AS Decimal(11, 8)), CAST(103.95758646 AS Decimal(11, 8)), N'rg.goswami8@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (122, N'Consumers 9', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577318', NULL, CAST(1.33692088 AS Decimal(11, 8)), CAST(103.88530861 AS Decimal(11, 8)), N'rg.goswami9@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (123, N'Consumers 10', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577319', NULL, CAST(1.43785405 AS Decimal(11, 8)), CAST(103.76773742 AS Decimal(11, 8)), N'rg.goswami10@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (124, N'Consumers 11', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577320', NULL, CAST(1.33771460 AS Decimal(11, 8)), CAST(103.94188438 AS Decimal(11, 8)), N'rg.goswami11@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (125, N'Consumers 12', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577321', NULL, CAST(1.33761231 AS Decimal(11, 8)), CAST(103.93131865 AS Decimal(11, 8)), N'rg.goswami12@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (126, N'Consumers 13', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577322', NULL, CAST(1.35117510 AS Decimal(11, 8)), CAST(103.97589749 AS Decimal(11, 8)), N'rg.goswami13@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (127, N'Consumers 14', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577323', NULL, CAST(1.39656965 AS Decimal(11, 8)), CAST(103.95278692 AS Decimal(11, 8)), N'rg.goswami14@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (128, N'Consumers 15', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577324', NULL, CAST(1.17018721 AS Decimal(11, 8)), CAST(103.69687267 AS Decimal(11, 8)), N'rg.goswami15@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (129, N'Consumers 16', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577325', NULL, CAST(1.26251570 AS Decimal(11, 8)), CAST(103.79691504 AS Decimal(11, 8)), N'rg.goswami16@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (130, N'Consumers 17', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577326', NULL, CAST(1.39871857 AS Decimal(11, 8)), CAST(103.78945612 AS Decimal(11, 8)), N'rg.goswami17@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (131, N'Consumers 18', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577327', NULL, CAST(1.29717223 AS Decimal(11, 8)), CAST(103.99715878 AS Decimal(11, 8)), N'rg.goswami18@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (132, N'Consumers 19', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577328', NULL, CAST(1.35679896 AS Decimal(11, 8)), CAST(103.62642219 AS Decimal(11, 8)), N'rg.goswami19@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (133, N'Consumers 20', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577329', NULL, CAST(1.17445604 AS Decimal(11, 8)), CAST(103.90981521 AS Decimal(11, 8)), N'rg.goswami20@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (134, N'Consumers 21', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577330', NULL, CAST(1.42300747 AS Decimal(11, 8)), CAST(103.73261925 AS Decimal(11, 8)), N'rg.goswami21@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (135, N'Consumers 22', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577331', NULL, CAST(1.25754552 AS Decimal(11, 8)), CAST(103.80694312 AS Decimal(11, 8)), N'rg.goswami22@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (136, N'Consumers 23', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577332', NULL, CAST(1.40046306 AS Decimal(11, 8)), CAST(103.76502487 AS Decimal(11, 8)), N'rg.goswami23@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (137, N'Consumers 24', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577333', NULL, CAST(1.39655534 AS Decimal(11, 8)), CAST(103.99396276 AS Decimal(11, 8)), N'rg.goswami24@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (138, N'Consumers 25', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577334', NULL, CAST(1.33493128 AS Decimal(11, 8)), CAST(103.80929075 AS Decimal(11, 8)), N'rg.goswami25@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (139, N'Consumers 26', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577335', NULL, CAST(1.36768644 AS Decimal(11, 8)), CAST(104.00610734 AS Decimal(11, 8)), N'rg.goswami26@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (140, N'Consumers 27', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577336', NULL, CAST(1.45393120 AS Decimal(11, 8)), CAST(103.98012759 AS Decimal(11, 8)), N'rg.goswami27@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (141, N'Consumers 28', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577337', NULL, CAST(1.17015729 AS Decimal(11, 8)), CAST(103.80667498 AS Decimal(11, 8)), N'rg.goswami28@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (142, N'Consumers 29', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577338', NULL, CAST(1.24741431 AS Decimal(11, 8)), CAST(103.60729646 AS Decimal(11, 8)), N'rg.goswami29@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (143, N'Consumers 30', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577339', NULL, CAST(1.29015403 AS Decimal(11, 8)), CAST(103.94432372 AS Decimal(11, 8)), N'rg.goswami30@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (144, N'Consumers 31', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577340', NULL, CAST(1.23701534 AS Decimal(11, 8)), CAST(103.99192944 AS Decimal(11, 8)), N'rg.goswami31@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (145, N'Consumers 32', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577341', NULL, CAST(1.40320435 AS Decimal(11, 8)), CAST(104.05782059 AS Decimal(11, 8)), N'rg.goswami32@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (146, N'Consumers 33', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577342', NULL, CAST(1.41238631 AS Decimal(11, 8)), CAST(103.89497776 AS Decimal(11, 8)), N'rg.goswami33@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (147, N'Consumers 34', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577343', NULL, CAST(1.44928014 AS Decimal(11, 8)), CAST(103.79285310 AS Decimal(11, 8)), N'rg.goswami34@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (148, N'Consumers 35', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577344', NULL, CAST(1.26295616 AS Decimal(11, 8)), CAST(104.00831888 AS Decimal(11, 8)), N'rg.goswami35@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (149, N'Consumers 36', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577345', NULL, CAST(1.20574393 AS Decimal(11, 8)), CAST(103.69577524 AS Decimal(11, 8)), N'rg.goswami36@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (150, N'Consumers 37', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577346', NULL, CAST(1.39522320 AS Decimal(11, 8)), CAST(103.69646837 AS Decimal(11, 8)), N'rg.goswami37@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (151, N'Consumers 38', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577347', NULL, CAST(1.30656394 AS Decimal(11, 8)), CAST(103.93238589 AS Decimal(11, 8)), N'rg.goswami38@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (152, N'Consumers 39', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577348', NULL, CAST(1.43727653 AS Decimal(11, 8)), CAST(103.91495827 AS Decimal(11, 8)), N'rg.goswami39@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (153, N'Consumers 40', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577349', NULL, CAST(1.20396884 AS Decimal(11, 8)), CAST(103.79515557 AS Decimal(11, 8)), N'rg.goswami40@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (154, N'Consumers 41', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577350', NULL, CAST(1.41036872 AS Decimal(11, 8)), CAST(103.86113130 AS Decimal(11, 8)), N'rg.goswami41@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (155, N'Consumers 42', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577351', NULL, CAST(1.18704476 AS Decimal(11, 8)), CAST(103.87674998 AS Decimal(11, 8)), N'rg.goswami42@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (156, N'Consumers 43', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577352', NULL, CAST(1.19715782 AS Decimal(11, 8)), CAST(103.65430432 AS Decimal(11, 8)), N'rg.goswami43@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (157, N'Consumers 44', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577353', NULL, CAST(1.24239048 AS Decimal(11, 8)), CAST(103.96495076 AS Decimal(11, 8)), N'rg.goswami44@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (158, N'Consumers 45', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577354', NULL, CAST(1.21673020 AS Decimal(11, 8)), CAST(104.02633417 AS Decimal(11, 8)), N'rg.goswami45@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (159, N'Consumers 46', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577355', NULL, CAST(1.28411510 AS Decimal(11, 8)), CAST(104.01258560 AS Decimal(11, 8)), N'rg.goswami46@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (160, N'Consumers 47', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577356', NULL, CAST(1.24788325 AS Decimal(11, 8)), CAST(103.99768855 AS Decimal(11, 8)), N'rg.goswami47@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (161, N'Consumers 48', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577357', NULL, CAST(1.29162275 AS Decimal(11, 8)), CAST(103.97863882 AS Decimal(11, 8)), N'rg.goswami48@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (162, N'Consumers 49', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577358', NULL, CAST(1.40032103 AS Decimal(11, 8)), CAST(103.73292769 AS Decimal(11, 8)), N'rg.goswami49@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (163, N'Consumers 50', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577359', NULL, CAST(1.32843382 AS Decimal(11, 8)), CAST(103.64404631 AS Decimal(11, 8)), N'rg.goswami50@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (164, N'Consumers 51', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577360', NULL, CAST(1.23491618 AS Decimal(11, 8)), CAST(103.98569815 AS Decimal(11, 8)), N'rg.goswami51@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (165, N'Consumers 52', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577361', NULL, CAST(1.40130204 AS Decimal(11, 8)), CAST(103.79245614 AS Decimal(11, 8)), N'rg.goswami52@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (166, N'Consumers 53', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577362', NULL, CAST(1.31479508 AS Decimal(11, 8)), CAST(103.87247971 AS Decimal(11, 8)), N'rg.goswami53@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (167, N'Consumers 54', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577363', NULL, CAST(1.34048241 AS Decimal(11, 8)), CAST(103.70847957 AS Decimal(11, 8)), N'rg.goswami54@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (168, N'Consumers 55', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577364', NULL, CAST(1.37291892 AS Decimal(11, 8)), CAST(104.01276384 AS Decimal(11, 8)), N'rg.goswami55@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (169, N'Consumers 56', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577365', NULL, CAST(1.45880922 AS Decimal(11, 8)), CAST(103.65746597 AS Decimal(11, 8)), N'rg.goswami56@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (170, N'Consumers 57', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577366', NULL, CAST(1.36743046 AS Decimal(11, 8)), CAST(103.70828486 AS Decimal(11, 8)), N'rg.goswami57@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (171, N'Consumers 58', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577367', NULL, CAST(1.20341293 AS Decimal(11, 8)), CAST(104.01992553 AS Decimal(11, 8)), N'rg.goswami58@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (172, N'Consumers 59', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577368', NULL, CAST(1.39977264 AS Decimal(11, 8)), CAST(103.85001345 AS Decimal(11, 8)), N'rg.goswami59@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (173, N'Consumers 60', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577369', NULL, CAST(1.27208713 AS Decimal(11, 8)), CAST(103.93700243 AS Decimal(11, 8)), N'rg.goswami60@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (174, N'Consumers 61', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577370', NULL, CAST(1.27760237 AS Decimal(11, 8)), CAST(103.96858210 AS Decimal(11, 8)), N'rg.goswami61@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (175, N'Consumers 62', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577371', NULL, CAST(1.37922051 AS Decimal(11, 8)), CAST(103.65255380 AS Decimal(11, 8)), N'rg.goswami62@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (176, N'Consumers 63', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577372', NULL, CAST(1.18648697 AS Decimal(11, 8)), CAST(103.86561304 AS Decimal(11, 8)), N'rg.goswami63@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (177, N'Consumers 64', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577373', NULL, CAST(1.20362932 AS Decimal(11, 8)), CAST(103.67085007 AS Decimal(11, 8)), N'rg.goswami64@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (178, N'Consumers 65', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577374', NULL, CAST(1.39403122 AS Decimal(11, 8)), CAST(103.92586497 AS Decimal(11, 8)), N'rg.goswami65@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (179, N'Consumers 66', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577375', NULL, CAST(1.22302277 AS Decimal(11, 8)), CAST(103.61395497 AS Decimal(11, 8)), N'rg.goswami66@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (180, N'Consumers 67', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577376', NULL, CAST(1.45083061 AS Decimal(11, 8)), CAST(103.69942006 AS Decimal(11, 8)), N'rg.goswami67@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (181, N'Consumers 68', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577377', NULL, CAST(1.45085827 AS Decimal(11, 8)), CAST(103.78385820 AS Decimal(11, 8)), N'rg.goswami68@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (182, N'Consumers 69', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577378', NULL, CAST(1.32252879 AS Decimal(11, 8)), CAST(103.80982937 AS Decimal(11, 8)), N'rg.goswami69@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (183, N'Consumers 70', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577379', NULL, CAST(1.30818550 AS Decimal(11, 8)), CAST(104.01514899 AS Decimal(11, 8)), N'rg.goswami70@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (184, N'Consumers 71', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577380', NULL, CAST(1.32214207 AS Decimal(11, 8)), CAST(103.79291421 AS Decimal(11, 8)), N'rg.goswami71@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (185, N'Consumers 72', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577381', NULL, CAST(1.36563790 AS Decimal(11, 8)), CAST(103.64728642 AS Decimal(11, 8)), N'rg.goswami72@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (186, N'Consumers 73', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577382', NULL, CAST(1.29993508 AS Decimal(11, 8)), CAST(103.65894980 AS Decimal(11, 8)), N'rg.goswami73@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (187, N'Consumers 74', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577383', NULL, CAST(1.24571559 AS Decimal(11, 8)), CAST(103.60666387 AS Decimal(11, 8)), N'rg.goswami74@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (188, N'Consumers 75', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577384', NULL, CAST(1.30752000 AS Decimal(11, 8)), CAST(103.70607185 AS Decimal(11, 8)), N'rg.goswami75@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (189, N'Consumers 76', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577385', NULL, CAST(1.34531642 AS Decimal(11, 8)), CAST(103.79700783 AS Decimal(11, 8)), N'rg.goswami76@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (190, N'Consumers 77', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577386', NULL, CAST(1.23947547 AS Decimal(11, 8)), CAST(104.04110461 AS Decimal(11, 8)), N'rg.goswami77@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (191, N'Consumers 78', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577387', NULL, CAST(1.29038179 AS Decimal(11, 8)), CAST(103.84923400 AS Decimal(11, 8)), N'rg.goswami78@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (192, N'Consumers 79', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577388', NULL, CAST(1.18275259 AS Decimal(11, 8)), CAST(103.72817375 AS Decimal(11, 8)), N'rg.goswami79@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (193, N'Consumers 80', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577389', NULL, CAST(1.20444510 AS Decimal(11, 8)), CAST(103.84891686 AS Decimal(11, 8)), N'rg.goswami80@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (194, N'Consumers 81', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577390', NULL, CAST(1.25680643 AS Decimal(11, 8)), CAST(103.65470763 AS Decimal(11, 8)), N'rg.goswami81@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (195, N'Consumers 82', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577391', NULL, CAST(1.46338385 AS Decimal(11, 8)), CAST(103.70682065 AS Decimal(11, 8)), N'rg.goswami82@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (196, N'Consumers 83', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577392', NULL, CAST(1.25300640 AS Decimal(11, 8)), CAST(103.73942333 AS Decimal(11, 8)), N'rg.goswami83@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (197, N'Consumers 84', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577393', NULL, CAST(1.42550184 AS Decimal(11, 8)), CAST(103.97824295 AS Decimal(11, 8)), N'rg.goswami84@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (198, N'Consumers 85', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577394', NULL, CAST(1.20152623 AS Decimal(11, 8)), CAST(103.65792970 AS Decimal(11, 8)), N'rg.goswami85@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (199, N'Consumers 86', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577395', NULL, CAST(1.35602484 AS Decimal(11, 8)), CAST(103.66883595 AS Decimal(11, 8)), N'rg.goswami86@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (200, N'Consumers 87', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577396', NULL, CAST(1.24220645 AS Decimal(11, 8)), CAST(103.82183237 AS Decimal(11, 8)), N'rg.goswami87@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (201, N'Consumers 88', NULL, NULL, 2, N'11223344', NULL, NULL, N'86577397', NULL, CAST(1.27284341 AS Decimal(11, 8)), CAST(103.97626774 AS Decimal(11, 8)), N'rg.goswami88@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (202, N'Consumers 89', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577398', NULL, CAST(1.43347620 AS Decimal(11, 8)), CAST(103.65029596 AS Decimal(11, 8)), N'rg.goswami89@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (203, N'Consumers 90', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577399', NULL, CAST(1.17569793 AS Decimal(11, 8)), CAST(103.85285700 AS Decimal(11, 8)), N'rg.goswami90@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (204, N'Consumers 91', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577400', NULL, CAST(1.28312182 AS Decimal(11, 8)), CAST(103.75530786 AS Decimal(11, 8)), N'rg.goswami91@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (205, N'Consumers 92', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577401', NULL, CAST(1.27788341 AS Decimal(11, 8)), CAST(104.00723407 AS Decimal(11, 8)), N'rg.goswami92@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (206, N'Consumers 93', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577402', NULL, CAST(1.35544877 AS Decimal(11, 8)), CAST(103.88058091 AS Decimal(11, 8)), N'rg.goswami93@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (207, N'Consumers 94', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577403', NULL, CAST(1.35807207 AS Decimal(11, 8)), CAST(103.61294081 AS Decimal(11, 8)), N'rg.goswami94@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (208, N'Consumers 95', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577404', NULL, CAST(1.40885893 AS Decimal(11, 8)), CAST(103.84076340 AS Decimal(11, 8)), N'rg.goswami95@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (209, N'Consumers 96', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577405', NULL, CAST(1.39000689 AS Decimal(11, 8)), CAST(103.60709596 AS Decimal(11, 8)), N'rg.goswami96@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (210, N'Consumers 97', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577406', NULL, CAST(1.24565550 AS Decimal(11, 8)), CAST(103.79858355 AS Decimal(11, 8)), N'rg.goswami97@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (211, N'Consumers 98', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577407', NULL, CAST(1.45125612 AS Decimal(11, 8)), CAST(103.74438938 AS Decimal(11, 8)), N'rg.goswami98@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (212, N'Consumers 99', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577408', NULL, CAST(1.28969402 AS Decimal(11, 8)), CAST(103.91620800 AS Decimal(11, 8)), N'rg.goswami99@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [PhoneNumber], [CountryCode], [Latitude], [Longitude], [Email], [DateOfBirth], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (213, N'Consumers 100', NULL, NULL, NULL, N'11223344', NULL, NULL, N'86577409', NULL, CAST(1.32171109 AS Decimal(11, 8)), CAST(103.90502510 AS Decimal(11, 8)), N'rg.goswami100@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
