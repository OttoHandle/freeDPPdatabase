CREATE DATABASE dpp
GO
USE dpp
GO


/* ------------------------------------------------------------------ */
/* ------------------------------ User ------------------------------ */
/* ------------------------------------------------------------------ */
--Create Server User
IF NOT EXISTS (
    SELECT 1 FROM sys.server_principals WHERE name = 'dpp_writer'
)
BEGIN
    CREATE LOGIN dpp_writer WITH PASSWORD = 'Password01!';
END

IF NOT EXISTS (
    SELECT 1 FROM sys.server_principals WHERE name = 'dpp_reader'
)
BEGIN
    CREATE LOGIN dpp_reader WITH PASSWORD = 'Password02!';
END

--Create DB User
CREATE USER dpp_writer FOR LOGIN dpp_writer;
CREATE USER dpp_reader FOR LOGIN dpp_reader;

--Assign Roles
ALTER ROLE db_datareader ADD MEMBER dpp_writer;
ALTER ROLE db_datawriter ADD MEMBER dpp_writer;
ALTER ROLE db_datareader ADD MEMBER dpp_reader;

GO



/* -------------------------------------------------------------------- */
/* ------------------------------ Tables ------------------------------ */
/* -------------------------------------------------------------------- */

/* -------------------- dpp -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dpp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[jubaCode] [char](6) NOT NULL,
	[dppCode] [char](10) NOT NULL,
	[dppGUID] [uniqueidentifier] NOT NULL,
	[eoGUID] [uniqueidentifier] NOT NULL,
	[facilityGUID] [uniqueidentifier] NOT NULL,
	[sectorGUID] [uniqueidentifier] NOT NULL,
	[productID] [varchar](30) NOT NULL,
	[lotNumber] [varchar](30) NOT NULL,
	[serialNumber] [varchar](30) NOT NULL,
	[dppIdentifier] [varchar](300) NOT NULL,
	[dppSchemaVersion] [varchar](20) NOT NULL,
	[dppStatus] [varchar](8) NOT NULL,
	[dppGranularity] [char](5) NOT NULL,
	[registryID] [varchar](30) NOT NULL,
	[lastUpdated] [datetime] NOT NULL,
	[isArchive] [bit] NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[zolltarifnum] [varchar](11) NOT NULL,
	[prodName] [nvarchar](120) NOT NULL,
	[compCode] [char](6) NOT NULL,
	[prodID] [int] NOT NULL,
	[inheritsFrom] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dpp] PRIMARY KEY CLUSTERED 
(
	[dppGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dpp_dppGUID] UNIQUE NONCLUSTERED 
(
	[dppGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppEan2Dpp -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppEan2Dpp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ean] [char](13) NOT NULL,
	[dppGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_dppEan2Dpp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppEan2Dpp_ean_dppGUID] UNIQUE NONCLUSTERED 
(
	[ean] ASC,
	[dppGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppEconomicOperator -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppEconomicOperator](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[jubaCode] [char](6) NOT NULL,
	[dppCode] [char](10) NOT NULL,
	[dppURL] [varchar](40) NOT NULL,
	[eoGUID] [uniqueidentifier] NOT NULL,
	[eoLEI] [char](20) NOT NULL,
	[eoName] [nvarchar](120) NOT NULL,
	[eoName2] [nvarchar](120) NOT NULL,
	[eoZIP] [varchar](6) NOT NULL,
	[eoCity] [nvarchar](120) NOT NULL,
	[eoStreet] [nvarchar](120) NOT NULL,
	[eoGLN] [varchar](13) NOT NULL,
	[eoCountryCode] [char](2) NOT NULL,
	[eoMail] [varchar](80) NOT NULL,
	[eoURL] [varchar](80) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[isEo] [bit] NOT NULL,
	[isFacility] [bit] NOT NULL,
 CONSTRAINT [PK_dppEconomicOperator] PRIMARY KEY CLUSTERED 
(
	[eoGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppEconomicOperator_eoGUID] UNIQUE NONCLUSTERED 
(
	[eoGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppParamResource -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppParamResource](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[resourceGUID] [uniqueidentifier] NOT NULL,
	[contentType] [varchar](50) NOT NULL,
	[url] [varchar](200) NOT NULL,
	[resourceTitle] [nvarchar](100) NOT NULL,
	[langcode] [char](5) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[zuValueGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_dppParamResource] PRIMARY KEY CLUSTERED 
(
	[resourceGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppParamValue -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppParamValue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dppGUID] [uniqueidentifier] NOT NULL,
	[paramValue] [varchar](max) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[listorder] [int] NOT NULL,
	[p2cGUID] [uniqueidentifier] NOT NULL,
	[valueGUID] [uniqueidentifier] NOT NULL,
	[zuValueGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dppParamValue] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppParamValue_valueGUID] UNIQUE NONCLUSTERED 
(
	[valueGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppParamValueList -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppParamValueList](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dppGUID] [uniqueidentifier] NOT NULL,
	[paramValueGuid] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[p2cGUID] [uniqueidentifier] NOT NULL,
	[zuValueGUID] [uniqueidentifier] NOT NULL,
	[valueGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dppParamValueList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppParamValueList_valueGUID] UNIQUE NONCLUSTERED 
(
	[valueGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoCriteria -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoCriteria](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[critGUID] [uniqueidentifier] NOT NULL,
	[clause] [char](2) NOT NULL,
	[critName] [nvarchar](120) NOT NULL,
	[critDescription] [nvarchar](max) NOT NULL,
	[critShortName] [varchar](50) NOT NULL,
	[createdTime] [datetime] NOT NULL,
 CONSTRAINT [PK_dppRepoCriteria] PRIMARY KEY CLUSTERED 
(
	[critGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoCriteria_clause_critName] UNIQUE NONCLUSTERED 
(
	[clause] ASC,
	[critName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoCriteria_critGUID] UNIQUE NONCLUSTERED 
(
	[critGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoCriteria_critShortName] UNIQUE NONCLUSTERED 
(
	[critShortName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppRepoLegal -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoLegal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[legalGUID] [uniqueidentifier] NOT NULL,
	[legalName] [nvarchar](120) NOT NULL,
	[legalDescription] [nvarchar](max) NOT NULL,
	[legalValidFrom] [datetimeoffset](7) NOT NULL,
	[legaltype] [varchar](20) NOT NULL,
	[legalUri] [varchar](200) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[replacesLegalGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dppRepoLegal] PRIMARY KEY CLUSTERED 
(
	[legalGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoLegal_legalGUID] UNIQUE NONCLUSTERED 
(
	[legalGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoLegal_legalName_legalValidFrom] UNIQUE NONCLUSTERED 
(
	[legalName] ASC,
	[legalValidFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppRepoLegal2Sector -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoLegal2Sector](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[legalGUID] [uniqueidentifier] NOT NULL,
	[sectorGUID] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[isMandatory] [bit] NOT NULL,
 CONSTRAINT [PK_dppRepoLegal2Sector] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoLegal2Sector_legalGUID_sectorGUID] UNIQUE NONCLUSTERED 
(
	[legalGUID] ASC,
	[sectorGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoParam -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoParam](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[paramGUID] [uniqueidentifier] NOT NULL,
	[paramName] [nvarchar](120) NOT NULL,
	[paramDescription] [nvarchar](max) NOT NULL,
	[paramValueType] [varchar](20) NOT NULL,
	[isValueList] [tinyint] NOT NULL,
	[teststandardGUID] [uniqueidentifier] NOT NULL,
	[standardGUID] [uniqueidentifier] NOT NULL,
	[bandwidth] [decimal](12, 4) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[isUsuallyMandatory] [bit] NOT NULL,
	[isUsuallyDynamic] [bit] NOT NULL,
	[unitGUID] [uniqueidentifier] NOT NULL,
	[writtenName] [nvarchar](120) NOT NULL,
	[activeUntil] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_dppRepoParam] PRIMARY KEY CLUSTERED 
(
	[paramGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoParam_paramGUID] UNIQUE NONCLUSTERED 
(
	[paramGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoParam_paramName] UNIQUE NONCLUSTERED 
(
	[paramName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppRepoParam2Crit -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoParam2Crit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[global] [bit] NOT NULL,
	[paramGUID] [uniqueidentifier] NOT NULL,
	[critGUID] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[isMandatory] [bit] NOT NULL,
	[collGUID] [uniqueidentifier] NOT NULL,
	[p2cGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_dppRepoParam2Crit] PRIMARY KEY CLUSTERED 
(
	[p2cGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoParam2Crit_p2cGUID] UNIQUE NONCLUSTERED 
(
	[p2cGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoParam2CritExclValue -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoParam2CritExclValue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[v2pGUID] [uniqueidentifier] NOT NULL,
	[p2cGUID] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
 CONSTRAINT [pk_dppRepoParam2CritExclValue] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoParam2CritExclValue_v2pGUID_p2cGUID] UNIQUE NONCLUSTERED 
(
	[v2pGUID] ASC,
	[p2cGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoParam2Sector -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoParam2Sector](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sectorGUID] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[isMandatory] [bit] NOT NULL,
	[isDynamic] [bit] NOT NULL,
	[p2cGUID] [uniqueidentifier] NOT NULL,
	[p2sGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_dppRepoParam2Sector] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoParam2Sector_p2cGUID_sectorGUID] UNIQUE NONCLUSTERED 
(
	[p2cGUID] ASC,
	[sectorGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoParam2Sector_p2sGUID] UNIQUE NONCLUSTERED 
(
	[p2sGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoParam2SectorExclValue -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoParam2SectorExclValue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[v2pGUID] [uniqueidentifier] NOT NULL,
	[p2sGUID] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
 CONSTRAINT [pk_dppRepoParam2SectorExclValue] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoParam2SectorExclValue_v2pGUID_p2sGUID] UNIQUE NONCLUSTERED 
(
	[v2pGUID] ASC,
	[p2sGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoSector -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoSector](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sectorGUID] [uniqueidentifier] NOT NULL,
	[sectorCode] [varchar](20) NOT NULL,
	[sectorName] [nvarchar](120) NOT NULL,
	[sectorDescription] [nvarchar](max) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[isFolder] [bit] NOT NULL,
	[zu_guid] [uniqueidentifier] NOT NULL,
	[isDestructionProhibited] [bit] NOT NULL,
	[writtenName] [nvarchar](120) NOT NULL,
 CONSTRAINT [PK_dppRepoSector] PRIMARY KEY CLUSTERED 
(
	[sectorGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoSector_sectorCode] UNIQUE NONCLUSTERED 
(
	[sectorCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoSector_sectorGUID] UNIQUE NONCLUSTERED 
(
	[sectorGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoSector_sectorName] UNIQUE NONCLUSTERED 
(
	[sectorName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppRepoStandard -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoStandard](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[standardGUID] [uniqueidentifier] NOT NULL,
	[standardName] [nvarchar](120) NOT NULL,
	[standardDescription] [nvarchar](max) NOT NULL,
	[standardReference] [varchar](40) NOT NULL,
	[standardFullReference] [varchar](40) NOT NULL,
	[standardValidFrom] [datetimeoffset](7) NOT NULL,
	[standardtype] [varchar](20) NOT NULL,
	[standardUri] [varchar](200) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[replacesStandardGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dppRepoStandard] PRIMARY KEY CLUSTERED 
(
	[standardGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoStandard_standardGUID] UNIQUE NONCLUSTERED 
(
	[standardGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoStandard_standardReference_standardFullReference] UNIQUE NONCLUSTERED 
(
	[standardReference] ASC,
	[standardFullReference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppRepoStandard2Sector -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoStandard2Sector](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[standardGUID] [uniqueidentifier] NOT NULL,
	[sectorGUID] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[isMandatory] [bit] NOT NULL,
 CONSTRAINT [PK_dppRepoStandard2Sector] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoStandard2Sector_standardGUID_sectorGUID] UNIQUE NONCLUSTERED 
(
	[standardGUID] ASC,
	[sectorGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoTrans -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoTrans](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sourceGUID] [uniqueidentifier] NOT NULL,
	[sourceTable] [varchar](20) NOT NULL,
	[TransName] [nvarchar](120) NOT NULL,
	[TransDescription] [nvarchar](max) NOT NULL,
	[langcode] [char](5) NOT NULL,
	[createdTime] [datetime] NOT NULL,
 CONSTRAINT [pk_dppRepoTrans] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoTrans_sourceGUID_sourceTable_langcode] UNIQUE NONCLUSTERED 
(
	[sourceGUID] ASC,
	[sourceTable] ASC,
	[langcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppRepoUnit -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoUnit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[unitGUID] [uniqueidentifier] NOT NULL,
	[unitName] [nvarchar](120) NOT NULL,
	[unit] [nvarchar](10) NOT NULL,
	[unitDescription] [nvarchar](max) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[langcode] [char](6) NOT NULL,
 CONSTRAINT [pk_dppRepoUnit] PRIMARY KEY CLUSTERED 
(
	[unitGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoUnit_unit] UNIQUE NONCLUSTERED 
(
	[unit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoUnit_unitGUID] UNIQUE NONCLUSTERED 
(
	[unitGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/* -------------------- dppRepoUnitCalc -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoUnitCalc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[unitGUIDfrom] [uniqueidentifier] NOT NULL,
	[unitGUIDto] [uniqueidentifier] NOT NULL,
	[formula] [nvarchar](40) NOT NULL,
	[createdTime] [datetime] NOT NULL,
 CONSTRAINT [pk_dppRepoUnitCalc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoUnitCalc_unitGUIDfrom_unitGUIDto] UNIQUE NONCLUSTERED 
(
	[unitGUIDfrom] ASC,
	[unitGUIDto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoValue2Param -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoValue2Param](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[paramGUID] [uniqueidentifier] NOT NULL,
	[valueGUID] [uniqueidentifier] NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[v2pGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dppRepoValue2Param] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoValue2Param_v2pGUID] UNIQUE NONCLUSTERED 
(
	[v2pGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/* -------------------- dppRepoValueList -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dppRepoValueList](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[valueListGUID] [uniqueidentifier] NOT NULL,
	[valueListName] [nvarchar](120) NOT NULL,
	[valueListValueType] [varchar](20) NOT NULL,
	[createdTime] [datetime] NOT NULL,
	[valueListUnit] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dppRepoValueList] PRIMARY KEY CLUSTERED 
(
	[valueListGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoValueList_valueListGUID] UNIQUE NONCLUSTERED 
(
	[valueListGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_dppRepoValueList_valueListName_valueListValueType] UNIQUE NONCLUSTERED 
(
	[valueListName] ASC,
	[valueListValueType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/* -------------------- AspNetRoleClaims -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/* -------------------- AspNetRoles -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/* -------------------- AspNetUserClaims -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/* -------------------- AspNetUserLogins -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/* -------------------- AspNetUserRoles -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/* -------------------- AspNetUsers -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[EoGuid] [uniqueidentifier] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/* -------------------- AspNetUserTokens -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/* -------------------- DppRole -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DppRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](120) NOT NULL,
	[RoleLevel] [int] NOT NULL,
 CONSTRAINT [PK_DppRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_DppRole_RoleName] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO





/* ------------------------------------------------------------------------- */
/* ------------------------------ Constraints ------------------------------ */
/* ------------------------------------------------------------------------- */
ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF_dpp_jubaCode]  DEFAULT ('') FOR [jubaCode]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF_dpp_dppCode]  DEFAULT ('') FOR [dppCode]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__dppGUID__29AC2CE0]  DEFAULT (newid()) FOR [dppGUID]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF_dpp_sectorGUID]  DEFAULT ('00000000-0000-0000-0000-0000000000000') FOR [sectorGUID]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__productID__2AA05119]  DEFAULT ('') FOR [productID]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF_dpp_lotNumber]  DEFAULT ('') FOR [lotNumber]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF_dpp_serialNumber]  DEFAULT ('') FOR [serialNumber]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__dppIdentifi__2B947552]  DEFAULT ('') FOR [dppIdentifier]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__dppSchemaVe__2C88998B]  DEFAULT ('0.1') FOR [dppSchemaVersion]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__dppStatus__2D7CBDC4]  DEFAULT ('active') FOR [dppStatus]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__dppGranular__2E70E1FD]  DEFAULT ('model') FOR [dppGranularity]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__registryID__2F650636]  DEFAULT ('') FOR [registryID]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__lastUpdated__30592A6F]  DEFAULT (getdate()) FOR [lastUpdated]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__isArchive__314D4EA8]  DEFAULT ((0)) FOR [isArchive]
GO

