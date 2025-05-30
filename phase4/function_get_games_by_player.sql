CREATE OR REPLACE FUNCTION get_games_by_player(player_id_input INT)
RETURNS REFCURSOR AS $$
DECLARE
    player_games_cursor REFCURSOR;
BEGIN
    OPEN player_games_cursor FOR
        SELECT g.gameid, g.gamedate, g.gamelocation, 'football' AS sporttype
        FROM footballgame fg
        JOIN game g ON fg.gameid = g.gameid
        JOIN playersinmatches pim ON fg.gameid = pim.match_id
        WHERE pim.player_id = player_id_input

        UNION

        SELECT g.gameid, g.gamedate, g.gamelocation, 'basketball' AS sporttype
        FROM basketballgame bg
        JOIN game g ON bg.gameid = g.gameid
        JOIN basketballplayer bp ON bp.playerid = player_id_input
        WHERE g.gameid IN (
            SELECT gameid
            FROM basketballgame
        );

    RETURN player_games_cursor;
END;
$$ LANGUAGE plpgsql;
