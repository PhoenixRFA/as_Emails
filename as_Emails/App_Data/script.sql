USE [Core]
GO
/****** Object:  Table [dbo].[as_emails]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[as_emails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](256) NOT NULL,
	[template] [nvarchar](max) NOT NULL,
	[subject] [nvarchar](max) NOT NULL,
	[from] [nvarchar](128) NOT NULL,
	[to] [nvarchar](128) NOT NULL,
	[cc] [nvarchar](128) NULL,
	[bcc] [nvarchar](128) NULL,
 CONSTRAINT [PK_as_emails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[as_emailsLog]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[as_emailsLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[created] [datetime] NOT NULL,
	[createdBy] [nvarchar](128) NOT NULL,
	[emailID] [int] NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[from] [nvarchar](128) NOT NULL,
	[to] [nvarchar](128) NOT NULL,
	[details] [nvarchar](128) NULL,
 CONSTRAINT [PK_as_emailsLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[as_emailsLog]  WITH CHECK ADD  CONSTRAINT [FK_as_emailsLog_as_emails] FOREIGN KEY([emailID])
REFERENCES [dbo].[as_emails] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[as_emailsLog] CHECK CONSTRAINT [FK_as_emailsLog_as_emails]
GO
/****** Object:  StoredProcedure [dbo].[as_createMail]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[as_createMail]
	@code nvarchar(128),
	@template nvarchar(max),
	@subject nvarchar(max),
	@from nvarchar(128),
	@to nvarchar(128),
	@cc nvarchar(128),
	@bcc nvarchar(128)
AS
SET NOCOUNT ON;
INSERT dbo.as_emails VALUES (@code, @template,@subject, @from, @to, @cc, @bcc)
SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [dbo].[as_deleteMailById]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[as_deleteMailById]
	@id int
AS
SET NOCOUNT ON;
DELETE FROM dbo.as_emails WHERE id = @id;
SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [dbo].[as_editMail]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[as_editMail]
    @id int,
    @code nvarchar(128) = NULL,
	@template nvarchar(max) = NULL,
	@subject nvarchar(max) = NULL,
	@from nvarchar(128) = NULL,
	@to nvarchar(128) = NULL,
	@cc nvarchar(128) = NULL,
	@bcc nvarchar(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.as_emails
    SET code=ISNULL(@code,code), 
        template=ISNULL(@template,template), 
        [subject]=ISNULL(@subject,[subject]),
		[from]=ISNULL(@from,[from]),
		[to]=ISNULL(@to,[to]),
		cc=ISNULL(@cc,cc),
		bcc=ISNULL(@bcc,bcc)
    WHERE id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[as_getAllMails]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[as_getAllMails]
AS
SET NOCOUNT ON;
SELECT * FROM dbo.as_emails
SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [dbo].[as_getMailsByCode]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[as_getMailsByCode]
	@code NVARCHAR(50)
AS
SET NOCOUNT ON;
SELECT * FROM dbo.as_emails WHERE code=@code;
SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [dbo].[as_logMails]    Script Date: 22.01.2019 12:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[as_logMails]
	@createdBy nvarchar(128),
	@emailID int,
	@subject nvarchar(max),
	@text nvarchar(max),
	@from nvarchar(128),
	@to nvarchar(128),
	@details nvarchar(128)
AS
SET NOCOUNT ON;
INSERT dbo.as_emailsLog VALUES (GETDATE(), @createdBy, @emailID,('['+@subject+'] '+@text), @from, @to, @details);
SET NOCOUNT OFF;
GO