ALTER TABLE [dbo].[dpp] ADD  CONSTRAINT [DF__dpp__createdTime__324172E1]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dpp] ADD  DEFAULT ('') FOR [zolltarifnum]
GO

ALTER TABLE [dbo].[dpp] ADD  DEFAULT ('') FOR [prodName]
GO

ALTER TABLE [dbo].[dpp] ADD  DEFAULT ('') FOR [compCode]
GO

ALTER TABLE [dbo].[dpp] ADD  DEFAULT ((0)) FOR [prodID]
GO

ALTER TABLE [dbo].[dpp] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [inheritsFrom]
GO

ALTER TABLE [dbo].[dppEan2Dpp] ADD  DEFAULT ('') FOR [ean]
GO

ALTER TABLE [dbo].[dppEan2Dpp] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [dppGUID]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF_dppEconomicOperator_code]  DEFAULT ('') FOR [jubaCode]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF_dppEconomicOperator_dppCode]  DEFAULT ('') FOR [dppCode]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF_dppEconomicOperator_dppURL]  DEFAULT ('') FOR [dppURL]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoGUI__7FB5F314]  DEFAULT (newid()) FOR [eoGUID]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoLEI__00AA174D]  DEFAULT ('') FOR [eoLEI]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoNam__019E3B86]  DEFAULT ('') FOR [eoName]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoNam__02925FBF]  DEFAULT ('') FOR [eoName2]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoZIP__038683F8]  DEFAULT ('') FOR [eoZIP]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoCit__047AA831]  DEFAULT ('') FOR [eoCity]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoStr__056ECC6A]  DEFAULT ('') FOR [eoStreet]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF__dppEconom__eoGLN__0662F0A3]  DEFAULT ('') FOR [eoGLN]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF_dppEconomicOperator_eoCountryCode]  DEFAULT ('') FOR [eoCountryCode]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF_dppEconomicOperator_eoMail]  DEFAULT ('') FOR [eoMail]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF_dppEconomicOperator_eoURL]  DEFAULT ('') FOR [eoURL]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  CONSTRAINT [DF_dppEconomicOperator_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  DEFAULT ((0)) FOR [isEo]
GO

ALTER TABLE [dbo].[dppEconomicOperator] ADD  DEFAULT ((0)) FOR [isFacility]
GO

ALTER TABLE [dbo].[dppParamResource] ADD  DEFAULT (newid()) FOR [resourceGUID]
GO

ALTER TABLE [dbo].[dppParamResource] ADD  DEFAULT ('') FOR [contentType]
GO

ALTER TABLE [dbo].[dppParamResource] ADD  DEFAULT ('') FOR [url]
GO

ALTER TABLE [dbo].[dppParamResource] ADD  DEFAULT ('') FOR [resourceTitle]
GO

ALTER TABLE [dbo].[dppParamResource] ADD  DEFAULT ('') FOR [langcode]
GO

ALTER TABLE [dbo].[dppParamResource] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppParamResource] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [zuValueGUID]
GO

