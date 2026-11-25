/*
Name:   Tonta Jonathan
Date:   28/06/2026
Title:  Island Escape Adventures
*/

-- Database Schema Creation
USE [IslandEscapeDB]
GO

-- Create USERS TABLE
CREATE TABLE [dbo].[Users] (
    [UserID]        INT             IDENTITY(1,1) NOT NULL,
    [Username]      NVARCHAR(50)    NOT NULL UNIQUE,
    [Email]         NVARCHAR(100)   NOT NULL UNIQUE,
    [PasswordHash]  NVARCHAR(255)   NOT NULL,
    [Salt]          NVARCHAR(50)    NOT NULL,
    [FullName]      NVARCHAR(100)   NOT NULL,
    [Phone]         NVARCHAR(20)    NULL,
    [Address]       NVARCHAR(255)   NULL,
    [Role]          NVARCHAR(20)    NOT NULL DEFAULT 'Customer',
    [IsActive]      BIT             NOT NULL DEFAULT 1,
    [CreatedDate]   DATETIME        NOT NULL DEFAULT GETDATE(),
    [LastLoginDate] DATETIME        NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserID] ASC)
)
GO

CREATE NONCLUSTERED INDEX [IX_Users_Email] ON [dbo].[Users] ([Email])
GO
CREATE NONCLUSTERED INDEX [IX_Users_Username] ON [dbo].[Users] ([Username])
GO


-- Create PASSWORD RESET TOKENS
CREATE TABLE [dbo].[PasswordResetTokens] (
    [TokenID]    INT             IDENTITY(1,1) NOT NULL,
    [UserID]     INT             NOT NULL,
    [Token]      NVARCHAR(255)   NOT NULL UNIQUE,
    [ExpiryDate] DATETIME        NOT NULL,
    [Used]       BIT             NOT NULL DEFAULT 0,
    [CreatedDate] DATETIME       NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_PasswordResetTokens] PRIMARY KEY CLUSTERED ([TokenID] ASC),
    CONSTRAINT [FK_PasswordResetTokens_Users] FOREIGN KEY ([UserID])
        REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_PasswordResetTokens_Token] ON [dbo].[PasswordResetTokens] ([Token])
GO

-- Create CATEGORIES TABLE
CREATE TABLE [dbo].[Categories] (
    [CategoryID]   INT             IDENTITY(1,1) NOT NULL,
    [Name]         NVARCHAR(50)    NOT NULL UNIQUE,
    [Description]  NVARCHAR(255)   NULL,
    [Icon]         NVARCHAR(50)    NULL,
    [DisplayOrder] INT             NOT NULL DEFAULT 0,
    [IsActive]     BIT             NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
)
GO

-- Create PACKAGES TABLE
CREATE TABLE [dbo].[Packages] (
    [PackageID]      INT             IDENTITY(1,1) NOT NULL,
    [CategoryID]     INT             NOT NULL,
    [Name]           NVARCHAR(100)   NOT NULL,
    [Description]    NVARCHAR(2000)  NOT NULL,
    [Price]          DECIMAL(18,2)   NOT NULL,
    [DiscountedPrice] DECIMAL(18,2)  NULL,
    [Duration]       NVARCHAR(50)    NULL,
    [Location]       NVARCHAR(100)   NOT NULL,
    [MaxPersons]     INT             NOT NULL DEFAULT 2,
    [ImageURL]       NVARCHAR(255)   NULL,
    [IsFeatured]     BIT             NOT NULL DEFAULT 0,
    [IsActive]       BIT             NOT NULL DEFAULT 1,
    [CreatedDate]    DATETIME        NOT NULL DEFAULT GETDATE(),
    [UpdatedDate]    DATETIME        NULL,
    CONSTRAINT [PK_Packages] PRIMARY KEY CLUSTERED ([PackageID] ASC),
    CONSTRAINT [FK_Packages_Categories] FOREIGN KEY ([CategoryID])
        REFERENCES [dbo].[Categories] ([CategoryID]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_Packages_CategoryID] ON [dbo].[Packages] ([CategoryID])
GO
CREATE NONCLUSTERED INDEX [IX_Packages_Location] ON [dbo].[Packages] ([Location])
GO
CREATE NONCLUSTERED INDEX [IX_Packages_Price] ON [dbo].[Packages] ([Price])
GO

-- Create PACKAGE IMAGES
CREATE TABLE [dbo].[PackageImages] (
    [ImageID]    INT             IDENTITY(1,1) NOT NULL,
    [PackageID]  INT             NOT NULL,
    [ImageURL]   NVARCHAR(255)   NOT NULL,
    [IsPrimary]  BIT             NOT NULL DEFAULT 0,
    [SortOrder]  INT             NOT NULL DEFAULT 0,
    CONSTRAINT [PK_PackageImages] PRIMARY KEY CLUSTERED ([ImageID] ASC),
    CONSTRAINT [FK_PackageImages_Packages] FOREIGN KEY ([PackageID])
        REFERENCES [dbo].[Packages] ([PackageID]) ON DELETE CASCADE
)
GO

-- Create PACKAGE REVIEWS
CREATE TABLE [dbo].[PackageReviews] (
    [ReviewID]   INT             IDENTITY(1,1) NOT NULL,
    [PackageID]  INT             NOT NULL,
    [UserID]     INT             NOT NULL,
    [Rating]     INT             NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
    [Title]      NVARCHAR(100)   NULL,
    [Comment]    NVARCHAR(1000)  NULL,
    [IsApproved] BIT             NOT NULL DEFAULT 0,
    [ReviewDate] DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_PackageReviews] PRIMARY KEY CLUSTERED ([ReviewID] ASC),
    CONSTRAINT [FK_PackageReviews_Packages] FOREIGN KEY ([PackageID])
        REFERENCES [dbo].[Packages] ([PackageID]) ON DELETE CASCADE,
    CONSTRAINT [FK_PackageReviews_Users] FOREIGN KEY ([UserID])
        REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_PackageReviews_PackageID] ON [dbo].[PackageReviews] ([PackageID])
