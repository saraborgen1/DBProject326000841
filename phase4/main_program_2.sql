DO $$
BEGIN
  -- קריאה לפרוצדורה שמגדילה ניסיון של מאמנים
  CALL increase_experience_of_coaches();

  -- קריאה לפרוצדורה שמעדכנת דירוג קבוצה לפי תנאי
  CALL update_team_ranking_if_needed(1, 10, 15);
END;
$$;