ALTER TABLE [dbo].[dppParamValue] ADD  CONSTRAINT [DF__dppParamV__param__361203C5]  DEFAULT ('') FOR [paramValue]
GO

ALTER TABLE [dbo].[dppParamValue] ADD  CONSTRAINT [DF_dppParamValue_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppParamValue] ADD  CONSTRAINT [DF_dppParamValue_listorder]  DEFAULT ((0)) FOR [listorder]
GO

ALTER TABLE [dbo].[dppParamValue] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [p2cGUID]
GO

ALTER TABLE [dbo].[dppParamValue] ADD  DEFAULT (newid()) FOR [valueGUID]
GO

ALTER TABLE [dbo].[dppParamValue] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [zuValueGUID]
GO

ALTER TABLE [dbo].[dppParamValueList] ADD  CONSTRAINT [DF_dppParamValueList_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppParamValueList] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [p2cGUID]
GO

ALTER TABLE [dbo].[dppParamValueList] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [zuValueGUID]
GO

ALTER TABLE [dbo].[dppParamValueList] ADD  DEFAULT (newid()) FOR [valueGUID]
GO

ALTER TABLE [dbo].[dppRepoCriteria] ADD  CONSTRAINT [DF_dppRepoGroup_groupGUID]  DEFAULT (newid()) FOR [critGUID]
GO