GO

-- Create BOOKINGS
CREATE TABLE [dbo].[Bookings] (
    [BookingID]      INT             IDENTITY(1,1) NOT NULL,
    [UserID]         INT             NOT NULL,
    [BookingNumber]  NVARCHAR(20)    NOT NULL UNIQUE,
    [PackageID]      INT             NOT NULL,
    [BookingDate]    DATETIME        NOT NULL DEFAULT GETDATE(),
    [TravelDate]     DATE            NULL,
    [NumPersons]     INT             NOT NULL DEFAULT 1,
    [TotalAmount]    DECIMAL(18,2)   NOT NULL,
    [Status]         NVARCHAR(20)    NOT NULL DEFAULT 'Pending',
    [PaymentStatus]  NVARCHAR(20)    NOT NULL DEFAULT 'Pending',
    [PaymentMethod]  NVARCHAR(50)    NULL,
    [TransactionID]  NVARCHAR(100)   NULL,
    [SpecialRequests] NVARCHAR(500)  NULL,
    [IsActive]       BIT             NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Bookings] PRIMARY KEY CLUSTERED ([BookingID] ASC),
    CONSTRAINT [FK_Bookings_Users] FOREIGN KEY ([UserID])
        REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Bookings_Packages] FOREIGN KEY ([PackageID])
        REFERENCES [dbo].[Packages] ([PackageID]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_Bookings_UserID] ON [dbo].[Bookings] ([UserID])
GO
CREATE NONCLUSTERED INDEX [IX_Bookings_BookingNumber] ON [dbo].[Bookings] ([BookingNumber])
GO

-- Create SHOPPING CART
CREATE TABLE [dbo].[Cart] (
    [CartID]     INT             IDENTITY(1,1) NOT NULL,
    [UserID]     INT             NOT NULL,
    [PackageID]  INT             NOT NULL,
    [Quantity]   INT             NOT NULL DEFAULT 1,
    [Price]      DECIMAL(18,2)   NOT NULL,
    [AddedDate]  DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED ([CartID] ASC),
    CONSTRAINT [FK_Cart_Users] FOREIGN KEY ([UserID])
        REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Cart_Packages] FOREIGN KEY ([PackageID])
        REFERENCES [dbo].[Packages] ([PackageID]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_Cart_UserID] ON [dbo].[Cart] ([UserID])
GO

-- Create QUERIES / CONTACT MESSAGES
CREATE TABLE [dbo].[Queries] (
    [QueryID]       INT             IDENTITY(1,1) NOT NULL,
    [UserID]        INT             NULL,
    [Name]          NVARCHAR(100)   NOT NULL,
    [Email]         NVARCHAR(100)   NOT NULL,
    [Subject]       NVARCHAR(200)   NOT NULL,
    [Message]       NVARCHAR(2000)  NOT NULL,
    [Status]        NVARCHAR(20)    NOT NULL DEFAULT 'New',
    [SubmittedDate] DATETIME        NOT NULL DEFAULT GETDATE(),
    [RepliedDate]   DATETIME        NULL,
    [AdminReply]    NVARCHAR(2000)  NULL,
    CONSTRAINT [PK_Queries] PRIMARY KEY CLUSTERED ([QueryID] ASC),
    CONSTRAINT [FK_Queries_Users] FOREIGN KEY ([UserID])
        REFERENCES [dbo].[Users] ([UserID]) ON DELETE SET NULL
)
GO

-- Create AUDIT LOGS
CREATE TABLE [dbo].[AuditLogs] (
    [LogID]       INT             IDENTITY(1,1) NOT NULL,
    [UserID]      INT             NULL,
    [Action]      NVARCHAR(50)    NOT NULL,
    [Description] NVARCHAR(500)   NOT NULL,
    [IPAddress]   NVARCHAR(50)    NULL,
    [Timestamp]   DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED ([LogID] ASC),
    CONSTRAINT [FK_AuditLogs_Users] FOREIGN KEY ([UserID])
        REFERENCES [dbo].[Users] ([UserID]) ON DELETE SET NULL
)
GO

CREATE NONCLUSTERED INDEX [IX_AuditLogs_Timestamp] ON [dbo].[AuditLogs] ([Timestamp] DESC)
GO

-- Create SETTINGS TABLE
CREATE TABLE [dbo].[Settings] (
    [SettingID]    INT             IDENTITY(1,1) NOT NULL,
    [SettingKey]   NVARCHAR(50)    NOT NULL UNIQUE,
    [SettingValue] NVARCHAR(500)   NOT NULL,
    [Description]  NVARCHAR(255)   NULL,
    CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED ([SettingID] ASC)
)
GO