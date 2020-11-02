USE [KaamKaaj]
GO
/****** Object:  StoredProcedure [dbo].[spAuthenticateUser]    Script Date: 11/23/2015 15:01:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAuthenticateUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAuthenticateUser]
GO
/****** Object:  StoredProcedure [dbo].[spBlockUser]    Script Date: 11/23/2015 15:01:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBlockUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spBlockUser]
GO
/****** Object:  StoredProcedure [dbo].[spGetNearCustomers]    Script Date: 11/23/2015 15:01:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetNearCustomers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spGetNearCustomers]
GO
/****** Object:  StoredProcedure [dbo].[spGetNearLocations]    Script Date: 11/23/2015 15:01:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetNearLocations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spGetNearLocations]
GO
/****** Object:  StoredProcedure [dbo].[spGetNearServiceProviders]    Script Date: 11/23/2015 15:01:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetNearServiceProviders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spGetNearServiceProviders]
GO
/****** Object:  Table [dbo].[UserAvatars]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserAvatars]') AND type in (N'U'))
DROP TABLE [dbo].[UserAvatars]
GO
/****** Object:  Table [dbo].[UserExternalLogins]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserExternalLogins]') AND type in (N'U'))
DROP TABLE [dbo].[UserExternalLogins]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attachment]') AND type in (N'U'))
DROP TABLE [dbo].[Attachment]
GO
/****** Object:  Table [dbo].[BlockUsers]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlockUsers]') AND type in (N'U'))
DROP TABLE [dbo].[BlockUsers]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
DROP TABLE [dbo].[Categories]
GO
/****** Object:  Table [dbo].[Consumers]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Consumers]') AND type in (N'U'))
DROP TABLE [dbo].[Consumers]
GO
/****** Object:  Table [dbo].[ExternalLoginProviders]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExternalLoginProviders]') AND type in (N'U'))
DROP TABLE [dbo].[ExternalLoginProviders]
GO
/****** Object:  Table [dbo].[Favorites]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Favorites]') AND type in (N'U'))
DROP TABLE [dbo].[Favorites]
GO
/****** Object:  Table [dbo].[Followers]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Followers]') AND type in (N'U'))
DROP TABLE [dbo].[Followers]
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Likes]') AND type in (N'U'))
DROP TABLE [dbo].[Likes]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Messages]') AND type in (N'U'))
DROP TABLE [dbo].[Messages]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order]') AND type in (N'U'))
DROP TABLE [dbo].[Order]
GO
/****** Object:  Table [dbo].[ProfileVisitors]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProfileVisitors]') AND type in (N'U'))
DROP TABLE [dbo].[ProfileVisitors]
GO
/****** Object:  Table [dbo].[QrCodeLogin]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QrCodeLogin]') AND type in (N'U'))
DROP TABLE [dbo].[QrCodeLogin]
GO
/****** Object:  Table [dbo].[QrCodeTokens]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QrCodeTokens]') AND type in (N'U'))
DROP TABLE [dbo].[QrCodeTokens]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rating]') AND type in (N'U'))
DROP TABLE [dbo].[Rating]
GO
/****** Object:  Table [dbo].[ServiceProviders]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceProviders]') AND type in (N'U'))
DROP TABLE [dbo].[ServiceProviders]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Services]') AND type in (N'U'))
DROP TABLE [dbo].[Services]
GO
/****** Object:  Table [dbo].[Shares]    Script Date: 11/23/2015 15:01:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Shares]') AND type in (N'U'))
DROP TABLE [dbo].[Shares]
GO
/****** Object:  Table [dbo].[Shares]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Shares]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Shares](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ShareUserID] [int] NOT NULL,
 CONSTRAINT [PK_Shares] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Services]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Services]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Services](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](150) NULL,
	[Description] [varchar](500) NULL,
	[BlogID] [int] NULL,
	[AttachmentID] [int] NULL,
	[RatingID] [int] NULL,
	[Price] [money] NULL,
	[Guarantee] [bit] NULL,
	[Warranty] [nchar](10) NULL,
	[Likes] [int] NULL,
	[Dislikes] [int] NULL,
	[Views] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServiceProviders]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceProviders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceProviders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[JobDescription] [varchar](150) NULL,
	[Experience] [int] NULL,
	[ExpectedWages] [money] NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Province] [varchar](50) NULL,
	[PinCode] [varchar](10) NULL,
 CONSTRAINT [PK_ServiceProvider] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ServiceProviders] ON
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (8, 12, N'This', NULL, 0, 0.0000, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (9, 14, N'Title 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (10, 15, N'Title 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (11, 16, N'Title 3', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (12, 17, N'Title 4', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (13, 18, N'Title 5', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (14, 19, N'Title 6', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (15, 20, N'Title 7', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (16, 21, N'Title 8', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (17, 22, N'Title 9', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (18, 23, N'Title 10', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (19, 24, N'Title 11', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (20, 25, N'Title 12', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (21, 26, N'Title 13', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (22, 27, N'Title 14', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (23, 28, N'Title 15', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (24, 29, N'Title 16', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (25, 30, N'Title 17', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (26, 31, N'Title 18', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (27, 32, N'Title 19', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (28, 33, N'Title 20', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (29, 34, N'Title 21', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (30, 35, N'Title 22', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (31, 36, N'Title 23', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (32, 37, N'Title 24', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (33, 38, N'Title 25', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (34, 39, N'Title 26', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (35, 40, N'Title 27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (36, 41, N'Title 28', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (37, 42, N'Title 29', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (38, 43, N'Title 30', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (39, 44, N'Title 31', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (40, 45, N'Title 32', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (41, 46, N'Title 33', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (42, 47, N'Title 34', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (43, 48, N'Title 35', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (44, 49, N'Title 36', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (45, 50, N'Title 37', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (46, 51, N'Title 38', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (47, 52, N'Title 39', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (48, 53, N'Title 40', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (49, 54, N'Title 41', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (50, 55, N'Title 42', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (51, 56, N'Title 43', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (52, 57, N'Title 44', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (53, 58, N'Title 45', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (54, 59, N'Title 46', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (55, 60, N'Title 47', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (56, 61, N'Title 48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (57, 62, N'Title 49', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (58, 63, N'Title 50', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (59, 64, N'Title 51', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (60, 65, N'Title 52', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (61, 66, N'Title 53', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (62, 67, N'Title 54', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (63, 68, N'Title 55', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (64, 69, N'Title 56', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (65, 70, N'Title 57', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (66, 71, N'Title 58', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (67, 72, N'Title 59', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (68, 73, N'Title 60', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (69, 74, N'Title 61', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (70, 75, N'Title 62', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (71, 76, N'Title 63', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (72, 77, N'Title 64', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (73, 78, N'Title 65', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (74, 79, N'Title 66', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (75, 80, N'Title 67', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (76, 81, N'Title 68', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (77, 82, N'Title 69', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (78, 83, N'Title 70', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (79, 84, N'Title 71', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (80, 85, N'Title 72', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (81, 86, N'Title 73', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (82, 87, N'Title 74', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (83, 88, N'Title 75', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (84, 89, N'Title 76', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (85, 90, N'Title 77', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (86, 91, N'Title 78', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (87, 92, N'Title 79', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (88, 93, N'Title 80', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (89, 94, N'Title 81', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (90, 95, N'Title 82', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (91, 96, N'Title 83', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (92, 97, N'Title 84', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (93, 98, N'Title 85', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (94, 99, N'Title 86', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (95, 100, N'Title 87', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (96, 101, N'Title 88', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (97, 102, N'Title 89', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (98, 103, N'Title 90', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (99, 104, N'Title 91', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (100, 105, N'Title 92', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (101, 106, N'Title 93', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (102, 107, N'Title 94', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (103, 108, N'Title 95', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (104, 109, N'Title 96', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (105, 110, N'Title 97', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (106, 111, N'Title 98', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (107, 112, N'Title 99', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
print 'Processed 100 total records'
INSERT [dbo].[ServiceProviders] ([ID], [UserID], [Title], [JobDescription], [Experience], [ExpectedWages], [Address], [City], [Province], [PinCode]) VALUES (108, 113, N'Title 100', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ServiceProviders] OFF
/****** Object:  Table [dbo].[Rating]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rating]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Rating](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RatingValue] [int] NULL,
	[ServiceID] [int] NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[QrCodeTokens]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QrCodeTokens]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QrCodeTokens](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QrCodeToken] [varchar](150) NULL,
	[SessionID] [varchar](50) NULL,
 CONSTRAINT [PK_QrCodeTokens] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QrCodeLogin]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QrCodeLogin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QrCodeLogin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[QrCodeTokenID] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProfileVisitors]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProfileVisitors]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProfileVisitors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProfileID] [int] NOT NULL,
	[VisitorID] [int] NOT NULL,
 CONSTRAINT [PK_ProfileVisitors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdateDate] [date] NULL,
	[UpdatedBy] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Messages]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Messages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FromUserID] [int] NOT NULL,
	[ToUserID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Description] [varchar](150) NOT NULL,
	[State] [int] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Likes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Likes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[LikeUserID] [int] NOT NULL,
 CONSTRAINT [PK_Likes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Followers]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Followers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Followers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[FollowerID] [int] NOT NULL,
 CONSTRAINT [PK_Followers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Favorites]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Favorites]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Favorites](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[FavoriteUserID] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Favorites] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ExternalLoginProviders]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExternalLoginProviders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExternalLoginProviders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ExternalLoginProvider_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Consumers]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Consumers]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Consumers] ON
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (1, 114, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (2, 115, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (3, 116, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (4, 117, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (5, 118, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (6, 119, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (7, 120, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (8, 121, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (9, 122, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (10, 123, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (11, 124, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (12, 125, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (13, 126, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (14, 127, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (15, 128, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (16, 129, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (17, 130, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (18, 131, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (19, 132, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (20, 133, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (21, 134, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (22, 135, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (23, 136, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (24, 137, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (25, 138, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (26, 139, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (27, 140, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (28, 141, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (29, 142, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (30, 143, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (31, 144, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (32, 145, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (33, 146, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (34, 147, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (35, 148, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (36, 149, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (37, 150, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (38, 151, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (39, 152, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (40, 153, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (41, 154, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (42, 155, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (43, 156, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (44, 157, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (45, 158, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (46, 159, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (47, 160, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (48, 161, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (49, 162, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (50, 163, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (51, 164, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (52, 165, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (53, 166, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (54, 167, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (55, 168, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (56, 169, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (57, 170, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (58, 171, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (59, 172, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (60, 173, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (61, 174, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (62, 175, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (63, 176, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (64, 177, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (65, 178, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (66, 179, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (67, 180, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (68, 181, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (69, 182, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (70, 183, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (71, 184, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (72, 185, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (73, 186, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (74, 187, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (75, 188, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (76, 189, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (77, 190, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (78, 191, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (79, 192, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (80, 193, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (81, 194, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (82, 195, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (83, 196, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (84, 197, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (85, 198, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (86, 199, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (87, 200, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (88, 201, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (89, 202, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (90, 203, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (91, 204, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (92, 205, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (93, 206, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (94, 207, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (95, 208, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (96, 209, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (97, 210, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (98, 211, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (99, 212, NULL, NULL, NULL, NULL)
INSERT [dbo].[Consumers] ([ID], [UserID], [State], [City], [Address], [PinCode]) VALUES (100, 213, NULL, NULL, NULL, NULL)
GO
print 'Processed 100 total records'
SET IDENTITY_INSERT [dbo].[Consumers] OFF
/****** Object:  Table [dbo].[Categories]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Name] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON
INSERT [dbo].[Categories] ([ID], [Code], [Name]) VALUES (1, N'C1', N'Category 1')
SET IDENTITY_INSERT [dbo].[Categories] OFF
/****** Object:  Table [dbo].[BlockUsers]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlockUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BlockUsers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[BlockUserID] [int] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[WrongAttempt] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_BlockUsers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Attachment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AttachmentName] [varchar](50) NULL,
	[AttachmentUrl] [varchar](250) NULL,
	[AttachmentType] [int] NULL,
	[Attachment] [binary](50) NULL,
	[ServiceID] [int] NULL,
 CONSTRAINT [PK_Attachment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NULL,
	[UserName] [varchar](50) NULL,
	[UserType] [int] NULL,
	[Password] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](250) NULL,
	[PasswordSalt] [varchar](250) NULL,
	[RegistrationVerificationMethodType] [int] NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
	[PhoneNumberConfirmed] [bit] NULL,
	[CountryCode] [varchar](15) NULL,
	[DeviceIdentityNumber] [varchar](50) NULL,
	[LanguageG] [varchar](10) NULL,
	[LanguageC] [varchar](10) NULL,
	[Token] [varchar](10) NULL,
	[SimMnc] [varchar](50) NULL,
	[SimMcc] [varchar](50) NULL,
	[Latitude] [decimal](11, 8) NULL,
	[Longitude] [decimal](11, 8) NULL,
	[Email] [varchar](256) NULL,
	[EmailConfirmed] [bit] NULL,
	[DateOfBirth] [date] NULL,
	[Country] [varchar](50) NULL,
	[SecurityStamp] [varchar](50) NULL,
	[TwoFactorEnabled] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[LockoutEndDate] [datetime] NULL,
	[LockoutEnabled] [bit] NULL,
	[AccessFailedCount] [int] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (12, N'Name', NULL, NULL, 1, N'11223344', NULL, NULL, 0, N'86577208', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.19272833 AS Decimal(11, 8)), CAST(103.82373871 AS Decimal(11, 8)), N'rg.goswami@gmail.com', 0, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (14, N'Name 1', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577210', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25011511 AS Decimal(11, 8)), CAST(103.90623428 AS Decimal(11, 8)), N'rg.goswami1@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (15, N'Name 2', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577211', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44261881 AS Decimal(11, 8)), CAST(103.89103538 AS Decimal(11, 8)), N'rg.goswami2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (16, N'Name 3', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577212', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31553288 AS Decimal(11, 8)), CAST(103.74009211 AS Decimal(11, 8)), N'rg.goswami3@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (17, N'Name 4', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577213', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40592937 AS Decimal(11, 8)), CAST(103.64249514 AS Decimal(11, 8)), N'rg.goswami4@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (18, N'Name 5', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577214', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41993126 AS Decimal(11, 8)), CAST(103.84888449 AS Decimal(11, 8)), N'rg.goswami5@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (19, N'Name 6', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577215', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46068936 AS Decimal(11, 8)), CAST(103.78114420 AS Decimal(11, 8)), N'rg.goswami6@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (20, N'Name 7', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577216', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41831340 AS Decimal(11, 8)), CAST(103.97510895 AS Decimal(11, 8)), N'rg.goswami7@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (21, N'Name 8', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577217', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22163845 AS Decimal(11, 8)), CAST(103.89643681 AS Decimal(11, 8)), N'rg.goswami8@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (22, N'Name 9', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577218', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28526724 AS Decimal(11, 8)), CAST(103.79201028 AS Decimal(11, 8)), N'rg.goswami9@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (23, N'Name 10', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577219', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41953412 AS Decimal(11, 8)), CAST(103.94708372 AS Decimal(11, 8)), N'rg.goswami10@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (24, N'Name 11', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577220', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18106905 AS Decimal(11, 8)), CAST(103.75069463 AS Decimal(11, 8)), N'rg.goswami11@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (25, N'Name 12', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577221', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32227363 AS Decimal(11, 8)), CAST(103.63587108 AS Decimal(11, 8)), N'rg.goswami12@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (26, N'Name 13', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577222', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33609002 AS Decimal(11, 8)), CAST(103.62880600 AS Decimal(11, 8)), N'rg.goswami13@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (27, N'Name 14', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577223', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46093731 AS Decimal(11, 8)), CAST(104.07640525 AS Decimal(11, 8)), N'rg.goswami14@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (28, N'Name 15', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577224', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.45769511 AS Decimal(11, 8)), CAST(103.87404491 AS Decimal(11, 8)), N'rg.goswami15@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (29, N'Name 16', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577225', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18541278 AS Decimal(11, 8)), CAST(103.85239312 AS Decimal(11, 8)), N'rg.goswami16@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (30, N'Name 17', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577226', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.36429830 AS Decimal(11, 8)), CAST(103.96979685 AS Decimal(11, 8)), N'rg.goswami17@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (31, N'Name 18', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577227', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34684671 AS Decimal(11, 8)), CAST(103.79950778 AS Decimal(11, 8)), N'rg.goswami18@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (32, N'Name 19', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577228', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22487852 AS Decimal(11, 8)), CAST(103.85890199 AS Decimal(11, 8)), N'rg.goswami19@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (33, N'Name 20', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577229', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17981108 AS Decimal(11, 8)), CAST(103.89998519 AS Decimal(11, 8)), N'rg.goswami20@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (34, N'Name 21', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577230', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35894004 AS Decimal(11, 8)), CAST(103.90024795 AS Decimal(11, 8)), N'rg.goswami21@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (35, N'Name 22', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577231', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17887209 AS Decimal(11, 8)), CAST(104.07640756 AS Decimal(11, 8)), N'rg.goswami22@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (36, N'Name 23', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577232', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35449174 AS Decimal(11, 8)), CAST(103.81520640 AS Decimal(11, 8)), N'rg.goswami23@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (37, N'Name 24', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577233', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26875677 AS Decimal(11, 8)), CAST(103.97542928 AS Decimal(11, 8)), N'rg.goswami24@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (38, N'Name 25', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26502879 AS Decimal(11, 8)), CAST(103.87230513 AS Decimal(11, 8)), N'rg.goswami25@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (39, N'Name 26', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577235', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38631678 AS Decimal(11, 8)), CAST(103.94318642 AS Decimal(11, 8)), N'rg.goswami26@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (40, N'Name 27', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577236', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32125776 AS Decimal(11, 8)), CAST(103.75549026 AS Decimal(11, 8)), N'rg.goswami27@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (41, N'Name 28', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577237', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31542410 AS Decimal(11, 8)), CAST(103.93298565 AS Decimal(11, 8)), N'rg.goswami28@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (42, N'Name 29', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577238', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30413397 AS Decimal(11, 8)), CAST(103.77902536 AS Decimal(11, 8)), N'rg.goswami29@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (43, N'Name 30', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577239', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20824078 AS Decimal(11, 8)), CAST(103.70336211 AS Decimal(11, 8)), N'rg.goswami30@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (44, N'Name 31', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577240', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39324790 AS Decimal(11, 8)), CAST(104.01490449 AS Decimal(11, 8)), N'rg.goswami31@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (45, N'Name 32', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577241', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24722367 AS Decimal(11, 8)), CAST(103.93230100 AS Decimal(11, 8)), N'rg.goswami32@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (46, N'Name 33', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577242', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44596866 AS Decimal(11, 8)), CAST(104.06984106 AS Decimal(11, 8)), N'rg.goswami33@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (47, N'Name 34', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577243', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33916158 AS Decimal(11, 8)), CAST(103.97660834 AS Decimal(11, 8)), N'rg.goswami34@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (48, N'Name 35', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577244', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25309238 AS Decimal(11, 8)), CAST(103.95040257 AS Decimal(11, 8)), N'rg.goswami35@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (49, N'Name 36', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577245', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29544031 AS Decimal(11, 8)), CAST(103.69872029 AS Decimal(11, 8)), N'rg.goswami36@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (50, N'Name 37', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577246', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38175284 AS Decimal(11, 8)), CAST(103.60194207 AS Decimal(11, 8)), N'rg.goswami37@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (51, N'Name 38', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577247', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35595497 AS Decimal(11, 8)), CAST(103.81284033 AS Decimal(11, 8)), N'rg.goswami38@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (52, N'Name 39', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577248', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.37627680 AS Decimal(11, 8)), CAST(103.69001311 AS Decimal(11, 8)), N'rg.goswami39@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (53, N'Name 40', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577249', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34390362 AS Decimal(11, 8)), CAST(104.07187365 AS Decimal(11, 8)), N'rg.goswami40@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (54, N'Name 41', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577250', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33820170 AS Decimal(11, 8)), CAST(103.92062605 AS Decimal(11, 8)), N'rg.goswami41@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (55, N'Name 42', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30419111 AS Decimal(11, 8)), CAST(103.81850443 AS Decimal(11, 8)), N'rg.goswami42@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (56, N'Name 43', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577252', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38534317 AS Decimal(11, 8)), CAST(103.80547964 AS Decimal(11, 8)), N'rg.goswami43@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (57, N'Name 44', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577253', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41728640 AS Decimal(11, 8)), CAST(103.94385460 AS Decimal(11, 8)), N'rg.goswami44@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (58, N'Name 45', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577254', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46639001 AS Decimal(11, 8)), CAST(103.69150560 AS Decimal(11, 8)), N'rg.goswami45@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (59, N'Name 46', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577255', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32943117 AS Decimal(11, 8)), CAST(103.73463511 AS Decimal(11, 8)), N'rg.goswami46@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (60, N'Name 47', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.38809977 AS Decimal(11, 8)), CAST(103.85229884 AS Decimal(11, 8)), N'rg.goswami47@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (61, N'Name 48', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577257', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28703308 AS Decimal(11, 8)), CAST(103.93605531 AS Decimal(11, 8)), N'rg.goswami48@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (62, N'Name 49', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577258', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28421386 AS Decimal(11, 8)), CAST(103.84213673 AS Decimal(11, 8)), N'rg.goswami49@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (63, N'Name 50', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577259', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35034157 AS Decimal(11, 8)), CAST(103.94726058 AS Decimal(11, 8)), N'rg.goswami50@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (64, N'Name 51', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577260', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23827571 AS Decimal(11, 8)), CAST(103.90082125 AS Decimal(11, 8)), N'rg.goswami51@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (65, N'Name 52', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577261', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25557321 AS Decimal(11, 8)), CAST(104.04450772 AS Decimal(11, 8)), N'rg.goswami52@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (66, N'Name 53', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577262', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42842729 AS Decimal(11, 8)), CAST(104.05629821 AS Decimal(11, 8)), N'rg.goswami53@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (67, N'Name 54', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577263', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30431980 AS Decimal(11, 8)), CAST(103.85270264 AS Decimal(11, 8)), N'rg.goswami54@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (68, N'Name 55', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577264', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25044307 AS Decimal(11, 8)), CAST(104.01074453 AS Decimal(11, 8)), N'rg.goswami55@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (69, N'Name 56', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577265', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32282175 AS Decimal(11, 8)), CAST(103.82952501 AS Decimal(11, 8)), N'rg.goswami56@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (70, N'Name 57', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577266', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32228854 AS Decimal(11, 8)), CAST(103.98950220 AS Decimal(11, 8)), N'rg.goswami57@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (71, N'Name 58', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577267', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33861725 AS Decimal(11, 8)), CAST(103.71802808 AS Decimal(11, 8)), N'rg.goswami58@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (72, N'Name 59', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577268', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23805289 AS Decimal(11, 8)), CAST(103.64502575 AS Decimal(11, 8)), N'rg.goswami59@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (73, N'Name 60', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577269', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35364531 AS Decimal(11, 8)), CAST(103.68516565 AS Decimal(11, 8)), N'rg.goswami60@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (74, N'Name 61', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577270', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33833638 AS Decimal(11, 8)), CAST(103.74539993 AS Decimal(11, 8)), N'rg.goswami61@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (75, N'Name 62', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577271', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34478495 AS Decimal(11, 8)), CAST(103.66901067 AS Decimal(11, 8)), N'rg.goswami62@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (76, N'Name 63', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577272', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22718543 AS Decimal(11, 8)), CAST(103.99367350 AS Decimal(11, 8)), N'rg.goswami63@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (77, N'Name 64', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577273', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25866562 AS Decimal(11, 8)), CAST(103.83671574 AS Decimal(11, 8)), N'rg.goswami64@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (78, N'Name 65', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577274', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32331701 AS Decimal(11, 8)), CAST(103.98000873 AS Decimal(11, 8)), N'rg.goswami65@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (79, N'Name 66', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577275', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42610681 AS Decimal(11, 8)), CAST(103.85713250 AS Decimal(11, 8)), N'rg.goswami66@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (80, N'Name 67', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577276', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26775915 AS Decimal(11, 8)), CAST(103.98689315 AS Decimal(11, 8)), N'rg.goswami67@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (81, N'Name 68', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577277', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18162710 AS Decimal(11, 8)), CAST(103.97805944 AS Decimal(11, 8)), N'rg.goswami68@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (82, N'Name 69', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577278', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24759309 AS Decimal(11, 8)), CAST(103.84594426 AS Decimal(11, 8)), N'rg.goswami69@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (83, N'Name 70', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577279', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23993196 AS Decimal(11, 8)), CAST(103.60332419 AS Decimal(11, 8)), N'rg.goswami70@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (84, N'Name 71', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577280', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30945915 AS Decimal(11, 8)), CAST(103.86766005 AS Decimal(11, 8)), N'rg.goswami71@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (85, N'Name 72', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577281', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.27215428 AS Decimal(11, 8)), CAST(103.85359360 AS Decimal(11, 8)), N'rg.goswami72@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (86, N'Name 73', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577282', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42872717 AS Decimal(11, 8)), CAST(103.82315809 AS Decimal(11, 8)), N'rg.goswami73@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (87, N'Name 74', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577283', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24530872 AS Decimal(11, 8)), CAST(103.77362606 AS Decimal(11, 8)), N'rg.goswami74@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (88, N'Name 75', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577284', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34289228 AS Decimal(11, 8)), CAST(103.78859005 AS Decimal(11, 8)), N'rg.goswami75@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (89, N'Name 76', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577285', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40171316 AS Decimal(11, 8)), CAST(103.88681181 AS Decimal(11, 8)), N'rg.goswami76@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (90, N'Name 77', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577286', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20099018 AS Decimal(11, 8)), CAST(103.94621956 AS Decimal(11, 8)), N'rg.goswami77@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (91, N'Name 78', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577287', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33927389 AS Decimal(11, 8)), CAST(103.84289079 AS Decimal(11, 8)), N'rg.goswami78@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (92, N'Name 79', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577288', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44339518 AS Decimal(11, 8)), CAST(103.66303369 AS Decimal(11, 8)), N'rg.goswami79@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (93, N'Name 80', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577289', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26175830 AS Decimal(11, 8)), CAST(103.81149482 AS Decimal(11, 8)), N'rg.goswami80@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (94, N'Name 81', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577290', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28255705 AS Decimal(11, 8)), CAST(103.65787805 AS Decimal(11, 8)), N'rg.goswami81@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (95, N'Name 82', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577291', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44850235 AS Decimal(11, 8)), CAST(104.05252956 AS Decimal(11, 8)), N'rg.goswami82@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (96, N'Name 83', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577292', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.19106253 AS Decimal(11, 8)), CAST(103.98642649 AS Decimal(11, 8)), N'rg.goswami83@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (97, N'Name 84', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577293', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29546995 AS Decimal(11, 8)), CAST(103.77930457 AS Decimal(11, 8)), N'rg.goswami84@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (98, N'Name 85', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577294', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28722690 AS Decimal(11, 8)), CAST(103.63038165 AS Decimal(11, 8)), N'rg.goswami85@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (99, N'Name 86', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577295', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31183747 AS Decimal(11, 8)), CAST(104.01998277 AS Decimal(11, 8)), N'rg.goswami86@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (100, N'Name 87', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577296', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46760802 AS Decimal(11, 8)), CAST(103.93286834 AS Decimal(11, 8)), N'rg.goswami87@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (101, N'Name 88', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577297', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44161321 AS Decimal(11, 8)), CAST(103.71427776 AS Decimal(11, 8)), N'rg.goswami88@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (102, N'Name 89', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577298', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24405470 AS Decimal(11, 8)), CAST(103.68329081 AS Decimal(11, 8)), N'rg.goswami89@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (103, N'Name 90', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577299', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.37385733 AS Decimal(11, 8)), CAST(103.64200612 AS Decimal(11, 8)), N'rg.goswami90@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (104, N'Name 91', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577300', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25849636 AS Decimal(11, 8)), CAST(103.68927361 AS Decimal(11, 8)), N'rg.goswami91@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (105, N'Name 92', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577301', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40206418 AS Decimal(11, 8)), CAST(103.90033787 AS Decimal(11, 8)), N'rg.goswami92@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (106, N'Name 93', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577302', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.43019968 AS Decimal(11, 8)), CAST(104.05004512 AS Decimal(11, 8)), N'rg.goswami93@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (107, N'Name 94', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577303', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46125909 AS Decimal(11, 8)), CAST(103.66689382 AS Decimal(11, 8)), N'rg.goswami94@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (108, N'Name 95', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577304', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18025825 AS Decimal(11, 8)), CAST(103.80093319 AS Decimal(11, 8)), N'rg.goswami95@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (109, N'Name 96', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577305', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.37639886 AS Decimal(11, 8)), CAST(103.71670966 AS Decimal(11, 8)), N'rg.goswami96@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (110, N'Name 97', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577306', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.21132850 AS Decimal(11, 8)), CAST(103.70390242 AS Decimal(11, 8)), N'rg.goswami97@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (111, N'Name 98', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577307', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30097436 AS Decimal(11, 8)), CAST(103.81754609 AS Decimal(11, 8)), N'rg.goswami98@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (112, N'Name 99', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577308', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31112167 AS Decimal(11, 8)), CAST(104.06216647 AS Decimal(11, 8)), N'rg.goswami99@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
print 'Processed 100 total records'
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (113, N'Name 100', NULL, NULL, 1, N'11223344', NULL, NULL, NULL, N'86577309', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22665211 AS Decimal(11, 8)), CAST(104.03362886 AS Decimal(11, 8)), N'rg.goswami100@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (114, N'Consumers 1', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577310', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46695922 AS Decimal(11, 8)), CAST(103.97840957 AS Decimal(11, 8)), N'rg.goswami1@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (115, N'Consumers 2', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577311', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41969825 AS Decimal(11, 8)), CAST(103.62719993 AS Decimal(11, 8)), N'rg.goswami2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (116, N'Consumers 3', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577312', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.37175808 AS Decimal(11, 8)), CAST(103.97408728 AS Decimal(11, 8)), N'rg.goswami3@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (117, N'Consumers 4', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577313', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40231479 AS Decimal(11, 8)), CAST(103.82193779 AS Decimal(11, 8)), N'rg.goswami4@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (118, N'Consumers 5', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577314', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.27300539 AS Decimal(11, 8)), CAST(103.79921623 AS Decimal(11, 8)), N'rg.goswami5@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (119, N'Consumers 6', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577315', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23677616 AS Decimal(11, 8)), CAST(103.67092247 AS Decimal(11, 8)), N'rg.goswami6@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (120, N'Consumers 7', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577316', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23267109 AS Decimal(11, 8)), CAST(103.90602949 AS Decimal(11, 8)), N'rg.goswami7@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (121, N'Consumers 8', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577317', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.19539333 AS Decimal(11, 8)), CAST(103.95758646 AS Decimal(11, 8)), N'rg.goswami8@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (122, N'Consumers 9', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577318', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33692088 AS Decimal(11, 8)), CAST(103.88530861 AS Decimal(11, 8)), N'rg.goswami9@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (123, N'Consumers 10', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577319', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.43785405 AS Decimal(11, 8)), CAST(103.76773742 AS Decimal(11, 8)), N'rg.goswami10@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (124, N'Consumers 11', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577320', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33771460 AS Decimal(11, 8)), CAST(103.94188438 AS Decimal(11, 8)), N'rg.goswami11@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (125, N'Consumers 12', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577321', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33761231 AS Decimal(11, 8)), CAST(103.93131865 AS Decimal(11, 8)), N'rg.goswami12@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (126, N'Consumers 13', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577322', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35117510 AS Decimal(11, 8)), CAST(103.97589749 AS Decimal(11, 8)), N'rg.goswami13@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (127, N'Consumers 14', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577323', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39656965 AS Decimal(11, 8)), CAST(103.95278692 AS Decimal(11, 8)), N'rg.goswami14@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (128, N'Consumers 15', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577324', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17018721 AS Decimal(11, 8)), CAST(103.69687267 AS Decimal(11, 8)), N'rg.goswami15@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (129, N'Consumers 16', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577325', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26251570 AS Decimal(11, 8)), CAST(103.79691504 AS Decimal(11, 8)), N'rg.goswami16@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (130, N'Consumers 17', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577326', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39871857 AS Decimal(11, 8)), CAST(103.78945612 AS Decimal(11, 8)), N'rg.goswami17@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (131, N'Consumers 18', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577327', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29717223 AS Decimal(11, 8)), CAST(103.99715878 AS Decimal(11, 8)), N'rg.goswami18@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (132, N'Consumers 19', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577328', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35679896 AS Decimal(11, 8)), CAST(103.62642219 AS Decimal(11, 8)), N'rg.goswami19@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (133, N'Consumers 20', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577329', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17445604 AS Decimal(11, 8)), CAST(103.90981521 AS Decimal(11, 8)), N'rg.goswami20@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (134, N'Consumers 21', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577330', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42300747 AS Decimal(11, 8)), CAST(103.73261925 AS Decimal(11, 8)), N'rg.goswami21@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (135, N'Consumers 22', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577331', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25754552 AS Decimal(11, 8)), CAST(103.80694312 AS Decimal(11, 8)), N'rg.goswami22@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (136, N'Consumers 23', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577332', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40046306 AS Decimal(11, 8)), CAST(103.76502487 AS Decimal(11, 8)), N'rg.goswami23@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (137, N'Consumers 24', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577333', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39655534 AS Decimal(11, 8)), CAST(103.99396276 AS Decimal(11, 8)), N'rg.goswami24@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (138, N'Consumers 25', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577334', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.33493128 AS Decimal(11, 8)), CAST(103.80929075 AS Decimal(11, 8)), N'rg.goswami25@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (139, N'Consumers 26', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577335', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.36768644 AS Decimal(11, 8)), CAST(104.00610734 AS Decimal(11, 8)), N'rg.goswami26@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (140, N'Consumers 27', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577336', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.45393120 AS Decimal(11, 8)), CAST(103.98012759 AS Decimal(11, 8)), N'rg.goswami27@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (141, N'Consumers 28', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577337', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17015729 AS Decimal(11, 8)), CAST(103.80667498 AS Decimal(11, 8)), N'rg.goswami28@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (142, N'Consumers 29', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577338', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24741431 AS Decimal(11, 8)), CAST(103.60729646 AS Decimal(11, 8)), N'rg.goswami29@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (143, N'Consumers 30', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577339', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29015403 AS Decimal(11, 8)), CAST(103.94432372 AS Decimal(11, 8)), N'rg.goswami30@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (144, N'Consumers 31', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577340', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23701534 AS Decimal(11, 8)), CAST(103.99192944 AS Decimal(11, 8)), N'rg.goswami31@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (145, N'Consumers 32', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577341', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40320435 AS Decimal(11, 8)), CAST(104.05782059 AS Decimal(11, 8)), N'rg.goswami32@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (146, N'Consumers 33', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577342', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41238631 AS Decimal(11, 8)), CAST(103.89497776 AS Decimal(11, 8)), N'rg.goswami33@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (147, N'Consumers 34', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577343', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.44928014 AS Decimal(11, 8)), CAST(103.79285310 AS Decimal(11, 8)), N'rg.goswami34@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (148, N'Consumers 35', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577344', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.26295616 AS Decimal(11, 8)), CAST(104.00831888 AS Decimal(11, 8)), N'rg.goswami35@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (149, N'Consumers 36', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577345', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20574393 AS Decimal(11, 8)), CAST(103.69577524 AS Decimal(11, 8)), N'rg.goswami36@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (150, N'Consumers 37', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577346', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39522320 AS Decimal(11, 8)), CAST(103.69646837 AS Decimal(11, 8)), N'rg.goswami37@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (151, N'Consumers 38', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577347', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30656394 AS Decimal(11, 8)), CAST(103.93238589 AS Decimal(11, 8)), N'rg.goswami38@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (152, N'Consumers 39', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577348', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.43727653 AS Decimal(11, 8)), CAST(103.91495827 AS Decimal(11, 8)), N'rg.goswami39@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (153, N'Consumers 40', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577349', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20396884 AS Decimal(11, 8)), CAST(103.79515557 AS Decimal(11, 8)), N'rg.goswami40@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (154, N'Consumers 41', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577350', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.41036872 AS Decimal(11, 8)), CAST(103.86113130 AS Decimal(11, 8)), N'rg.goswami41@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (155, N'Consumers 42', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577351', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18704476 AS Decimal(11, 8)), CAST(103.87674998 AS Decimal(11, 8)), N'rg.goswami42@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (156, N'Consumers 43', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577352', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.19715782 AS Decimal(11, 8)), CAST(103.65430432 AS Decimal(11, 8)), N'rg.goswami43@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (157, N'Consumers 44', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577353', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24239048 AS Decimal(11, 8)), CAST(103.96495076 AS Decimal(11, 8)), N'rg.goswami44@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (158, N'Consumers 45', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577354', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.21673020 AS Decimal(11, 8)), CAST(104.02633417 AS Decimal(11, 8)), N'rg.goswami45@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (159, N'Consumers 46', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577355', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28411510 AS Decimal(11, 8)), CAST(104.01258560 AS Decimal(11, 8)), N'rg.goswami46@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (160, N'Consumers 47', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577356', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24788325 AS Decimal(11, 8)), CAST(103.99768855 AS Decimal(11, 8)), N'rg.goswami47@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (161, N'Consumers 48', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577357', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29162275 AS Decimal(11, 8)), CAST(103.97863882 AS Decimal(11, 8)), N'rg.goswami48@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (162, N'Consumers 49', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577358', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40032103 AS Decimal(11, 8)), CAST(103.73292769 AS Decimal(11, 8)), N'rg.goswami49@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (163, N'Consumers 50', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577359', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32843382 AS Decimal(11, 8)), CAST(103.64404631 AS Decimal(11, 8)), N'rg.goswami50@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (164, N'Consumers 51', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577360', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23491618 AS Decimal(11, 8)), CAST(103.98569815 AS Decimal(11, 8)), N'rg.goswami51@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (165, N'Consumers 52', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577361', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40130204 AS Decimal(11, 8)), CAST(103.79245614 AS Decimal(11, 8)), N'rg.goswami52@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (166, N'Consumers 53', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577362', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.31479508 AS Decimal(11, 8)), CAST(103.87247971 AS Decimal(11, 8)), N'rg.goswami53@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (167, N'Consumers 54', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577363', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34048241 AS Decimal(11, 8)), CAST(103.70847957 AS Decimal(11, 8)), N'rg.goswami54@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (168, N'Consumers 55', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577364', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.37291892 AS Decimal(11, 8)), CAST(104.01276384 AS Decimal(11, 8)), N'rg.goswami55@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (169, N'Consumers 56', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577365', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.45880922 AS Decimal(11, 8)), CAST(103.65746597 AS Decimal(11, 8)), N'rg.goswami56@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (170, N'Consumers 57', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.36743046 AS Decimal(11, 8)), CAST(103.70828486 AS Decimal(11, 8)), N'rg.goswami57@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (171, N'Consumers 58', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577367', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20341293 AS Decimal(11, 8)), CAST(104.01992553 AS Decimal(11, 8)), N'rg.goswami58@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (172, N'Consumers 59', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577368', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39977264 AS Decimal(11, 8)), CAST(103.85001345 AS Decimal(11, 8)), N'rg.goswami59@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (173, N'Consumers 60', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577369', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.27208713 AS Decimal(11, 8)), CAST(103.93700243 AS Decimal(11, 8)), N'rg.goswami60@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (174, N'Consumers 61', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577370', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.27760237 AS Decimal(11, 8)), CAST(103.96858210 AS Decimal(11, 8)), N'rg.goswami61@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (175, N'Consumers 62', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577371', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.37922051 AS Decimal(11, 8)), CAST(103.65255380 AS Decimal(11, 8)), N'rg.goswami62@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (176, N'Consumers 63', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577372', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18648697 AS Decimal(11, 8)), CAST(103.86561304 AS Decimal(11, 8)), N'rg.goswami63@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (177, N'Consumers 64', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577373', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20362932 AS Decimal(11, 8)), CAST(103.67085007 AS Decimal(11, 8)), N'rg.goswami64@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (178, N'Consumers 65', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577374', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39403122 AS Decimal(11, 8)), CAST(103.92586497 AS Decimal(11, 8)), N'rg.goswami65@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (179, N'Consumers 66', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577375', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.22302277 AS Decimal(11, 8)), CAST(103.61395497 AS Decimal(11, 8)), N'rg.goswami66@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (180, N'Consumers 67', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577376', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.45083061 AS Decimal(11, 8)), CAST(103.69942006 AS Decimal(11, 8)), N'rg.goswami67@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (181, N'Consumers 68', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577377', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.45085827 AS Decimal(11, 8)), CAST(103.78385820 AS Decimal(11, 8)), N'rg.goswami68@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (182, N'Consumers 69', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577378', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32252879 AS Decimal(11, 8)), CAST(103.80982937 AS Decimal(11, 8)), N'rg.goswami69@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (183, N'Consumers 70', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577379', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30818550 AS Decimal(11, 8)), CAST(104.01514899 AS Decimal(11, 8)), N'rg.goswami70@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (184, N'Consumers 71', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577380', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32214207 AS Decimal(11, 8)), CAST(103.79291421 AS Decimal(11, 8)), N'rg.goswami71@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (185, N'Consumers 72', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577381', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.36563790 AS Decimal(11, 8)), CAST(103.64728642 AS Decimal(11, 8)), N'rg.goswami72@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (186, N'Consumers 73', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577382', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29993508 AS Decimal(11, 8)), CAST(103.65894980 AS Decimal(11, 8)), N'rg.goswami73@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (187, N'Consumers 74', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577383', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24571559 AS Decimal(11, 8)), CAST(103.60666387 AS Decimal(11, 8)), N'rg.goswami74@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (188, N'Consumers 75', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577384', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.30752000 AS Decimal(11, 8)), CAST(103.70607185 AS Decimal(11, 8)), N'rg.goswami75@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (189, N'Consumers 76', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577385', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.34531642 AS Decimal(11, 8)), CAST(103.79700783 AS Decimal(11, 8)), N'rg.goswami76@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (190, N'Consumers 77', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577386', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.23947547 AS Decimal(11, 8)), CAST(104.04110461 AS Decimal(11, 8)), N'rg.goswami77@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (191, N'Consumers 78', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577387', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.29038179 AS Decimal(11, 8)), CAST(103.84923400 AS Decimal(11, 8)), N'rg.goswami78@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (192, N'Consumers 79', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577388', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.18275259 AS Decimal(11, 8)), CAST(103.72817375 AS Decimal(11, 8)), N'rg.goswami79@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (193, N'Consumers 80', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577389', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20444510 AS Decimal(11, 8)), CAST(103.84891686 AS Decimal(11, 8)), N'rg.goswami80@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (194, N'Consumers 81', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577390', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25680643 AS Decimal(11, 8)), CAST(103.65470763 AS Decimal(11, 8)), N'rg.goswami81@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (195, N'Consumers 82', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577391', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.46338385 AS Decimal(11, 8)), CAST(103.70682065 AS Decimal(11, 8)), N'rg.goswami82@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (196, N'Consumers 83', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577392', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.25300640 AS Decimal(11, 8)), CAST(103.73942333 AS Decimal(11, 8)), N'rg.goswami83@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (197, N'Consumers 84', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577393', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.42550184 AS Decimal(11, 8)), CAST(103.97824295 AS Decimal(11, 8)), N'rg.goswami84@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (198, N'Consumers 85', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577394', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.20152623 AS Decimal(11, 8)), CAST(103.65792970 AS Decimal(11, 8)), N'rg.goswami85@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (199, N'Consumers 86', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577395', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35602484 AS Decimal(11, 8)), CAST(103.66883595 AS Decimal(11, 8)), N'rg.goswami86@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (200, N'Consumers 87', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577396', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24220645 AS Decimal(11, 8)), CAST(103.82183237 AS Decimal(11, 8)), N'rg.goswami87@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (201, N'Consumers 88', NULL, NULL, 2, N'11223344', NULL, NULL, NULL, N'86577397', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.27284341 AS Decimal(11, 8)), CAST(103.97626774 AS Decimal(11, 8)), N'rg.goswami88@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (202, N'Consumers 89', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577398', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.43347620 AS Decimal(11, 8)), CAST(103.65029596 AS Decimal(11, 8)), N'rg.goswami89@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (203, N'Consumers 90', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577399', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.17569793 AS Decimal(11, 8)), CAST(103.85285700 AS Decimal(11, 8)), N'rg.goswami90@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (204, N'Consumers 91', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577400', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28312182 AS Decimal(11, 8)), CAST(103.75530786 AS Decimal(11, 8)), N'rg.goswami91@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (205, N'Consumers 92', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577401', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.27788341 AS Decimal(11, 8)), CAST(104.00723407 AS Decimal(11, 8)), N'rg.goswami92@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (206, N'Consumers 93', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577402', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35544877 AS Decimal(11, 8)), CAST(103.88058091 AS Decimal(11, 8)), N'rg.goswami93@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (207, N'Consumers 94', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577403', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.35807207 AS Decimal(11, 8)), CAST(103.61294081 AS Decimal(11, 8)), N'rg.goswami94@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (208, N'Consumers 95', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577404', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.40885893 AS Decimal(11, 8)), CAST(103.84076340 AS Decimal(11, 8)), N'rg.goswami95@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (209, N'Consumers 96', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577405', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.39000689 AS Decimal(11, 8)), CAST(103.60709596 AS Decimal(11, 8)), N'rg.goswami96@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (210, N'Consumers 97', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577406', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.24565550 AS Decimal(11, 8)), CAST(103.79858355 AS Decimal(11, 8)), N'rg.goswami97@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (211, N'Consumers 98', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577407', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.45125612 AS Decimal(11, 8)), CAST(103.74438938 AS Decimal(11, 8)), N'rg.goswami98@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (212, N'Consumers 99', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577408', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.28969402 AS Decimal(11, 8)), CAST(103.91620800 AS Decimal(11, 8)), N'rg.goswami99@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([ID], [FirstName], [LastName], [UserName], [UserType], [Password], [PasswordHash], [PasswordSalt], [RegistrationVerificationMethodType], [PhoneNumber], [PhoneNumberConfirmed], [CountryCode], [DeviceIdentityNumber], [LanguageG], [LanguageC], [Token], [SimMnc], [SimMcc], [Latitude], [Longitude], [Email], [EmailConfirmed], [DateOfBirth], [Country], [SecurityStamp], [TwoFactorEnabled], [IsActive], [IsDeleted], [LockoutEndDate], [LockoutEnabled], [AccessFailedCount], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (213, N'Consumers 100', NULL, NULL, NULL, N'11223344', NULL, NULL, NULL, N'86577409', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.32171109 AS Decimal(11, 8)), CAST(103.90502510 AS Decimal(11, 8)), N'rg.goswami100@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
print 'Processed 200 total records'
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Table [dbo].[UserExternalLogins]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserExternalLogins]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserExternalLogins](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ExternalLoginProviderId] [int] NOT NULL,
	[ProviderKey] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_UserExternalLogin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UserAvatars]    Script Date: 11/23/2015 15:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserAvatars]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserAvatars](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Avatar] [image] NULL,
 CONSTRAINT [PK_UserAvatars_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[spGetNearServiceProviders]    Script Date: 11/23/2015 15:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetNearServiceProviders]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spGetNearServiceProviders]
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
		sp.ID as ServiceProviderID,
		sp.Title,
		sp.JobDescription,
		sp.Experience,
		sp.ExpectedWages,
		sp.Province,
		sp.City,
		sp.Address,
		sp.PinCode,
		@p1.STDistance(geography::Point(u.[Latitude], u.[Longitude], 4326)) as [DistanceInKilometers]
    FROM 
		[Users] u INNER JOIN 
		dbo.ServiceProviders sp ON u.ID = sp.UserID
    WHERE 
		@p1.STDistance(geography::Point(u.[Latitude], u.[Longitude], 4326)) < @distance
		AND UserType = @userType
		
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[spGetNearLocations]    Script Date: 11/23/2015 15:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetNearLocations]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spGetNearLocations]
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
		
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[spGetNearCustomers]    Script Date: 11/23/2015 15:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGetNearCustomers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spGetNearCustomers]
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
		
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[spBlockUser]    Script Date: 11/23/2015 15:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spBlockUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spBlockUser]
(
@UserName nvarchar (30),
@Password nvarchar(30)
)
AS
BEGIN
	DECLARE @ID int=0
	Declare @tempAttempt int=0
	DECLARE @LockoutEnabled bit
	
	SELECT @tempAttempt= wrongAttempt from BlockUsers where username=@UserName
	SET @tempAttempt= @tempAttempt + 0
	
	update BlockUsers set wrongAttempt=@tempAttempt WHERE username=@UserName
	IF @tempAttempt > 20
	BEGIN
		UPDATE Users SET LockoutEnabled=1 WHERE username=@UserName
		SET @LockoutEnabled = 1
	END
	RETURN @LockoutEnabled
	SET NOCOUNT ON;
END ' 
END
GO
/****** Object:  StoredProcedure [dbo].[spAuthenticateUser]    Script Date: 11/23/2015 15:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAuthenticateUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spAuthenticateUser]
(
@UserName NVARCHAR(50),  
@Password NVARCHAR(50),
@AuthenticateResults BIT OUTPUT,
@ExceededLoginAttemptsLimit BIT OUTPUT,
@UserType INT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS(
		SELECT 
			1 FROM dbo.Users 
		WHERE 
			UserName=@UserName AND [Password]=@Password AND (LockoutEnabled IS NULL or LockoutEnabled = 0))
	BEGIN
		SELECT 
			@UserType=UserType FROM dbo.Users 
		WHERE 
			UserName=@UserName AND [Password]=@Password AND (LockoutEnabled IS NULL or LockoutEnabled = 0)
		SET @AuthenticateResults = 1 		
		SET @ExceededLoginAttemptsLimit = 0		
	END
	ELSE IF EXISTS(
		SELECT 
			1 FROM dbo.Users 
		WHERE 
			Email=@UserName AND [Password]=@Password AND (LockoutEnabled IS NULL or LockoutEnabled = 0))
	BEGIN
		SELECT 
			@UserType=UserType FROM dbo.Users 
		WHERE 
			Email=@UserName AND [Password]=@Password AND (LockoutEnabled IS NULL or LockoutEnabled = 0)
		SET @AuthenticateResults = 1 		
		SET @ExceededLoginAttemptsLimit = 0
	END
	ELSE BEGIN
		exec @ExceededLoginAttemptsLimit = spBlockUser @username,@password	
		SET @AuthenticateResults = 0 		
	END
	
	SELECT @AuthenticateResults
	SELECT @ExceededLoginAttemptsLimit 		
end' 
END
GO
