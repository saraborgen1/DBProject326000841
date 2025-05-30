--הוספת עמודה של ניקוד ונתונים
ALTER TABLE basketballplayer
ADD COLUMN points INT DEFAULT 0;

UPDATE basketballplayer
SET points = FLOOR(RANDOM() * 31);