ALTER TABLE [dbo].[dppRepoCriteria] ADD  CONSTRAINT [DF_dppRepoGroup_clause]  DEFAULT ('') FOR [clause]
GO

ALTER TABLE [dbo].[dppRepoCriteria] ADD  CONSTRAINT [DF_dppRepoGroup_groupName]  DEFAULT ('') FOR [critName]
GO

ALTER TABLE [dbo].[dppRepoCriteria] ADD  CONSTRAINT [DF_dppRepoGroup_groupDescription]  DEFAULT ('') FOR [critDescription]
GO

ALTER TABLE [dbo].[dppRepoCriteria] ADD  CONSTRAINT [DF_dppRepoCriteria_critShortName]  DEFAULT ('') FOR [critShortName]
GO

ALTER TABLE [dbo].[dppRepoCriteria] ADD  CONSTRAINT [DF_dppRepoCriteria_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  DEFAULT (newid()) FOR [legalGUID]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  DEFAULT ('') FOR [legalName]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  DEFAULT ('') FOR [legalDescription]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  CONSTRAINT [df_dppRepoLegal_legalValidFrom]  DEFAULT ('2027-01-01') FOR [legalValidFrom]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  DEFAULT ('delegated act') FOR [legaltype]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  DEFAULT ('') FOR [legalUri]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  CONSTRAINT [DF_dppRepoLegal_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoLegal] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [replacesLegalGuid]
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector] ADD  CONSTRAINT [DF_dppRepoLegal2Sector_legalGUID]  DEFAULT ('00000000-0000-0000-0000-0000000000000') FOR [legalGUID]
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector] ADD  CONSTRAINT [DF_dppRepoLegal2Sector_sectorGUID]  DEFAULT ('00000000-0000-0000-0000-0000000000000') FOR [sectorGUID]
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector] ADD  CONSTRAINT [DF_dppRepoLegal2Sector_isMandatory]  DEFAULT ((1)) FOR [isMandatory]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF__dppRepoPa__param__681373AD]  DEFAULT (newid()) FOR [paramGUID]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF__dppRepoPa__param__690797E6]  DEFAULT ('') FOR [paramName]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF__dppRepoPa__param__69FBBC1F]  DEFAULT ('') FOR [paramDescription]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF__dppRepoPa__param__6AEFE058]  DEFAULT ('') FOR [paramValueType]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [df_dppRepoParam_isValueList]  DEFAULT ((0)) FOR [isValueList]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF_dppRepoParam_teststandardGUID]  DEFAULT ('e897c506-874b-448d-8564-91181d706ad1') FOR [teststandardGUID]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF_dppRepoParam_standardGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [standardGUID]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF_dppRepoParam_bandwidt]  DEFAULT ((0)) FOR [bandwidth]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF_dppRepoParam_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF_dppRepoParam_isUsuallyMandatory]  DEFAULT ((0)) FOR [isUsuallyMandatory]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  CONSTRAINT [DF_dppRepoParam_isUsuallyDynamic]  DEFAULT ((0)) FOR [isUsuallyDynamic]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [unitGUID]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  DEFAULT ('') FOR [writtenName]
GO

