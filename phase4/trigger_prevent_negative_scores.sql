-- פונקציה: מונעת תוצאה שלילית בכדורגל
CREATE OR REPLACE FUNCTION prevent_negative_scores()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.score_team1 < 0 OR NEW.score_team2 < 0 THEN
        RAISE EXCEPTION 'Cannot insert negative score for a football game.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- טריגר: מפעיל את הפונקציה לפני כל הוספה או עדכון בטבלת footballgame
CREATE TRIGGER trg_prevent_negative_scores
BEFORE INSERT OR UPDATE ON footballgame
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_scores();
