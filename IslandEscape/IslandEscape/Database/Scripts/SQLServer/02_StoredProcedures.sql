/*
Name:   Tonta Jonathan
Date:   28/06/2026
Title:  Island Escape Adventures
*/
USE [IslandEscapeDB]
GO

DROP PROCEDURE IF EXISTS [dbo].[sp_BackupDatabase]
GO

CREATE PROCEDURE [dbo].[sp_BackupDatabase]
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @BackupPath NVARCHAR(500) = 'C:\SQLBackups\'
    DECLARE @FileName NVARCHAR(500)
    DECLARE @ErrorMsg NVARCHAR(1000)
    
    SET @FileName = @BackupPath + 'IslandEscapeDB_' + 
                    REPLACE(REPLACE(CONVERT(NVARCHAR(20), GETDATE(), 120), ':', ''), '-', '') + 
                    '.bak'
    
    BEGIN TRY
        BACKUP DATABASE [IslandEscapeDB] 
        TO DISK = @FileName
        WITH 
            FORMAT,
            INIT,
            SKIP,
            STATS = 10
        
        PRINT 'Backup successful: ' + @FileName
    END TRY
    BEGIN CATCH
        SET @ErrorMsg = ERROR_MESSAGE()
        PRINT 'Backup failed: ' + @ErrorMsg
        RAISERROR(@ErrorMsg, 16, 1)
    END CATCH
END
GO