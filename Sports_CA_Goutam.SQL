Use master
GO
DROP DATABASE IF EXISTS Sports_CA_GOUTAM;
GO
CREATE DATABASE Sports_CA_GOUTAM;
GO
USE Sports_CA_GOUTAM;
GO 

--Database Start


CREATE SCHEMA Events;
GO

--CREATE TABLES


CREATE TABLE Events.Registration(
	RegistrationID int CONSTRAINT  PKRegistrationID PRIMARY KEY IDENTITY(1,1),
	RegistrationCost Money NOT NULL,
	AmountPaid Money NOT NULL,
	PaymentDate DATETIME NOT NULL,
	TournamentID varchar(70) NOT NULL,
	RegistrationEndDate DATETIME NOT NULL
);

CREATE TABLE Events.Participents(
	ParticipantID int CONSTRAINT PKParticipentID PRIMARY KEY IDENTITY(1,1),
	FirstName  varchar (50) NOT NULL,
	LastName varchar(40) NOT NULL,
	BirthDate DATE NOT NULL,
	EmailAddress varchar(80) NOT NULL,
	ParticipantPassword varchar(70) NOT NULL,
	RegistrationID int NOT NULL,
	FOREIGN KEY (RegistrationID)REFERENCES Events.Registration(RegistrationID),
);

CREATE TABLE Events.Tournament(
	TournamentName int CONSTRAINT PKTournamentName PRIMARY KEY IDENTITY(1,1),
	TournamentDescription varchar(100) NOT NULL,
	TournamentAddress varchar(70) NOT NULL,
	TournamentDate DATETIME NOT NULL,
	SportsType varchar(80) NOT NULL,
	RegistrationID int NOT NULL,
	FOREIGN KEY (RegistrationID)REFERENCES Events.Registration(RegistrationID),
);

--Create INDEX

CREATE INDEX ix_Participants_FirstName
ON Events.Participents(FirstName);
GO

CREATE INDEX ix_Participants_LastName
ON Events.Participents(LastName);
GO

CREATE INDEX ix_Participants_EmailAddress
ON Events.Participents(EmailAddress);
GO

CREATE INDEX ix_Tournament_SportsType
ON Events.Tournament(SportsType);
GO

--Insert Participents Information

CREATE PROCEDURE Events.ParticipentsInsert
	@FirstName  varchar (50), 
	@LastName varchar(40),
	@BirthDate DATE,
	@EmailAddress varchar(80),
	@ParticipantPassword varchar(70)
AS
INSERT INTO Events.Participents(
	FirstName,
	LastName,
	BirthDate,
	EmailAddress,
	ParticipantPassword
)
VALUES('Goutam','Das','20/5/1998','Goutamnrg@gmail.com','55983');
GO

-- Insert Data Events

CREATE PROCEDURE Events.TournamentInsert
	@TournamentName int,
	@TournamentDescription varchar(100),
	@TournamentAddress varchar(70),
	@TournamentDate DATETIME,
	@SportsType varchar(80)
AS
INSERT INTO Events.Tournament(
	TournamentName,
	TournamentDescription,
	TournamentAddress,
	TournamentDate,
	SportsType
)
VALUES('TORONTO FC Children Day Cup','Family Event','170 Prince Blvd,Toronto,ON','30/May/2019','Soccer');
GO

-- Update procedure


CREATE PROCEDURE Events.ParticipentsUpdate 
	@ParticipentID int,
	@FirstName  varchar (50), 
	@LastName varchar(40),
	@BirthDate DATE,
	@EmailAddress varchar(80),
	@ParticipantPassword varchar(70)
AS
UPDATE Events.Participents
SET FirstName=@FirstName, LastName=@LastName, BirthDate=@BirthDate, EmailAddress=@EmailAddress
WHERE ParticipantID = @ParticipentID;
GO


EXEC Events.ParticipentsUpdate 1, 'MBBS' , 'Rock' , '08/26/1999' , 'Rokey@gmail.com' , '23564856'

SELECT * FROM Events.Participents
GO

-- STORE PROCEDURE DELETE

CREATE PROCEDURE Events.ParticipentsDelete @ParticipentID int
AS 
DELETE FROM Events.Participents
WHERE ParticipantID = @ParticipentID;
GO

EXEC Events.ParticipentsDelete 1

SELECT * FROM Events.Participents
GO

-- Payment date must in real time

ALTER TABLE Events.Registration
ADD CONSTRAINT Cons_PaymentDate
DEFAULT GETDATE() FOR PaymentDate
;
GO


ALTER TABLE Events.Participents
ADD CONSTRAINT CHK_BirthDate
CHECK (GETDATE()- convert(DateTime,BirthDate) > = 16
);
GO




