USE AdventureWorks2019
GO

CREATE TABLE dbo.Customer
(
	CustomerID int
	,FirstName varchar(50)
	,LastName varchar(50)
	,Email varchar(100)
	,ModifiedDate date
	,CONSTRAINT Customer_Pkey PRIMARY KEY CLUSTERED(CustomerID)
);

--------------------------------------

CREATE NONCLUSTERED INDEX IX_Customer_LastName_FirstName ON dbo.Customer
(
	FirstName ASC
	,LastName ASC
);

----------------------------------------

CREATE INDEX IX_Customer_ModifiedDate ON dbo.Customer (ModifiedDate) INCLUDE (FirstName, LastName);
SELECT FirstName
	   ,LastName
FROM Customer
WHERE ModifiedDate = '2020-10-20';

-----------------------------------

CREATE TABLE dbo.Customer2
(
	CustomerID int
	,AccountNumber varchar(10)
	,FirstName varchar(50)
	,LastName varchar(50)
	,Email varchar(100)
	,ModifiedDate date
	CONSTRAINT Customer_PK PRIMARY KEY NONCLUSTERED (CustomerID)
);
GO

CREATE CLUSTERED INDEX IX_Customer2_AccountNumber
	ON dbo.Customer2 (AccountNumber);
GO

----------------------------------------

EXEC sp_rename
		@objname = N'dbo.Customer2.IX_Customer2_AccountNumber',
        @newname = N'CI_CustomerID' ,
        @objtype = N'INDEX';

-------------------------------------

DROP INDEX CI_CustomerID ON dbo.Customer2;

---------------------------------------

CREATE UNIQUE NONCLUSTERED INDEX AK_Customer_Email
	ON dbo.Customer2 (Email);

---------------------------------

CREATE NONCLUSTERED INDEX AK_Customer_ModifiedDate
ON dbo.Customer2 (ModifiedDate)
WITH (FILLFACTOR = 70);