ALTER TABLE [dbo].[dppRepoParam] ADD  DEFAULT ('2049-12-31') FOR [activeUntil]
GO

ALTER TABLE [dbo].[dppRepoParam2Crit] ADD  CONSTRAINT [DF_dppRepoParam2Crit_global]  DEFAULT ((1)) FOR [global]
GO

ALTER TABLE [dbo].[dppRepoParam2Crit] ADD  CONSTRAINT [DF__dppRepoPa__creat__4A4E069C]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoParam2Crit] ADD  DEFAULT ((0)) FOR [isMandatory]
GO

ALTER TABLE [dbo].[dppRepoParam2Crit] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [collGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2Crit] ADD  DEFAULT (newid()) FOR [p2cGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2CritExclValue] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [v2pGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2CritExclValue] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [p2cGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2CritExclValue] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoParam2Sector] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoParam2Sector] ADD  CONSTRAINT [DF_dppRepoParam2Sector_isMandatory]  DEFAULT ((1)) FOR [isMandatory]
GO

ALTER TABLE [dbo].[dppRepoParam2Sector] ADD  CONSTRAINT [DF_dppRepoParam2Sector_isDynamic]  DEFAULT ((0)) FOR [isDynamic]
GO

ALTER TABLE [dbo].[dppRepoParam2Sector] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [p2cGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2Sector] ADD  DEFAULT (newid()) FOR [p2sGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2SectorExclValue] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [v2pGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2SectorExclValue] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [p2sGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2SectorExclValue] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  DEFAULT (newid()) FOR [sectorGUID]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  DEFAULT ('') FOR [sectorCode]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  DEFAULT ('') FOR [sectorName]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  DEFAULT ('') FOR [sectorDescription]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  CONSTRAINT [DF_dppRepoSector_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  DEFAULT ((0)) FOR [isFolder]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [zu_guid]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  CONSTRAINT [DF_dppRepoSector_isDestructionProhibited]  DEFAULT ((0)) FOR [isDestructionProhibited]
GO

ALTER TABLE [dbo].[dppRepoSector] ADD  DEFAULT ('') FOR [writtenName]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT (newid()) FOR [standardGUID]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT ('') FOR [standardName]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT ('') FOR [standardDescription]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT ('') FOR [standardReference]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT ('') FOR [standardFullReference]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  CONSTRAINT [df_dppRepoStandard_standardValidFrom]  DEFAULT ('2027-01-01') FOR [standardValidFrom]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT ('delegated act') FOR [standardtype]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT ('') FOR [standardUri]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  CONSTRAINT [DF_dppRepostandard_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoStandard] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [replacesStandardGuid]
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector] ADD  CONSTRAINT [DF_dppRepoLegalStandard2Sector_standardGUID]  DEFAULT ('00000000-0000-0000-0000-0000000000000') FOR [standardGUID]
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector] ADD  CONSTRAINT [DF_dppRepoLegalStandard2Sector_sectorGUID]  DEFAULT ('00000000-0000-0000-0000-0000000000000') FOR [sectorGUID]
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector] ADD  CONSTRAINT [DF_dppRepoLegalStandard2Sector_isMandatory]  DEFAULT ((1)) FOR [isMandatory]
GO

ALTER TABLE [dbo].[dppRepoTrans] ADD  DEFAULT (newid()) FOR [sourceGUID]
GO

ALTER TABLE [dbo].[dppRepoTrans] ADD  DEFAULT ('') FOR [sourceTable]
GO

ALTER TABLE [dbo].[dppRepoTrans] ADD  DEFAULT ('') FOR [TransName]
GO

ALTER TABLE [dbo].[dppRepoTrans] ADD  DEFAULT ('') FOR [TransDescription]
GO

ALTER TABLE [dbo].[dppRepoTrans] ADD  DEFAULT ('') FOR [langcode]
GO

ALTER TABLE [dbo].[dppRepoTrans] ADD  CONSTRAINT [DF_dppRepoTrans_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoUnit] ADD  DEFAULT (newid()) FOR [unitGUID]
GO

ALTER TABLE [dbo].[dppRepoUnit] ADD  DEFAULT ('') FOR [unitName]
GO

ALTER TABLE [dbo].[dppRepoUnit] ADD  DEFAULT ('') FOR [unit]
GO

ALTER TABLE [dbo].[dppRepoUnit] ADD  DEFAULT ('') FOR [unitDescription]
GO

ALTER TABLE [dbo].[dppRepoUnit] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoUnit] ADD  DEFAULT ('en-gb') FOR [langcode]
GO

