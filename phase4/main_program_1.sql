DO $$
DECLARE
  rec RECORD;
BEGIN
  -- מעבר על כל השחקנים והנקודות שלהם דרך הפונקציה שמחזירה טבלה
  FOR rec IN
    SELECT * FROM get_all_players_points()
  LOOP
    RAISE NOTICE 'Player ID: %, Name: % %, Total Points: %',
      rec.playerid, rec.playerfirstname, rec.playerlastname, rec.total_points;
  END LOOP;
END $$;
