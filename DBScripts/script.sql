USE [StatisticsReportForReferenceServices]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Department_id] [int] IDENTITY(1,1) NOT NULL,
	[Department_Name] [nvarchar](50) NOT NULL,
	[Department_Domain] [nvarchar](max) NOT NULL,
	[Creation_Date] [datetime] NULL,
	[IsRealDepartment] [bit] NULL,
 CONSTRAINT [PK_Departments3] PRIMARY KEY CLUSTERED 
(
	[Department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeneralCollection]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeneralCollection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [nvarchar](50) NULL,
	[Vistor_ID] [int] NULL,
	[Vistor_Name] [nvarchar](255) NULL,
	[Counter_ID] [int] NULL,
	[Receive_Date] [datetime] NULL,
	[NoBooks] [int] NULL,
	[Creation_Date] [datetime] NULL,
	[Gender] [int] NULL,
 CONSTRAINT [PK_GeneralCollection] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[Number] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [nvarchar](50) NOT NULL,
	[Customer_Name] [nvarchar](255) NOT NULL,
	[Customer_Gender] [int] NOT NULL,
	[Receive_Date] [datetime] NULL,
	[Finsh_date] [datetime] NULL,
	[Period] [int] NOT NULL,
	[Send_Method] [int] NOT NULL,
	[Language] [int] NOT NULL,
	[Search_Type] [int] NOT NULL,
	[Degree] [int] NOT NULL,
	[Mobile] [nvarchar](50) NULL,
	[Creation_Date] [datetime] NULL,
	[Vistor_ID] [int] NULL,
	[IsBook] [bit] NOT NULL,
	[IsArticle] [bit] NOT NULL,
	[IsThesis] [bit] NOT NULL,
	[IsDocument] [bit] NOT NULL,
	[IsImage] [bit] NOT NULL,
	[IsManuscript] [bit] NOT NULL,
	[NumOfItems] [int] NULL,
	[NumOfPages] [int] NULL,
 CONSTRAINT [PK_Items1] PRIMARY KEY CLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogErrors]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogErrors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[SatckTrace] [nvarchar](max) NULL,
	[CreationDate] [datetime] NULL,
 CONSTRAINT [PK_LogErrors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[User_ID] [nvarchar](50) NOT NULL,
	[User_Name] [nvarchar](255) NULL,
	[User_Role] [nvarchar](50) NULL,
	[User_Is_Locked] [bit] NOT NULL,
	[Creation_Date] [datetime] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK_Users2] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments] ADD  CONSTRAINT [DF_Departments3_Creation_Date]  DEFAULT (getdate()) FOR [Creation_Date]
