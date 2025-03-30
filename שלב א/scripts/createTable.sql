CREATE TABLE if not exists Tournament
(
  HostCountry varchar(50) NOT NULL,
  TournamentYear INT NOT NULL,
  TournamentID INT NOT NULL,
  PRIMARY KEY (TournamentID)
);

CREATE TABLE if not exists Coach
(
  ExperienceYears INT NOT NULL,
  CoachFirstName varchar(50) NOT NULL,
  CoachID INT NOT NULL,
  CoachLastName varchar(50) NOT NULL,
  PRIMARY KEY (CoachID)
);

CREATE TABLE if not exists Game
(
  GameDate DATE NOT NULL,
  GameID INT NOT NULL,
  GameLocation varchar(50) NOT NULL,
  TournamentID INT NOT NULL,
  PRIMARY KEY (GameID),
  FOREIGN KEY (TournamentID) REFERENCES Tournament(TournamentID)
);

CREATE TABLE if not exists Referee
(
  RefFirstName varchar(50) NOT NULL,
  RefLastName varchar(50) NOT NULL,
  RefereeID INT NOT NULL,
  ExperienceYears INT NOT NULL,
  PRIMARY KEY (RefereeID)
);

CREATE TABLE if not exists Officiated_By
(
  GameID INT NOT NULL,
  RefereeID INT NOT NULL,
  PRIMARY KEY (GameID, RefereeID),
  FOREIGN KEY (GameID) REFERENCES Game(GameID),
  FOREIGN KEY (RefereeID) REFERENCES Referee(RefereeID)
);

CREATE TABLE if not exists NationalTeam
(
  FIBA_Ranking INT NOT NULL,
  TeamCountry varchar(50) NOT NULL,
  UniformColor varchar(50) NOT NULL,
  TeamName varchar(50) NOT NULL,
  TeamID INT NOT NULL,
  CoachID INT NOT NULL,
  PRIMARY KEY (TeamID),
  FOREIGN KEY (CoachID) REFERENCES Coach(CoachID)
);

CREATE TABLE if not exists Player
(
  PlayerID INT NOT NULL,
  PlayerFirstName varchar(50) NOT NULL,
  PlayerLastName varchar(50) NOT NULL,
  PlayerBirthDate DATE NOT NULL,
  PlayerHeight INT NOT NULL,
  PlayerPosition varchar(50) NOT NULL,
  PlayerJerseyNum INT NOT NULL,
  TeamID INT NOT NULL,
  PRIMARY KEY (PlayerID),
  FOREIGN KEY (TeamID) REFERENCES NationalTeam(TeamID)
);

CREATE TABLE if not exists Compets
(
  TeamScore INT NOT NULL,
  competId INT NOT NULL,
  TeamID INT NOT NULL,
  GameID INT NOT NULL,
  TournamentID INT NOT NULL,
  PRIMARY KEY (competId),
  FOREIGN KEY (TeamID) REFERENCES NationalTeam(TeamID),
  FOREIGN KEY (GameID) REFERENCES Game(GameID),
  FOREIGN KEY (TournamentID) REFERENCES Tournament(TournamentID)
);