ALTER TABLE [dbo].[dppRepoUnitCalc] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [unitGUIDfrom]
GO

ALTER TABLE [dbo].[dppRepoUnitCalc] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [unitGUIDto]
GO

ALTER TABLE [dbo].[dppRepoUnitCalc] ADD  DEFAULT ('') FOR [formula]
GO

ALTER TABLE [dbo].[dppRepoUnitCalc] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoValue2Param] ADD  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoValue2Param] ADD  DEFAULT (newid()) FOR [v2pGUID]
GO

ALTER TABLE [dbo].[dppRepoValueList] ADD  CONSTRAINT [DF__dpprepova__valueList__681373AD]  DEFAULT (newid()) FOR [valueListGUID]
GO

ALTER TABLE [dbo].[dppRepoValueList] ADD  CONSTRAINT [DF__dpprepova__valueList__690797E6]  DEFAULT ('') FOR [valueListName]
GO

ALTER TABLE [dbo].[dppRepoValueList] ADD  CONSTRAINT [DF__dpprepova__valueList__6AEFE058]  DEFAULT ('') FOR [valueListValueType]
GO

ALTER TABLE [dbo].[dppRepoValueList] ADD  CONSTRAINT [DF_dppRepovalueList_createdTime]  DEFAULT (getdate()) FOR [createdTime]
GO

ALTER TABLE [dbo].[dppRepoValueList] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [valueListUnit]
GO

ALTER TABLE [dbo].[dpp]  WITH CHECK ADD  CONSTRAINT [FK_dpp_dppEconomicOperator] FOREIGN KEY([eoGUID])
REFERENCES [dbo].[dppEconomicOperator] ([eoGUID])
GO

ALTER TABLE [dbo].[dpp] CHECK CONSTRAINT [FK_dpp_dppEconomicOperator]
GO

ALTER TABLE [dbo].[dppEan2Dpp]  WITH CHECK ADD  CONSTRAINT [fk_dppEan2Dpp_dppGUID] FOREIGN KEY([dppGUID])
REFERENCES [dbo].[dpp] ([dppGUID])
GO

ALTER TABLE [dbo].[dppEan2Dpp] CHECK CONSTRAINT [fk_dppEan2Dpp_dppGUID]
GO

ALTER TABLE [dbo].[dppParamValue]  WITH CHECK ADD  CONSTRAINT [FK_dppParamValue_dpp] FOREIGN KEY([dppGUID])
REFERENCES [dbo].[dpp] ([dppGUID])
GO

ALTER TABLE [dbo].[dppParamValue] CHECK CONSTRAINT [FK_dppParamValue_dpp]
GO

ALTER TABLE [dbo].[dppParamValueList]  WITH CHECK ADD  CONSTRAINT [FK_dppParamValueList_dpp] FOREIGN KEY([dppGUID])
REFERENCES [dbo].[dpp] ([dppGUID])
GO

ALTER TABLE [dbo].[dppParamValueList] CHECK CONSTRAINT [FK_dppParamValueList_dpp]
GO

ALTER TABLE [dbo].[dppParamValueList]  WITH CHECK ADD  CONSTRAINT [FK_dppParamValueList_dppRepoValueList] FOREIGN KEY([paramValueGuid])
REFERENCES [dbo].[dppRepoValueList] ([valueListGUID])
GO

ALTER TABLE [dbo].[dppParamValueList] CHECK CONSTRAINT [FK_dppParamValueList_dppRepoValueList]
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoLegal2Sector_dppRepoLegal] FOREIGN KEY([legalGUID])
REFERENCES [dbo].[dppRepoLegal] ([legalGUID])
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector] CHECK CONSTRAINT [FK_dppRepoLegal2Sector_dppRepoLegal]
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoLegal2Sector_dppRepoSector] FOREIGN KEY([sectorGUID])
REFERENCES [dbo].[dppRepoSector] ([sectorGUID])
GO

ALTER TABLE [dbo].[dppRepoLegal2Sector] CHECK CONSTRAINT [FK_dppRepoLegal2Sector_dppRepoSector]
GO

