ALTER TABLE player RENAME TO player_backup;
ALTER TABLE players RENAME TO players_backup;

CREATE TABLE IF NOT EXISTS player (
  playerid INT PRIMARY KEY,
  playerfirstname VARCHAR(50) NOT NULL,
  playerlastname VARCHAR(50) NOT NULL,
  playerbirthdate DATE NOT NULL,
  playerposition VARCHAR(50) NOT NULL,
  teamid INT NOT NULL
);

CREATE TABLE IF NOT EXISTS footballplayer (
  goals INT,
  assists INT 
) INHERITS (player);

CREATE TABLE IF NOT EXISTS basketballplayer (
  playerheight INT NOT NULL,
  playerjerseynum INT NOT NULL
) INHERITS (player);

INSERT INTO footballplayer (
  playerid, playerfirstname, playerlastname,
  playerbirthdate, playerposition, teamid,
  goals, assists
)
SELECT
  player_id,
  split_part(name, ' ', 1),       -- שם פרטי
  split_part(name, ' ', 2),       -- שם משפחה
  birth_date,
  position,
  team_id,
  goals,
  assists
FROM players_backup;

INSERT INTO basketballplayer (
  playerid,
  playerfirstname,
  playerlastname,
  playerbirthdate,
  playerposition,
  teamid,
  playerheight,
  playerjerseynum
)
SELECT
  playerid,
  playerfirstname,
  playerlastname,
  playerbirthdate,
  playerposition,
  teamid,
  playerheight,
  playerjerseynum
FROM player_backup;

--בדיקה שהחיבור אכן הצליח
SELECT COUNT(*) FROM player;

------------------------------------------------------------
ALTER TABLE nationalteam RENAME TO nationalteam_backup;
ALTER TABLE teams RENAME TO teams_backup;

CREATE TABLE nationalteam (
  teamid INT PRIMARY KEY,
  teamname VARCHAR(100) NOT NULL,
  teamcountry VARCHAR(100),         -- רק בכדורסל
  uniformcolor VARCHAR(50),         -- רק בכדורסל
  fiba_ranking INT,                 -- מתאים לשני התחומים
  coachid INT,                      -- מזהה מאמן בלבד
  team_group VARCHAR(50),          -- רק בכדורגל
  sporttype VARCHAR(20) NOT NULL   -- 'basketball' או 'football'
);

INSERT INTO nationalteam (
  teamid, teamname, teamcountry,
  uniformcolor, fiba_ranking, coachid, sporttype
)
SELECT
  teamid, teamname, teamcountry,
  uniformcolor, fiba_ranking, coachid, 'basketball'
FROM nationalteam_backup;

WITH numbered_teams AS (
  SELECT *,
         ROW_NUMBER() OVER () + 1000 AS generated_coachid
  FROM teams_backup
)
INSERT INTO nationalteam (
  teamid, teamname, fiba_ranking,
  coachid, team_group, sporttype
)
SELECT
  CASE
    WHEN team_id IN (SELECT teamid FROM nationalteam)
    THEN team_id + 400
    ELSE team_id
  END AS fixed_teamid,

  team_name,
  fifa_ranking,
  generated_coachid,
  team_group,
  'football'
FROM numbered_teams;

ALTER TABLE player
ADD CONSTRAINT fk_player_team
FOREIGN KEY (teamid)
REFERENCES nationalteam(teamid);

------------------------------------
ALTER TABLE coach
ALTER COLUMN coachfirstname DROP NOT NULL,
ALTER COLUMN coachlastname DROP NOT NULL,
ALTER COLUMN experienceyears DROP NOT NULL;

INSERT INTO coach (coachid)
SELECT DISTINCT coachid
FROM nationalteam
WHERE sporttype = 'football'
AND coachid NOT IN (SELECT coachid FROM coach);

------------------------------------------
ALTER TABLE game RENAME TO game_backup;

CREATE TABLE IF NOT EXISTS game (
  gameid INT PRIMARY KEY,
  gamedate DATE NOT NULL,
  gamelocation VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS footballgame (
  score_team1 INT,
  score_team2 INT,
  stadium_id INT,
  stage_id INT,
  event_id INT,

  FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id),
  FOREIGN KEY (stage_id) REFERENCES tournamentstages(stage_id),
  FOREIGN KEY (event_id) REFERENCES matchevents(event_id)

) INHERITS (game);

