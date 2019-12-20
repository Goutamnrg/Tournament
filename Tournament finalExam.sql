CREATE DATABASE TOURNAMENTS_CA_GOUTAM;
GO

CREATE SCHEMA TOURNAMENTS;
GO

CREATE TABLE TOURNAMENTS.Registration(
	RegistrationID int CONSTRAINT  PKRegistrationID PRIMARY KEY IDENTITY(1,1),
	RegistrationCost Money,
	AmountPaid Money,
	PaymentDate DATETIME,
	TournamentID varchar(70),
	RegistrationEndDate DATETIME
);

CREATE TABLE TOURNAMENTS.Participents(
	ParticipantID int CONSTRAINT PKParticipentID PRIMARY KEY IDENTITY(1,1),
	FirstName  varchar (50),
	LastName varchar(40),
	BirthDate DATETIME,
	EmailAddress varchar(80),
	ParticipantPassword varchar(70),
	RegistrationID int,
	FOREIGN KEY (RegistrationID)REFERENCES TOURNAMENTS.Registration(RegistrationID),
);

CREATE TABLE TOURNAMENTS.Tournament(
	TournamentName int CONSTRAINT PKTournamentName PRIMARY KEY IDENTITY(1,1),
	TournamentDescription varchar(100),
	TournamentAddress varchar(70),
	TournamentDate DATETIME,
	SportsType varchar(80),
	RegistrationID int,
	FOREIGN KEY (RegistrationID)REFERENCES TOURNAMENTS.Registration(RegistrationID),
);

