GO
DROP DATABASE IF EXISTS TOURNAMENTS_CA_GOUTAM;
GO
CREATE DATABASE TOURNAMENTS_CA_GOUTAM;
GO
USE TOURNAMENTS_CA_GOUTAM;
GO 

--Database Start

CREATE DATABASE TOURNAMENTS_CA_GOUTAM;
GO

CREATE SCHEMA TOURNAMENTS;
GO

--CREATE TABLES


CREATE TABLE TOURNAMENTS.Registration(
	RegistrationID int CONSTRAINT  PKRegistrationID PRIMARY KEY IDENTITY(1,1),
	RegistrationCost Money NOT NULL,
	AmountPaid Money NOT NULL
	PaymentDate DATETIME NOT NULL,
	TournamentID varchar(70) NOT NULL,
	RegistrationEndDate DATETIME NOT NULL
);

CREATE TABLE TOURNAMENTS.Participents(
	ParticipantID int CONSTRAINT PKParticipentID PRIMARY KEY IDENTITY(1,1),
	FirstName  varchar (50) NOT NULL,
	LastName varchar(40) NOT NULL,
	BirthDate DATE NOT NULL,
	EmailAddress varchar(80) NOT NULL,
	ParticipantPassword varchar(70) NOT NULL,
	RegistrationID int NOT NULL,
	FOREIGN KEY (RegistrationID)REFERENCES TOURNAMENTS.Registration(RegistrationID),
);

CREATE TABLE TOURNAMENTS.Tournament(
	TournamentName int CONSTRAINT PKTournamentName PRIMARY KEY IDENTITY(1,1),
	TournamentDescription varchar(100) NOT NULL,
	TournamentAddress varchar(70) NOT NULL,
	TournamentDate DATETIME NOT NULL,
	SportsType varchar(80) NOT NULL,
	RegistrationID int NOT NULL,
	FOREIGN KEY (RegistrationID)REFERENCES TOURNAMENTS.Registration(RegistrationID),
);

-- Payment date must in real time

ALTER TABLE TOURNAMENTS.Registration(
add CONSTRAINT PaymentDateConstraint
DEFAULT GETDATE() FOR PaymentDate
);
GO

--Participent must =16years or older


ALTER TABLE TOURNAMENTS.Participents(
add CONSTRAINT CHE_BirthDate
CHECK (GETDATE()- convert(DateTime,BirthDate) > = 16
);
GO

--Create function

CREATE FUNCTION TOURNAMENTS.FormateDate(
	@Date Date
)
RETURNS VARCHAR(50)
WITH RETURNS NULL ON NULL INPUT,
SCHEMABINDING
AS
BEGIN
	DECLARE @OutPutMonth varchar(20)
	DECLARE @OutPutDay   varchar(20)
	DECLARE @OutPutYear  varchar(20)

	SELECT @OutPutMonth  =(@Date,'MM')
	SELECT @OutOutDay    =(@Date,'DD')
	SELECT @OutPutYear   =(@Date,'YY')

RETURN @OutPutMonth +''+ @OutPutDay +''+ OutOutYear
END;
GO

DROP FUNCTION TOURNAMENTS.Functions

--CREATE STORE PROCEDURE insert Data

CREATE PROCEDURE TOURNAMENTS.ParticipentsInsert 
	@FirstName  varchar (50), 
	@LastName varchar(40),
	@BirthDate DATE,
	@EmailAddress varchar(80),
	@ParticipantPassword varchar(70)
AS
INSERT INTO TOURNAMENTS.Participents(
	FirstName,
	LastName,
	BirthDate,
	EmailAddress,
	ParticipantPassword
)
VALUES(
	@FirstName,
	@LastName,
	@BirthDate,
	@EmailAddress,
	@ParticipantPassword
);
GO

EXEC TOURNAMENTS.ParticipentsInsert, 'MD' , 'Mollha' , '08/26/1999' , 'MollhaShara@gmail.com' , '23564856'

--TO VIEW THE INSERT TABLE
SELECT * FROM TOURNAMENTS.Participents
GO

-- STORE PROCEDURE update data

CREATE PROCEDURE TOURNAMENTS.ParticipentsUpdate 
	@ParticipentID int,
	@FirstName  varchar (50), 
	@LastName varchar(40),
	@BirthDate DATE,
	@EmailAddress varchar(80),
	@ParticipantPassword varchar(70)
AS
UPDATE TOURNAMENTS.Participents
SET FirstName=@FirstName, LastName=@LastName, BirthDate=@BirthDate, EmailAddress=@EmailAddress
WHERE ParticipentID=@ParticipentID;
GO


EXEC TOURNAMENTS.ParticipentsUpdate 1, 'MBBS' , 'Mollha' , '08/26/1999' , 'MollhaShara@gmail.com' , '23564856'

SELECT * FROM TOURNAMENTS.Participents
GO

-- STORE PROCEDURE DELETE

CREATE PROCEDURE TOURNAMENTS.ParticipentsDelete @ParticipentID int
AS 
DELETE FROM TOURNAMENTS.Participents
WHERE ParticipentID=@ParticipentID;
GO

EXEC TOURNAMENTS.ParticipentsDelete 1

SELECT * FROM TOURNAMENTS.Participents
GO


Select * from tournaments.ragistration
