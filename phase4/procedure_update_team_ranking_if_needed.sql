-- פרוצדורה: עדכון דירוג נבחרת אם ממוצע נקודות/גולים מעל סף מסוים
CREATE OR REPLACE PROCEDURE update_team_ranking_if_needed(
    target_teamid INT,
    new_ranking INT,
    threshold_points NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    avg_points NUMERIC;
    sport_type TEXT;
BEGIN
    -- שליפת סוג הספורט של הנבחרת
    SELECT sporttype INTO sport_type
    FROM nationalteam
    WHERE teamid = target_teamid;

    IF sport_type = 'basketball' THEN
        -- ממוצע סלים של שחקני כדורסל בנבחרת
        SELECT AVG(playerheight) INTO avg_points
        FROM basketballplayer
        WHERE teamid = target_teamid;

    ELSIF sport_type = 'football' THEN
        -- ממוצע גולים של שחקני כדורגל בנבחרת
        SELECT AVG(goals) INTO avg_points
        FROM footballplayer
        WHERE teamid = target_teamid;
    ELSE
        RAISE NOTICE 'Sport type not recognized: %', sport_type;
        RETURN;
    END IF;

    -- בדיקה אם הממוצע מעל הסף
    IF avg_points IS NOT NULL AND avg_points > threshold_points THEN
        UPDATE nationalteam
        SET fiba_ranking = new_ranking
        WHERE teamid = target_teamid;
        RAISE NOTICE 'Team % ranking updated to %', target_teamid, new_ranking;
    ELSE
        RAISE NOTICE 'Team % not updated, avg_points %.', target_teamid, avg_points;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred: %', SQLERRM;
END;
$$;
