-- מבט ראשון: מציג שחקני כדורסל עם פרטי קבוצה ושחקן
CREATE VIEW basketball_players_with_team AS
SELECT 
    bp.playerid,
    p.playerfirstname,
    p.playerlastname,
    bp.playerheight,
    bp.playerjerseynum,
    nt.teamname
FROM basketballplayer bp
JOIN player p ON bp.playerid = p.playerid
JOIN nationalteam nt ON bp.teamid = nt.teamid;

-- שאילתה 1 על מבט 1: כמה שחקנים יש בכל קבוצה
SELECT teamname, COUNT(*) AS num_players
FROM basketball_players_with_team
GROUP BY teamname;

-- שאילתה 2 על מבט 1: אילו שחקנים גובהם מעל 190 ס"מ
SELECT playerfirstname, playerlastname, playerheight
FROM basketball_players_with_team
WHERE playerheight > 190;

-- מבט שני: מציג שחקני כדורגל והמשחקים בהם השתתפו
CREATE VIEW football_players_per_game AS
SELECT 
    fp.playerid,
    p.playerfirstname,
    p.playerlastname,
    fg.gameid,
    fg.gamedate,
    fg.gamelocation
FROM footballplayer fp
JOIN player p ON fp.playerid = p.playerid
JOIN playersinmatches pim ON pim.player_id = fp.playerid
JOIN footballgame fg ON fg.gameid = pim.match_id;


-- שאילתה 1 על מבט 2: כמה משחקים שיחק כל שחקן בסך הכול
SELECT playerid, COUNT(gameid) AS total_games
FROM football_players_per_game
GROUP BY playerid
ORDER BY total_games DESC;

-- שאילתה 2 על מבט 2: הצגת שמות שחקנים כדורגל ששיחקו ביותר ממשחק אחד
SELECT playerid, playerfirstname, playerlastname, COUNT(gameid) AS num_games
FROM football_players_per_game
GROUP BY playerid, playerfirstname, playerlastname
HAVING COUNT(gameid) > 1
ORDER BY num_games DESC;

