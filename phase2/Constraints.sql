-- אילוץ 1- שנות ניסיון של מאמן
ALTER TABLE Coach
ADD CONSTRAINT chk_experience_years_positive
CHECK (ExperienceYears >= 0 AND ExperienceYears <= 50);

--ניסיון להפר את האילוץ:
INSERT INTO Coach (CoachID, CoachFirstName, CoachLastName, ExperienceYears)
VALUES (900, 'Test', 'Coach', 75);

-- אילוץ 2 (DEFAULT) – ברירת מחדל לשנות ניסיון של שופט
ALTER TABLE Referee
ALTER COLUMN ExperienceYears SET DEFAULT 1;

--ניסיון להכניס שופט בלי לציין ניסיון:
INSERT INTO Referee (RefereeID, RefFirstName, RefLastName)
VALUES (801, 'Roni', 'Shaul');


-- אילוץ 3 (NOT NULL) – חובה לציין תאריך לידה לשחקן
ALTER TABLE Player
ALTER COLUMN PlayerBirthDate SET NOT NULL;

--ניסיון להזין שחקן בלי תאריך לידה:
INSERT INTO Player (PlayerID, PlayerFirstName, PlayerLastName, PlayerHeight, PlayerPosition, PlayerJerseyNum, TeamID)
VALUES (1000, 'Amit', 'Levi', 190, 'Guard', 12, 101);