CREATE TABLE IF NOT EXISTS basketballgame (
  -- אין כרגע שדות נוספים בתרשים
) INHERITS (game);

INSERT INTO footballgame (
  gameid, gamedate, gamelocation,
  score_team1, score_team2,
  stadium_id, stage_id
)
SELECT
  match_id, match_date, NULL,
  score_team1, score_team2,
  stadium_id, stage_id
FROM matches;

INSERT INTO basketballgame (
  gameid, gamedate, gamelocation
)
SELECT
  gameid, gamedate, gamelocation
FROM game_backup;

SELECT COUNT(*) FROM game;

----------------------------------------------
ALTER TABLE matchevents
DROP CONSTRAINT matchevents_player_id_fkey;

ALTER TABLE footballplayer
ADD CONSTRAINT footballplayer_playerid_unique
UNIQUE (playerid);

ALTER TABLE matchevents
ADD CONSTRAINT fk_matchevents_footballplayer
FOREIGN KEY (player_id)
REFERENCES footballplayer(playerid);

ALTER TABLE matchevents
DROP CONSTRAINT matchevents_match_id_fkey;

ALTER TABLE footballgame
ADD CONSTRAINT footballgame_gameid_unique UNIQUE (gameid);

ALTER TABLE matchevents
ADD CONSTRAINT fk_matchevents_footballgame
FOREIGN KEY (match_id)
REFERENCES footballgame(gameid);

ALTER TABLE footballgame
DROP CONSTRAINT footballgame_event_id_fkey;

----------------------------------------

ALTER TABLE Officiated_By
RENAME TO Competes_In;

ALTER TABLE game
ADD COLUMN tournamentid INT;

ALTER TABLE game
ADD CONSTRAINT fk_game_tournament
FOREIGN KEY (tournamentid)
REFERENCES tournament(tournamentid);

------------------------------------------------------
ALTER TABLE nationalteam
ADD CONSTRAINT fk_nationalteam_coach
FOREIGN KEY (coachid)
REFERENCES coach(coachid);

ALTER TABLE compets
DROP CONSTRAINT compets_teamid_fkey;

ALTER TABLE compets
ADD CONSTRAINT fk_compets_nationalteam
FOREIGN KEY (teamid)
REFERENCES nationalteam(teamid);

-------------------------------------------
ALTER TABLE footballgame
DROP COLUMN event_id;

-------------------------------------
ALTER TABLE playersinmatches
DROP CONSTRAINT IF EXISTS playersinmatches_player_id_fkey;

ALTER TABLE playersinmatches
DROP CONSTRAINT IF EXISTS playersinmatches_match_id_fkey;

ALTER TABLE playersinmatches
ADD CONSTRAINT fk_playersinmatches_footballplayer
FOREIGN KEY (player_id)
REFERENCES footballplayer(playerid);

ALTER TABLE playersinmatches
ADD CONSTRAINT fk_playersinmatches_footballgame
FOREIGN KEY (match_id)
REFERENCES footballgame(gameid);


-------------------------------
-- הוספת העמודה (אם לא קיימת עדיין)
ALTER TABLE tournamentstages
ADD COLUMN tournamentid INT;

-- הוספת מפתח זר שמקשר לתחרות המתאימה
ALTER TABLE tournamentstages
ADD CONSTRAINT fk_tournamentstages_tournament
FOREIGN KEY (tournamentid)
REFERENCES tournament(tournamentid);

ALTER TABLE tournamentstages
DROP COLUMN matches_count;

------------------------------------------------
DROP TABLE IF EXISTS nationalteam_backup CASCADE;
DROP TABLE IF EXISTS player_backup CASCADE;
DROP TABLE IF EXISTS players_backup CASCADE;
DROP TABLE IF EXISTS teams_backup CASCADE;
DROP TABLE IF EXISTS game_backup CASCADE;
DROP TABLE IF EXISTS matches CASCADE;