GO
ALTER TABLE [dbo].[GeneralCollection] ADD  CONSTRAINT [DF_GeneralCollection_Creation_Date]  DEFAULT (getdate()) FOR [Creation_Date]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items1_Search_Type]  DEFAULT ((0)) FOR [Search_Type]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_Degree]  DEFAULT ((3)) FOR [Degree]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items1_Creation_Date]  DEFAULT (getdate()) FOR [Creation_Date]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_IsBook]  DEFAULT ((0)) FOR [IsBook]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_IsArticle]  DEFAULT ((0)) FOR [IsArticle]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_IsThesis]  DEFAULT ((0)) FOR [IsThesis]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_IsDocument]  DEFAULT ((0)) FOR [IsDocument]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_IsImage]  DEFAULT ((0)) FOR [IsImage]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_IsManuscript]  DEFAULT ((0)) FOR [IsManuscript]
GO
ALTER TABLE [dbo].[LogErrors] ADD  CONSTRAINT [DF_LogErrors_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users2_User_Is _Locked]  DEFAULT ((0)) FOR [User_Is_Locked]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users2_Creation_Date]  DEFAULT (getdate()) FOR [Creation_Date]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_DepartmentID]  DEFAULT ((1)) FOR [DepartmentID]
GO
/****** Object:  StoredProcedure [dbo].[GeneralCollectionAdd]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GeneralCollectionAdd] 
    @User_ID nvarchar(50) = NULL,
    @Vistor_ID int = NULL,
    @Vistor_Name nvarchar(255) = NULL,
	@Gender int = NULL,
    @Counter_ID int = NULL,
    @Receive_Date datetime = NULL,
    @NoBooks int = NULL,
	@Result int out
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[GeneralCollection] ([User_ID], [Vistor_ID], [Vistor_Name],[Gender], [Counter_ID], [Receive_Date], [NoBooks])
	SELECT @User_ID, @Vistor_ID, @Vistor_Name,@Gender ,@Counter_ID, @Receive_Date, @NoBooks
	SET @Result = 1
	-- Begin Return Select <- do not remove
	SELECT [ID], [User_ID], [Vistor_ID], [Vistor_Name],[Gender], [Counter_ID], [Receive_Date], [NoBooks]
	FROM   [dbo].[GeneralCollection]
	WHERE  [ID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
	
GO
/****** Object:  StoredProcedure [dbo].[GeneralCollectionDelete]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GeneralCollectionDelete] 
    @ID int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[GeneralCollection]
	WHERE  [ID] = @ID

	COMMIT
GO
/****** Object:  StoredProcedure [dbo].[GeneralCollectionEdit]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GeneralCollectionEdit] @ID int,
@User_ID nvarchar(50) = NULL,
@Vistor_ID int = NULL,
@Vistor_Name nvarchar(255) = NULL,
@Gender int = NULL,
@Counter_ID int = NULL,
@Receive_Date datetime = NULL,
@NoBooks int = NULL
AS
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  BEGIN TRANSACTION;

    UPDATE [dbo].[GeneralCollection]
    SET [User_ID] = @User_ID,
        [Vistor_ID] = @Vistor_ID,
        [Vistor_Name] = @Vistor_Name,
        [Counter_ID] = @Counter_ID,
        [Receive_Date] = @Receive_Date,
        [NoBooks] = @NoBooks,
        [Gender] = @Gender
    WHERE [ID] = @ID;

    -- Begin Return Select <- do not remove
    SELECT
      [ID],
      [User_ID],
      [Vistor_ID],
      [Vistor_Name],
      [Gender],
      [Counter_ID],
      [Receive_Date],
      [NoBooks],
      [Creation_Date]
    FROM [dbo].[GeneralCollection]
    WHERE [ID] = @ID;
  -- End Return Select <- do not remove

  COMMIT;
GO
/****** Object:  StoredProcedure [dbo].[GeneralCollectionSearch]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GeneralCollectionSearch] 
	@ID INT,
	@User_ID NVARCHAR(50),
	@Vistor_ID INT, 
	@Vistor_Name NVARCHAR(255),
	@Gender int,
	@Counter_ID INT,
	@Receive_Date DATETIME
AS 
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;  

	BEGIN TRANSACTION;

	SELECT [ID], [User_ID], [Vistor_ID], [Vistor_Name],[Gender], [Counter_ID], [Receive_Date], [NoBooks], [Creation_Date] 
	FROM   [dbo].[GeneralCollection] 
	WHERE  ([ID] = @ID OR @ID IS NULL) 
	AND ([User_ID] = @User_ID OR @User_ID IS NULL) 
	AND ([Vistor_ID] = @Vistor_ID OR @Vistor_ID IS NULL) 
	AND ([Vistor_Name] = @Vistor_Name OR @Vistor_Name IS NULL) 
	AND([Gender] = @Gender OR @Gender IS NULL)
	AND([Counter_ID] = @Counter_ID OR @Counter_ID IS NULL) 
	AND([Receive_Date] = @Receive_Date OR @Receive_Date IS NULL); 


	COMMIT;
GO
/****** Object:  StoredProcedure [dbo].[GetAllDepartments]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllDepartments]

AS
BEGIN
	
	SELECT Department_id,
		   Department_Name,
		   Department_Domain,
		   Creation_Date
		   
	FROM   dbo.Departments
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllUsers]

AS
BEGIN
	
	SELECT User_ID,
		   User_Name,
		   User_Role,
		   User_Is_Locked,
		   Creation_Date
		   
	FROM USERS
		order by User_Name
END
GO
/****** Object:  StoredProcedure [dbo].[GetRealDepartments]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetRealDepartments]

AS
BEGIN
	
	SELECT Department_id,
		   Department_Name,
		   Department_Domain,
		   Creation_Date
		   
	FROM   dbo.Departments

	where IsRealDepartment = 1
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetRoleByUserID]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRoleByUserID]
@USER_ID as nvarchar(50)
AS
BEGIN
	
	SELECT User_Role, User_Is_Locked
		   
	FROM USERS
	
	WHERE USER_ID = @USER_ID
		
END
GO
/****** Object:  StoredProcedure [dbo].[getVistorByID]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getVistorByID]
@Vistor_ID varchar(255)
AS
BEGIN
if ISNUMERIC(@Vistor_ID)=1
 BEGIN
	SELECT
		ID,
		Name,
		Gender,
		Mobile,
		NationalID
	FROM [Visitors].[dbo].[Vistors]
	WHERE id = CONVERT(BIGINT, ISNULL( CAST(RIGHT(@Vistor_ID,15) AS VARCHAR(15)), 0))
	OR NationalID = @Vistor_ID
	OR AlternativeID =@Vistor_ID
  END;
  ELSE
  BEGIN
	SELECT
		ID,
		Name,
		Gender,
		Mobile,
		NationalID
	FROM [Visitors].[dbo].[Vistors]
	WHERE id = CONVERT(BIGINT, ISNULL( CAST(RIGHT(ISNUMERIC(@Vistor_ID),15) AS VARCHAR(15)), 0))
	OR NationalID = @Vistor_ID
	OR AlternativeID =@Vistor_ID
  END;

END
GO
/****** Object:  StoredProcedure [dbo].[IsValidUser]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IsValidUser]
@User_ID nvarchar(50)
AS
BEGIN
	
	SELECT User_ID,
		   User_Name,
		   User_Role,
		   User_Is_Locked,
		   Creation_Date
		   
	FROM USERS
	
	WHERE USER_ID = @User_ID 
		
END
GO
/****** Object:  StoredProcedure [dbo].[ItemsAdd]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham Khalil>
-- Create date: <11/11/2015	>
-- Description:	<Add New Item>
-- =============================================
CREATE PROCEDURE [dbo].[ItemsAdd] 


@User_ID	nvarchar(50),
@Vistor_ID	int,
@Customer_Name	nvarchar(255),
@Customer_Gender	int,
@Receive_Date	datetime,
@Finsh_date	datetime,
@Period	int,
@Send_Method	int,
@Language	int,
@Search_Type	int,
@Degree int,
@Mobile nvarchar(50),
@IsBook	bit	,
@IsArticle	bit	,
@IsThesis	bit	,
@IsDocument	bit	,
@IsImage	bit	,
@IsManuscript	bit	,
@NumOfItems	int	,
@NumOfPages	int,
@Result int out ,
@Number int out

AS
BEGIN
	INSERT INTO dbo.Items
	(
		dbo.Items.User_ID,
		Customer_Name,
		Customer_Gender,
		Receive_Date,
		Finsh_date,
		Period,
		Send_Method,
		dbo.Items.Language,
		Search_Type,
		Degree,
		Mobile,
		Vistor_ID,
		IsBook,
		IsArticle,
		IsThesis,
		IsDocument,
		IsImage,
		IsManuscript,
		NumOfItems	,
		NumOfPages
	)
	Values
	(
		@User_ID,
		@Customer_Name,
		@Customer_Gender,
		@Receive_Date,
		@Finsh_date,
		@Period,
		@Send_Method,
		@Language,
		@Search_Type,
		@Degree,
		@Mobile,
		@Vistor_ID,
		@IsBook,
		@IsArticle,
		@IsThesis,
		@IsDocument,
		@IsImage,
		@IsManuscript,
		@NumOfItems,
		@NumOfPages	
	)
	SET @Result = 1
	SET @Number = @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[ItemsEdit]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham Khalil>
-- Create date: <11/11/2015	>
-- Description:	<Add New Item>
-- =============================================
CREATE PROCEDURE [dbo].[ItemsEdit] 

@Number int,
@Vistor_ID int,
@Customer_Name	nvarchar(255),
@Customer_Gender	int,
@Receive_Date	datetime,
@Finsh_date	datetime,
@Period	int,
@Send_Method	int,
@Language	int,
@Search_Type	int,
@Degree int,
@Mobile nvarchar(50),
@IsBook	bit	,
@IsArticle	bit	,
@IsThesis	bit	,
@IsDocument	bit	,
@IsImage	bit	,
@IsManuscript	bit	,
@NumOfItems	int	,
@NumOfPages	int,
@Result int out 


AS
BEGIN
	UPDATE dbo.Items
	
	SET	Customer_Name=@Customer_Name,
		Customer_Gender=@Customer_Gender,
		Receive_Date=@Receive_Date,
		Finsh_date=@Finsh_date,
		Period=@Period,
		Send_Method=@Send_Method,
		dbo.Items.Language=@Language,
		Degree=@Degree,
		Mobile=@Mobile,
		Search_Type=@Search_Type,
		Vistor_ID=@Vistor_ID,
		IsBook=@IsBook,
		IsArticle=@IsArticle,
		IsThesis=@IsThesis,
		IsDocument=@IsDocument,
		IsImage=@IsImage,
		IsManuscript=@IsManuscript,
		NumOfItems=@NumOfItems,
		NumOfPages=@NumOfPages
	WHERE Number=@Number
	
	SET @Result = 1
END
GO
/****** Object:  StoredProcedure [dbo].[ItemsSearch]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham Khalil>
-- Create date: <11/11/2015	>
-- Description:	<Add New Item>
-- =============================================
CREATE PROCEDURE [dbo].[ItemsSearch]

@Number	int,
@User_ID	nvarchar(50),
@Customer_Name	nvarchar(255),
@Customer_Gender	int,
@Receive_Date	datetime,
@Finsh_date	datetime,
@Period	int,
@Send_Method	int,
@Language	int,
@Search_Type	int,
@Creation_Date	date,
@IsBook	bit	,
@IsArticle	bit	,
@IsThesis	bit	,
@IsDocument	bit	,
@IsImage	bit	,
@IsManuscript	bit	,
@NumOfItems	int	,
@NumOfPages	int

AS
BEGIN
	SELECT
		Number,
		User_ID,
		Customer_Name,
		Customer_Gender,
	    Receive_Date,--from ger to hijri
	    Finsh_date ,--from ger to hijri
		Period,
		Send_Method,
		Language,
		Creation_Date,
		Search_Type,
		Mobile,
		Degree,
		Vistor_ID,
		IsBook,
		IsArticle,	
		IsThesis,
		IsDocument,	
		IsImage,
		IsManuscript,	
		NumOfItems,
		NumOfPages
	FROM ITEMS 
	
	WHERE (Number = @Number OR @Number IS NULL)
	AND	  (USER_ID = @User_ID OR @User_ID IS NULL)
	AND	  (Customer_Name LIKE '%'+@Customer_Name+'%' OR @Customer_Name IS NULL)
	AND	  (Customer_Gender = @Customer_Gender OR @Customer_Gender IS NULL)
	AND	  (Receive_Date =  @Receive_Date OR @Receive_Date IS NULL)--from hijri to ger  
	AND	  (Finsh_date =  @Finsh_date OR @Finsh_date IS NULL)
	AND	  (Period = @Period OR @Period IS NULL)
	AND	  (Send_Method = @Send_Method  OR @Send_Method IS NULL)
	AND	  (Language = @Language OR @Language IS NULL)
	AND	  (Search_Type = @Search_Type OR @Search_Type IS NULL)
	AND	  ((CAST(Creation_Date AS date)) =  CONVERT(date,@Creation_Date, 131) OR @Creation_Date IS NULL)
	AND	  (IsBook = @IsBook OR @IsBook IS NULL)
	AND	  (IsArticle = @IsArticle OR @IsArticle IS NULL)
	AND	  (IsThesis = @IsThesis OR @IsThesis IS NULL)
	AND	  (IsDocument = @IsDocument OR @IsDocument IS NULL)
	AND	  (IsImage = @IsImage OR @IsImage IS NULL)
	AND	  (IsManuscript = @IsManuscript OR @IsManuscript IS NULL)
	AND	  (NumOfItems = @NumOfItems OR @NumOfItems IS NULL)
    AND	  (NumOfPages = @NumOfPages OR @NumOfPages IS NULL)
	
END
GO
/****** Object:  StoredProcedure [dbo].[ItemsSearchWithUsers]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham Khalil>
-- Create date: <11/11/2015	>
-- Description:	<Add New Item>
-- =============================================
CREATE PROCEDURE [dbo].[ItemsSearchWithUsers]

@Number	int,
@User_ID	nvarchar(50),
@Customer_Name	nvarchar(255),
@Customer_Gender	int,
@Receive_Date	datetime,
@Finsh_date	datetime,
@Period	int,
@Send_Method	int,
@Language	int,
@UserName nvarchar(50),
@DepartmentID int,
@Creation_Date	nvarchar(50),
@IsBook	bit	,
@IsArticle	bit	,
@IsThesis	bit	,
@IsDocument	bit	,
@IsImage	bit	,
@IsManuscript	bit	,
@NumOfItems	int	,
@NumOfPages	int

AS
BEGIN
	SELECT
		Number,
		i.User_ID,
		u.User_Name,
		Customer_Name,
		Customer_Gender,
	    Receive_Date ,--from ger to hijri
	    Finsh_date ,--from ger to hijri
		Period,
		Send_Method,
		Language,
		Search_Type,
		Mobile,
		Degree,
		i.Creation_Date,
		d.Department_Name, 
		Vistor_ID,
		IsBook,
		IsArticle,
		IsThesis,
		IsDocument,
		IsImage,
		IsManuscript,
		NumOfItems	,
		NumOfPages	
		
	FROM ITEMS i
	INNER JOIN Users u
	ON u.User_ID = i.User_ID
	INNER JOIN Departments d 
	ON u.DepartmentID = d.Department_id
	
	WHERE (Number = @Number OR @Number IS NULL)
	AND	  (i.USER_ID = @User_ID OR @User_ID IS NULL)
	AND	  (Customer_Name LIKE '%'+@Customer_Name+'%'OR @Customer_Name ='' OR @Customer_Name IS NULL)
	AND	  (u.User_Name LIKE '%'+@UserName+'%' OR @UserName = '' OR @UserName IS NULL)
	AND	  (Customer_Gender = @Customer_Gender OR @Customer_Gender IS NULL)
	AND	  (Receive_Date >= @Receive_Date OR @Receive_Date = '' OR @Receive_Date IS NULL)--from hijri to ger  
	AND	  (Receive_Date <=  @Finsh_date OR @Finsh_date = '' OR @Finsh_date IS NULL)--from hijri to ger  
	AND	  (Period = @Period OR @Period IS NULL)
	AND	  (Send_Method = @Send_Method  OR @Send_Method IS NULL)
	AND	  (Language = @Language OR @Language IS NULL)
--	AND	  ((CAST(i.Creation_Date AS date))=CONVERT(date,@Creation_Date, 131) OR @Creation_Date='' OR @Creation_Date IS NULL)
	AND	  (u.DepartmentID= @DepartmentID OR @DepartmentID IS NULL)
	AND	  (IsBook = @IsBook OR @IsBook IS NULL)
	AND	  (IsArticle = @IsArticle OR @IsArticle IS NULL)
	AND	  (IsThesis = @IsThesis OR @IsThesis IS NULL)
	AND	  (IsDocument = @IsDocument OR @IsDocument IS NULL)
	AND	  (IsImage = @IsImage OR @IsImage IS NULL)
	AND	  (IsManuscript = @IsManuscript OR @IsManuscript IS NULL)
	AND	  (NumOfItems = @NumOfItems OR @NumOfItems IS NULL)
    AND	  (NumOfPages = @NumOfPages OR @NumOfPages IS NULL)
	Order By i.Creation_Date Desc
END
GO
/****** Object:  StoredProcedure [dbo].[LogErrorAdd]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<hisham>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LogErrorAdd]
@Message nvarchar(max),
@SatckTrace nvarchar(max)
AS
BEGIN
	INSERT INTO LogErrors
	(
		Message,
		SatckTrace
	)
	VALUES
	(
		@Message,
		@SatckTrace
	)
	
END
GO
/****** Object:  StoredProcedure [dbo].[StatisticsSearch]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham Khalil>
-- Create date: <11/11/2015	>
-- Description:	<Add New Item>
-- =============================================
CREATE PROCEDURE [dbo].[StatisticsSearch]

@Receive_Date	datetime,
@Finsh_date	datetime,
@UserName nvarchar(50),
@Gender int,
@DepartmentId int

AS
BEGIN
	SELECT
		Customer_Gender,
		Period,
		Send_Method,
		Language,
		Search_Type,
		i.Creation_Date,
		Degree,
		IsBook,
		IsArticle,
		IsThesis,
		IsDocument,
		IsImage,
		IsManuscript,
		NumOfItems	,
		NumOfPages
		
	FROM ITEMS i
	INNER JOIN Users u
	ON u.User_ID = i.User_ID

	WHERE	  (User_Name LIKE '%'+@UserName+'%' OR @UserName = '' OR @UserName IS NULL)
	AND	  (i.Receive_Date >=  @Receive_Date OR @Receive_Date = '' OR @Receive_Date IS NULL)--from hijri to ger  
	AND	  (i.Receive_Date  <=  @Finsh_date OR @Finsh_date = '' OR @Finsh_date IS NULL)--from hijri to ger  
	AND   (Customer_Gender = @Gender OR @Gender IS NULL)
	AND   (DepartmentID = @DepartmentId OR @DepartmentId IS NULL)
END
GO
/****** Object:  StoredProcedure [dbo].[User_Is_LockedEdit]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[User_Is_LockedEdit]
@User_ID	nvarchar(50)	
AS
BEGIN
	
	UPDATE USERS
	
	SET	User_Is_Locked=~User_Is_Locked
		
	WHERE User_ID=@User_ID

END
GO
/****** Object:  StoredProcedure [dbo].[UsersAdd]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UsersAdd]
@User_ID	nvarchar(50),	
@User_Name	nvarchar(255),	
@User_Role	nvarchar(50),
@DepartmentID	 int,
@Result int out
AS
BEGIN
	
	INSERT INTO USERS
	(
		User_ID,
		User_Name,
		User_Role,
		DepartmentID
	)
	VALUES
	(
		@User_ID,
		@User_Name,
		@User_Role,
		@DepartmentID
	)
	
	SET @Result = 1
END
GO
/****** Object:  StoredProcedure [dbo].[UsersDelete]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hisham>
-- Create date: <11/08/2015>
-- Description:	<UsersDelete>
-- =============================================
CREATE PROCEDURE [dbo].[UsersDelete] 
@User_ID nvarchar(50)
AS
BEGIN
	DELETE FROM Users 
	WHERE User_ID = @User_ID
END
GO
/****** Object:  StoredProcedure [dbo].[UsersEdit]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UsersEdit]
@User_ID	nvarchar(50),	
@User_Name	nvarchar(255),	
@User_Role	nvarchar(50),
@DepartmentID	 int,
@Result int out
AS
BEGIN
	
	UPDATE USERS
	
	SET	User_Name=@User_Name,
		User_Role=@User_Role,
		DepartmentID= @DepartmentID

	WHERE User_ID=@User_ID
		
	SET @Result = 1
END
GO
/****** Object:  StoredProcedure [dbo].[UsersSearch]    Script Date: 2/9/2021 4:29:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Hisham>
-- Create date: <5/11/2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UsersSearch]
@User_ID nvarchar(50)
AS
BEGIN
	
	SELECT User_ID,
		   User_Name,
		   User_Role,
		   User_Is_Locked,
		   Creation_Date,
		   DepartmentID
		   
	FROM USERS
	WHERE (User_ID= @User_ID OR @User_ID IS NULL)
	order by User_Name
END
GO
