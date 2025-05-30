CREATE OR REPLACE FUNCTION prevent_future_birthdate()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.playerbirthdate > CURRENT_DATE THEN
    RAISE EXCEPTION 'תאריך הלידה אינו יכול להיות בעתיד';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_future_birthdate
BEFORE INSERT OR UPDATE ON player
FOR EACH ROW
EXECUTE FUNCTION prevent_future_birthdate();
