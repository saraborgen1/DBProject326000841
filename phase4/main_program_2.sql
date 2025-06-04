DO $$
DECLARE
    team_rec RECORD;
    threshold NUMERIC := 5;
    player_rec RECORD;
    game_rec RECORD;
    games_cursor REFCURSOR;
BEGIN
    -- שלב 1: עבור כל נבחרת, נחשב דירוג חדש שאינו שלילי
    FOR team_rec IN SELECT teamid, fiba_ranking FROM nationalteam LOOP
        CALL update_team_ranking_if_needed(
            team_rec.teamid,
            GREATEST(team_rec.fiba_ranking - 10, 0),  -- לא פחות מ־0
            threshold
        );
    END LOOP;

    -- שלב 2: עבור כל שחקן, שלוף והצג את משחקיו
    FOR player_rec IN SELECT playerid, playerfirstname, playerlastname FROM player LOOP
        RAISE NOTICE 'Games for player % % (ID: %):',
            player_rec.playerfirstname, player_rec.playerlastname, player_rec.playerid;

        games_cursor := get_games_by_player(player_rec.playerid);

        LOOP
            FETCH games_cursor INTO game_rec;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'Game ID: %, Date: %, Location: %, Sport: %',
                game_rec.gameid, game_rec.gamedate, game_rec.gamelocation, game_rec.sporttype;
        END LOOP;

        CLOSE games_cursor;
    END LOOP;
END $$;
