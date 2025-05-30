CREATE OR REPLACE PROCEDURE increase_experience_of_coaches()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    increment INT;
BEGIN
    FOR rec IN 
        SELECT teamid, coachid, sporttype
        FROM nationalteam
        WHERE fiba_ranking > 50
    LOOP
        IF rec.sporttype = 'basketball' THEN
            increment := 1;
        ELSIF rec.sporttype = 'football' THEN
            increment := 2;
        ELSE
            CONTINUE;
        END IF;

        -- ננסה לעדכן, ואם לא עודכן – נכניס חדש
        UPDATE coach
        SET experienceyears = COALESCE(experienceyears, 0) + increment
        WHERE coachid = rec.coachid;

        IF NOT FOUND THEN
            INSERT INTO coach (coachid, experienceyears)
            VALUES (rec.coachid, increment)
            ON CONFLICT (coachid) DO NOTHING;
        END IF;
    END LOOP;
END;
$$;
