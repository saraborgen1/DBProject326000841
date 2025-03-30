-- שליפת כל הנתונים מכל הטבלאות
SELECT * FROM Tournament;
SELECT * FROM Coach;
SELECT * FROM Game;
SELECT * FROM Referee;
SELECT * FROM Officiated_By;
SELECT * FROM NationalTeam;
SELECT * FROM Player;
SELECT * FROM Compets;

-- ספירת כמות הרשומות בכל טבלה
SELECT 'Tournament' AS table_name, COUNT(*) FROM Tournament;
SELECT 'Coach' AS table_name, COUNT(*) FROM Coach;
SELECT 'Game' AS table_name, COUNT(*) FROM Game;
SELECT 'Referee' AS table_name, COUNT(*) FROM Referee;
SELECT 'Officiated_By' AS table_name, COUNT(*) FROM Officiated_By;
SELECT 'NationalTeam' AS table_name, COUNT(*) FROM NationalTeam;
SELECT 'Player' AS table_name, COUNT(*) FROM Player;
SELECT 'Compets' AS table_name, COUNT(*) FROM Compets;
