--שאילתות של SELECT
--שאילתא 1 שם נבחרת כמות שחקנים ושם המאמן שלהם
SELECT 
    N.TeamName, 
    COUNT(P.PlayerID) AS PlayerCount,
    C.CoachFirstName, 
    C.CoachLastName
FROM NationalTeam N
JOIN Player P ON N.TeamID = P.TeamID
JOIN Coach C ON N.CoachID = C.CoachID
GROUP BY N.TeamName, C.CoachFirstName, C.CoachLastName;

--שאילתא 2 כמות משחקים, קבוצות שמשחקות בכל חודש ושנה
SELECT 
    EXTRACT(YEAR FROM G.GameDate) AS Year,
    EXTRACT(MONTH FROM G.GameDate) AS Month,
    COUNT(DISTINCT G.GameID) AS NumOfGames,
    COUNT(DISTINCT C.TeamID) AS NumOfTeams
FROM Game G
JOIN Compets C ON G.GameID = C.GameID
GROUP BY Year, Month
ORDER BY Year ASC, Month ASC;

--שאילתא 3 מציגה את השחקן הגבוה ביותר מכל נבחרת
SELECT 
    P.PlayerID,
    P.PlayerFirstName,
    P.PlayerLastName,
    N.TeamName,
    P.PlayerHeight
FROM Player P
JOIN NationalTeam N ON P.TeamID = N.TeamID
WHERE (P.TeamID, P.PlayerHeight) IN (
    SELECT TeamID, MAX(PlayerHeight)
    FROM Player
    GROUP BY TeamID
)
ORDER BY P.PlayerHeight DESC;

--שאילתא 4 מציגה ממוצע דירוג פיב"א לפי מיקום המשחק
SELECT 
    G.GameLocation,
    ROUND(AVG(N.FIBA_Ranking), 2) AS AvgFibaRanking,
    COUNT(DISTINCT G.GameID) AS NumOfGames,
    COUNT(DISTINCT C.TeamID) AS NumOfTeams
FROM Game G
JOIN Compets C ON G.GameID = C.GameID
JOIN NationalTeam N ON C.TeamID = N.TeamID
GROUP BY G.GameLocation
ORDER BY AvgFibaRanking ASC;

-- שאילתא 5 מציגה מספר משחקים ששפט כל שופט בכל שנה
SELECT 
    R.RefereeID,
    R.RefFirstName, 
    R.RefLastName,
    EXTRACT(YEAR FROM G.GameDate) AS Year,
    COUNT(*) AS NumOfGames
FROM Referee R
JOIN Officiated_By OB ON R.RefereeID = OB.RefereeID
JOIN Game G ON OB.GameID = G.GameID
GROUP BY R.RefereeID, R.RefFirstName, R.RefLastName, Year
ORDER BY Year ASC, NumOfGames DESC;

--שאילתא 6 ממינת שחקנים לפי עמדה זהה
SELECT 
    P.PlayerID,
    P.PlayerFirstName,
    P.PlayerLastName,
    N.TeamName,
    P.PlayerPosition
FROM Player P
JOIN NationalTeam N ON P.TeamID = N.TeamID
ORDER BY P.PlayerPosition ASC, P.PlayerLastName ASC;

--שאילתא 7 מציגה משחקים שבהם הפרש הנקודות היה יותר מ20
SELECT 
    G.GameID,
    G.GameDate,
    G.GameLocation,
    MAX(C.TeamScore) - MIN(C.TeamScore) AS ScoreDifference
FROM Game G
JOIN Compets C ON G.GameID = C.GameID
GROUP BY G.GameID, G.GameDate, G.GameLocation
HAVING MAX(C.TeamScore) - MIN(C.TeamScore) > 20
ORDER BY ScoreDifference DESC;

--שאילתא 8 מציגה את השחקן הצעיר בכל נבחרת
SELECT 
    P.PlayerID,
    P.PlayerFirstName,
    P.PlayerLastName,
    N.TeamName,
    P.PlayerBirthDate
FROM Player P
JOIN NationalTeam N ON P.TeamID = N.TeamID
WHERE P.PlayerBirthDate = (
    SELECT MAX(P2.PlayerBirthDate)
    FROM Player P2
    WHERE P2.TeamID = P.TeamID
)
ORDER BY N.TeamName;

--שאילתות של UPDATE
--UPDATE 1 – הגדלת שנות ניסיון למאמנים של קבוצות ששיחקו מעל 3 משחקים
UPDATE Coach
SET ExperienceYears = ExperienceYears + 1
WHERE CoachID IN (
    SELECT N.CoachID
    FROM NationalTeam N
    JOIN Compets C ON N.TeamID = C.TeamID
    GROUP BY N.CoachID
    HAVING COUNT(C.GameID) > 3
);

-- UPDATE 2- הורדת גובה לכל השחקנים בין 10-15 ס"מ 
UPDATE Player
SET PlayerHeight = PlayerHeight - FLOOR(RANDOM() * 6 + 10)
WHERE PlayerHeight > 210;

-- UPDATE 3 – "Center"עדכון עמדה  של שחקנים גבוהים מאוד ל־
UPDATE Player
SET PlayerPosition = 'Center'
WHERE PlayerHeight >= 205 AND PlayerPosition <> 'Center';

--DELETE שאילתות של 
--DELETE 1 – מחיקת קבוצות מתחרות שאין להן אף שחקן
DELETE FROM Compets
WHERE TeamID NOT IN (
    SELECT TeamID FROM Player
);

--DELETE 2 – מחיקת קבוצות שאין להן אף שחקן
DELETE FROM NationalTeam
WHERE TeamID NOT IN (
    SELECT DISTINCT TeamID FROM Player
);

--DELETE 3 – מחיקת שופטים שלא שפטו אף משחק
DELETE FROM Referee
WHERE RefereeID NOT IN (
    SELECT DISTINCT RefereeID FROM Officiated_By
);