ALTER TABLE [dbo].[dppRepoParam2Crit]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoParam2Crit_dppRepoCriteria] FOREIGN KEY([critGUID])
REFERENCES [dbo].[dppRepoCriteria] ([critGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2Crit] CHECK CONSTRAINT [FK_dppRepoParam2Crit_dppRepoCriteria]
GO

ALTER TABLE [dbo].[dppRepoParam2Crit]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoParam2Crit_dppRepoParam] FOREIGN KEY([paramGUID])
REFERENCES [dbo].[dppRepoParam] ([paramGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2Crit] CHECK CONSTRAINT [FK_dppRepoParam2Crit_dppRepoParam]
GO

ALTER TABLE [dbo].[dppRepoParam2CritExclValue]  WITH CHECK ADD  CONSTRAINT [fk_dppRepoParam2CritExclValue_p2c] FOREIGN KEY([p2cGUID])
REFERENCES [dbo].[dppRepoParam2Crit] ([p2cGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2CritExclValue] CHECK CONSTRAINT [fk_dppRepoParam2CritExclValue_p2c]
GO

ALTER TABLE [dbo].[dppRepoParam2CritExclValue]  WITH CHECK ADD  CONSTRAINT [fk_dppRepoParam2CritExclValue_v2p] FOREIGN KEY([v2pGUID])
REFERENCES [dbo].[dppRepoValue2Param] ([v2pGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2CritExclValue] CHECK CONSTRAINT [fk_dppRepoParam2CritExclValue_v2p]
GO

ALTER TABLE [dbo].[dppRepoParam2Sector]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoParam2Sector_dppRepoSector] FOREIGN KEY([sectorGUID])
REFERENCES [dbo].[dppRepoSector] ([sectorGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2Sector] CHECK CONSTRAINT [FK_dppRepoParam2Sector_dppRepoSector]
GO

ALTER TABLE [dbo].[dppRepoParam2Sector]  WITH CHECK ADD  CONSTRAINT [fk_dppRepoParam2Sector_p2cGUID] FOREIGN KEY([p2cGUID])
REFERENCES [dbo].[dppRepoParam2Crit] ([p2cGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2Sector] CHECK CONSTRAINT [fk_dppRepoParam2Sector_p2cGUID]
GO

ALTER TABLE [dbo].[dppRepoParam2SectorExclValue]  WITH CHECK ADD  CONSTRAINT [fk_dppRepoParam2SectorExclValue_p2s] FOREIGN KEY([p2sGUID])
REFERENCES [dbo].[dppRepoParam2Sector] ([p2sGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2SectorExclValue] CHECK CONSTRAINT [fk_dppRepoParam2SectorExclValue_p2s]
GO

ALTER TABLE [dbo].[dppRepoParam2SectorExclValue]  WITH CHECK ADD  CONSTRAINT [fk_dppRepoParam2SectorExclValue_v2p] FOREIGN KEY([v2pGUID])
REFERENCES [dbo].[dppRepoValue2Param] ([v2pGUID])
GO

ALTER TABLE [dbo].[dppRepoParam2SectorExclValue] CHECK CONSTRAINT [fk_dppRepoParam2SectorExclValue_v2p]
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoStandard2Sector_dppRepoSector] FOREIGN KEY([sectorGUID])
REFERENCES [dbo].[dppRepoSector] ([sectorGUID])
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector] CHECK CONSTRAINT [FK_dppRepoStandard2Sector_dppRepoSector]
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoStandard2Sector_dppRepoStandard] FOREIGN KEY([standardGUID])
REFERENCES [dbo].[dppRepoStandard] ([standardGUID])
GO

ALTER TABLE [dbo].[dppRepoStandard2Sector] CHECK CONSTRAINT [FK_dppRepoStandard2Sector_dppRepoStandard]
GO

ALTER TABLE [dbo].[dppRepoUnitCalc]  WITH CHECK ADD  CONSTRAINT [fk_dppRepoUnitCalc_toGUIDfrom] FOREIGN KEY([unitGUIDfrom])
REFERENCES [dbo].[dppRepoUnit] ([unitGUID])
GO

ALTER TABLE [dbo].[dppRepoUnitCalc] CHECK CONSTRAINT [fk_dppRepoUnitCalc_toGUIDfrom]
GO

ALTER TABLE [dbo].[dppRepoUnitCalc]  WITH CHECK ADD  CONSTRAINT [fk_dppRepoUnitCalc_toGUIDto] FOREIGN KEY([unitGUIDto])
REFERENCES [dbo].[dppRepoUnit] ([unitGUID])
GO

ALTER TABLE [dbo].[dppRepoUnitCalc] CHECK CONSTRAINT [fk_dppRepoUnitCalc_toGUIDto]
GO

ALTER TABLE [dbo].[dppRepoValue2Param]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoValue2Param_dppRepoParam] FOREIGN KEY([paramGUID])
REFERENCES [dbo].[dppRepoParam] ([paramGUID])
GO

ALTER TABLE [dbo].[dppRepoValue2Param] CHECK CONSTRAINT [FK_dppRepoValue2Param_dppRepoParam]
GO

ALTER TABLE [dbo].[dppRepoValue2Param]  WITH CHECK ADD  CONSTRAINT [FK_dppRepoValue2Param_dppRepoValueList] FOREIGN KEY([valueGUID])
REFERENCES [dbo].[dppRepoValueList] ([valueListGUID])
GO

ALTER TABLE [dbo].[dppRepoValue2Param] CHECK CONSTRAINT [FK_dppRepoValue2Param_dppRepoValueList]
GO

ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO

ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO

ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO

ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsers_DppEconomicOperator_EoGuid] FOREIGN KEY([EoGuid])
REFERENCES [dbo].[dppEconomicOperator] ([eoGUID])
GO

ALTER TABLE [dbo].[AspNetUsers] CHECK CONSTRAINT [FK_AspNetUsers_DppEconomicOperator_EoGuid]
GO

ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsers_DppRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[DppRole] ([Id])
GO

ALTER TABLE [dbo].[AspNetUsers] CHECK CONSTRAINT [FK_AspNetUsers_DppRole]
GO

ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO

ALTER TABLE [dbo].[DppRole]  WITH CHECK ADD  CONSTRAINT [CK_DppRole_RoleLevel] CHECK  (([RoleLevel]>=(0) AND [RoleLevel]<=(99)))
GO

ALTER TABLE [dbo].[DppRole] CHECK CONSTRAINT [CK_DppRole_RoleLevel]
GO

ALTER TABLE dbo.dppParamValue
ADD CONSTRAINT fk_dppParamValue_to_dppRepoParam2Crit FOREIGN KEY (p2cGUID) REFERENCES dbo.dppRepoParam2Crit (p2cGUID)
GO

ALTER TABLE dbo.dppParamValueList
ADD CONSTRAINT fk_dppParamValueList_to_dppRepoParam2Crit FOREIGN KEY (p2cGUID) REFERENCES dbo.dppRepoParam2Crit (p2cGUID)
GO

ALTER TABLE dbo.dppParamValueList
ADD CONSTRAINT fk_dppParamValueList_to_dppRepoValueList FOREIGN KEY (paramValueGuid) REFERENCES dbo.dppRepoValueList (valueListGUID)
GO



/* --------------------------------------------------------------------- */
/* ------------------------------ Indices ------------------------------ */
/* --------------------------------------------------------------------- */

