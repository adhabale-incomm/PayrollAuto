-- <Migration ID="7d94aff1-be3e-4b9a-99b2-3f63bb3debdd" />
GO

PRINT N'Creating [dbo].[Emp]'
GO
CREATE TABLE [dbo].[Emp]
(
[Id] [int] NOT NULL,
[Name] [varchar] (50) NULL
)
GO
PRINT N'Creating primary key [PK__Emp__3214EC073199475A] on [dbo].[Emp]'
GO
ALTER TABLE [dbo].[Emp] ADD CONSTRAINT [PK__Emp__3214EC073199475A] PRIMARY KEY CLUSTERED  ([Id])
GO
