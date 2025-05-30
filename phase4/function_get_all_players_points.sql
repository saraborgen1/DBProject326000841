CREATE OR REPLACE FUNCTION get_all_players_points()
RETURNS TABLE (
    playerid INT,
    playerfirstname VARCHAR,
    playerlastname VARCHAR,
    sporttype VARCHAR,
    total_points INT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        bp.playerid,
        p.playerfirstname,
        p.playerlastname,
        'basketball'::VARCHAR AS sporttype,
        bp.points AS total_points
    FROM basketballplayer bp
    JOIN player p ON p.playerid = bp.playerid

    UNION

    SELECT 
        fp.playerid,
        p.playerfirstname,
        p.playerlastname,
        'football'::VARCHAR AS sporttype,
        fp.goals AS total_points
    FROM footballplayer fp
    JOIN player p ON p.playerid = fp.playerid;
END;
$$ LANGUAGE plpgsql;

