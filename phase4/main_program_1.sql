DO $$
DECLARE
    rec RECORD;
BEGIN
    -- שלב 1: הפעלת הפרוצדורה לעדכון ניסיון המאמנים
    CALL increase_experience_of_coaches();

    -- שלב 2: הדפסת נקודות כל השחקנים לפי ספורט
    RAISE NOTICE 'רשימת נקודות לשחקנים:';
    
    FOR rec IN SELECT * FROM get_all_players_points()
    LOOP
        RAISE NOTICE 'ID: %, % %, Sport: %, Points: %',
            rec.playerid, rec.playerfirstname, rec.playerlastname,
            rec.sporttype, rec.total_points;
    END LOOP;
END $$;