/* -------------------- dpp -------------------- */
CREATE UNIQUE NONCLUSTERED INDEX [IX_dpp_dppGUID] ON [dbo].[dpp]
(
	[dppGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- dppEan2Dpp -------------------- */
CREATE UNIQUE NONCLUSTERED INDEX [IX_dppEconomicOperator_eoGUID] ON [dbo].[dppEconomicOperator]
(
	[eoGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- dppRepoCriteria -------------------- */
CREATE UNIQUE NONCLUSTERED INDEX [IX_dppRepoGroup_id] ON [dbo].[dppRepoCriteria]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- dppRepoValue2Param -------------------- */
CREATE NONCLUSTERED INDEX [IX_dppRepoValue2Param] ON [dbo].[dppRepoValue2Param]
(
	[paramGUID] ASC,
	[valueGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- AspNetRoleClaims -------------------- */
SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- AspNetRoles -------------------- */
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/* -------------------- AspNetUserClaims -------------------- */
SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- AspNetUserLogins -------------------- */
SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- AspNetUserRoles -------------------- */
SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/* -------------------- AspNetUsers -------------------- */
SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_AspNetUsers_EoGuid] ON [dbo].[AspNetUsers]
(
	[EoGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO






/* ------------------------------------------------------------------- */
/* ------------------------------ Views ------------------------------ */
/* ------------------------------------------------------------------- */
/* -------------------- view_dpp_header -------------------- */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_dpp_header] AS
SELECT
d.id, d.jubaCode, d.dppCode, d.dppGUID, d.eoGUID, d.facilityGUID, d.sectorGUID, d.productID, d.lotNumber, d.serialNumber, d.dppIdentifier, d.dppSchemaVersion, d.dppStatus, d.dppGranularity, d.registryID, d.lastUpdated, 
d.isArchive, d.createdTime, d.zolltarifnum, d.prodName, d.compCode, d.prodID, d.inheritsFrom, c.id AS c_ID, c.sectorGUID AS c_sectorGuid, c.sectorCode, c.sectorName, c.sectorDescription, c.createdTime AS c_createdTime, c.isFolder, c.zu_guid, c.isDestructionProhibited, c.writtenName, eo.id AS eo_ID, eo.jubaCode AS eo_jubaCode, eo.dppCode AS eo_dppCode, 
eo.dppURL, eo.eoGUID AS eo_eoGUID, eo.eoLEI, eo.eoName, eo.eoName2, eo.eoZIP, eo.eoCity, eo.eoStreet, eo.eoGLN, eo.eoCountryCode, eo.eoMail, eo.eoURL, eo.createdTime AS eo_createdTime, 
eo.isEo, eo.isFacility, f.id AS f_id, f.jubaCode AS f_jubaCode, f.dppCode AS f_dppCode, f.dppURL AS f_dppUrl, f.eoGUID AS f_eoGUID, f.eoLEI AS f_eoLEI, f.eoName AS f_eoNAME, 
f.eoName2 AS f_eoName2, f.eoZIP AS f_eoZIP, f.eoCity AS f_eoCity, f.eoStreet AS f_eoStreed, f.eoGLN AS f_eoGLN, f.eoCountryCode AS _feoCountryCode, f.eoMail AS f_eoMail, f.eoURL AS f_eoURL, 
f.createdTime AS f_createdTime, f.isEo AS f_isEO, f.isFacility AS f_isFacility
FROM dbo.dpp AS d INNER JOIN
dbo.dppRepoSector AS c ON c.sectorGUID = d.sectorGUID INNER JOIN
dbo.dppEconomicOperator AS eo ON eo.eoGUID = d.eoGUID LEFT OUTER JOIN
dbo.dppEconomicOperator AS f ON f.eoGUID = d.facilityGUID;
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[7] 2[34] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 136
               Right = 480
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "eo"
            Begin Extent = 
               Top = 138
               Left = 261
               Bottom = 268
               Right = 434
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 472
               Bottom = 268
               Right = 645
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 112
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_dpp_header'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2130
         Width = 2145
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_dpp_header'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_dpp_header'
GO






/* --------------------------------------------------------------------- */
/* ------------------------------ Trigger ------------------------------ */
/* --------------------------------------------------------------------- */

/* -------------------- dpp -------------------- */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   TRIGGER [dbo].[trg_dpp_AfterInsertAndUpdate]
ON [dbo].[dpp]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    --After creating or modifying a record in the dpp table, the sector must be added or edited as a value in the value table

    --Edit an existing record
    UPDATE v
    SET v.paramValue = ISNULL(s.sectorName, '')
    FROM dbo.dppParamValue v
    JOIN inserted i ON v.dppGUID = i.dppGUID
    LEFT JOIN dbo.dppRepoSector s ON i.sectorGUID = s.sectorGUID
    WHERE v.p2cGUID = '3C812D84-EF2A-4919-A09B-78AA789EB5CE';

    --If no record exists, create a new one
    INSERT INTO dbo.dppParamValue (dppGUID, paramValue, p2cGUID)
    SELECT
    i.dppGUID AS dppGUID, ISNULL(s.sectorName, '') AS paramValue, '3C812D84-EF2A-4919-A09B-78AA789EB5CE' AS p2cGUID
    FROM inserted i
    LEFT JOIN dbo.dppRepoSector s ON i.sectorGUID = s.sectorGUID
    WHERE NOT EXISTS (
        SELECT 1
        FROM dbo.dppParamValue v
        WHERE v.p2cGUID = '3C812D84-EF2A-4919-A09B-78AA789EB5CE' AND v.dppGUID = i.dppGUID
    );
END
GO

ALTER TABLE [dbo].[dpp] ENABLE TRIGGER [trg_dpp_AfterInsertAndUpdate]
GO
