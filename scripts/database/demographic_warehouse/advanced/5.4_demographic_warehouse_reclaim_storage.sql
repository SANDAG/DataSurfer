
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DBCC SHRINKFILE (N'demographic_warehouse_data' , 10240)
GO
DBCC SHRINKFILE (N'demographic_warehouse_log' , 0)
GO

USE [master]
GO
ALTER DATABASE [demographic_warehouse] SET RECOVERY SIMPLE WITH NO_WAIT
GO