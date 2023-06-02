/*       DATABASE CREATION        */
CREATE DATABASE dbproj2;
GO

/*    BASIC DATABASE STRUCTURE    */
CREATE PROCEDURE createAllTables
AS
    CREATE TABLE SystemUser (
        username VARCHAR(20) PRIMARY KEY,
        password VARCHAR(20)
    )

    CREATE TABLE SystemAdmin (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE SportsAssociationManager (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Fan (
        national_id VARCHAR(20) PRIMARY KEY,
        birth_date DATETIME,
        status BIT,
        phone_number INT,
        address VARCHAR(20),
        name VARCHAR(20),
        username VARCHAR(20),
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Club (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        location VARCHAR(20)
    )   

    CREATE TABLE Stadium (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        capacity INT,
        location VARCHAR(20),
        status BIT
    )

    CREATE TABLE ClubRepresentative (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        club_id INT,
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(club_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE StadiumManager (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        stadium_id INT,
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(stadium_id) REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Match (
        id INT PRIMARY KEY IDENTITY(1,1),
        start_time DATETIME,
        end_time DATETIME,
        stadium_id INT,
        host_club_id INT,
        guest_club_id INT,
        FOREIGN KEY(stadium_id) REFERENCES Stadium(id) on delete set null, 
        FOREIGN KEY(host_club_id) REFERENCES Club(id) on delete CASCADE,
        FOREIGN KEY(guest_club_id) REFERENCES Club(id) ON DELETE NO ACTION
    )

    CREATE TABLE HostRequest (
        id INT PRIMARY KEY IDENTITY(1,1),
        status VARCHAR(20),
        match_id INT,
        asked_by_id INT,
        handled_by_id INT,
        FOREIGN KEY(match_id) REFERENCES Match(id) on delete cascade,
        FOREIGN KEY(asked_by_id) REFERENCES ClubRepresentative(id) ON DELETE NO ACTION ,
        FOREIGN KEY(handled_by_id) REFERENCES StadiumManager(id) ON DELETE CASCADE ON UPDATE CASCADE,
        CHECK ( status IN ('UNHANDLED', 'REJECTED', 'ACCEPTED') )
    )

    CREATE TABLE Ticket (
        id INT PRIMARY KEY IDENTITY(1,1),
        status BIT,
        match_id INT,
        FOREIGN KEY(match_id) REFERENCES Match(id) on delete cascade on update cascade
    )

    CREATE TABLE TicketBuyingTransaction (
        fan_national_id VARCHAR(20),
        ticket_id INT PRIMARY KEY,
        FOREIGN KEY(fan_national_id) REFERENCES Fan(national_id),
        FOREIGN KEY(ticket_id) REFERENCES Ticket(id)
    )
GO

/* CREATE ALL TABLES */
EXEC createAllTables
GO

INSERT INTO SystemUser VALUES ('admin','admin')
INSERT INTO SystemAdmin VALUES ('admin_name','admin')
GO

CREATE PROCEDURE dropAllTables
AS
    DROP TABLE SystemAdmin
    DROP TABLE HostRequest
    DROP TABLE SportsAssociationManager
    DROP TABLE TicketBuyingTransaction
    DROP TABLE Fan
    DROP TABLE ClubRepresentative
    DROP TABLE StadiumManager
    DROP TABLE Ticket
    DROP TABLE Match
    DROP TABLE Stadium
    DROP TABLE Club
    DROP TABLE SystemUser
GO

CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
    DROP PROCEDURE createAllTables
    DROP PROCEDURE dropAllTables
    DROP PROCEDURE clearAllTables
    DROP VIEW allAssocManagers
    DROP VIEW allClubRepresentatives
    DROP VIEW allStadiumManagers
    DROP VIEW allFans
    DROP VIEW allMatches
    DROP VIEW allTickets
    DROP VIEW allClubs
    DROP VIEW allStadiums
    DROP VIEW allRequests
    DROP PROCEDURE addAssociationManager
    DROP PROCEDURE addNewMatch
    DROP VIEW clubsWithNoMatches
    DROP PROCEDURE deleteMatch
    DROP PROCEDURE deleteMatchesOnStadium
    DROP PROCEDURE addClub
    DROP PROCEDURE addTicket
    DROP PROCEDURE deleteClub
    DROP PROCEDURE addStadium
    DROP PROCEDURE deleteStadium
    DROP PROCEDURE blockFan
    DROP PROCEDURE unblockFan
    DROP PROCEDURE addRepresentative
    DROP FUNCTION viewAvailableStadiumsOn
    DROP PROCEDURE addHostRequest
    DROP FUNCTION allUnassignedMatches
    DROP PROCEDURE addStadiumManager
    DROP FUNCTION allPendingRequests
    DROP PROCEDURE acceptRequest
    DROP PROCEDURE rejectRequest
    DROP PROCEDURE addFan
    DROP FUNCTION upcomingMatchesOfClub
    DROP FUNCTION availableMatchesToAttend
    DROP PROCEDURE purchaseTicket
    DROP PROCEDURE updateMatchHost
    DROP VIEW matchesPerTeam
    DROP VIEW clubsNeverMatched
    DROP FUNCTION clubsNeverPlayed
    DROP FUNCTION matchWithHighestAttendance
    DROP FUNCTION matchesRankedByAttendance
    DROP FUNCTION requestsFromClub
GO

CREATE PROCEDURE clearAllTables
AS
    DELETE FROM SystemUser
    DELETE FROM SystemAdmin
    DELETE FROM SportsAssociationManager
    DELETE FROM Fan
    DELETE FROM ClubRepresentative
    DELETE FROM HostRequest
    DELETE FROM StadiumManager
    DELETE FROM Stadium
    DELETE FROM Match
    DELETE FROM TicketBuyingTransaction
    DELETE FROM Club
    DELETE FROM Ticket
GO

/*      BASIC DATA RETRIEVAL     */
CREATE VIEW allAssocManagers AS
SELECT S.username, U.password, S.name
FROM SportsAssociationManager S, SystemUser U
WHERE U.username = S.username
GO

CREATE VIEW allClubRepresentatives AS
SELECT R.username, U.password, R.name, C.name AS club_name
FROM ClubRepresentative R INNER JOIN SystemUser U ON R.username = U.username 
     LEFT OUTER JOIN Club C ON R.club_id = C.id
GO

CREATE VIEW allStadiumManagers AS
SELECT M.username, U.password, M.name, S.name AS stadium_name 
FROM StadiumManager M INNER JOIN SystemUser U ON M.username = U.username 
     LEFT OUTER JOIN Stadium S ON M.stadium_id = S.id
GO

CREATE VIEW allFans AS
SELECT F.username, U.password, F.name, F.national_id, F.birth_date, F.status
FROM Fan F, SystemUser U
WHERE F.username = U.username
GO

CREATE VIEW allMatches AS
SELECT C1.name AS host_club, C2.name AS guest_club, M.start_time
FROM Club C1, Club C2, Match M
WHERE M.host_club_id = C1.id AND M.guest_club_id = C2.id
GO

CREATE VIEW allTickets AS
SELECT C1.name AS host_club, C2.name AS guest_club, S.name AS stadium_name, M.start_time
FROM Ticket T INNER JOIN Match M ON T.match_id = M.id INNER JOIN Club C1 ON 
     M.host_club_id = C1.id INNER JOIN Club C2 
     ON M.guest_club_id = C2.id LEFT OUTER JOIN Stadium S ON M.stadium_id = S.id
GO

CREATE VIEW allClubs AS
SELECT name, location
FROM Club
GO

CREATE VIEW allStadiums AS
SELECT name, location, capacity, status
FROM Stadium;
GO

CREATE VIEW allRequests AS
SELECT C.username AS club_rep_username, M.username AS stad_manager_username, R.status
FROM ClubRepresentative C, StadiumManager M, HostRequest R
WHERE C.id = R.asked_by_id AND M.id = R.handled_by_id;
GO

/*      ALL OTHER DATA RETRIEVAL     */
CREATE PROCEDURE addAssociationManager
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20),
@success INT OUTPUT
AS
    SET @success = 0
    DECLARE @f INT
    DECLARE @x int
    SET @f = 0

    SELECT @f = 1 FROM SystemUser
    WHERE EXISTS (SELECT S1.username
                  FROM SystemUser S1 
                  WHERE S1.username = @username)
    IF(@f=0)
    BEGIN
        INSERT INTO SystemUser VALUES (@username, @password)  
        INSERT INTO SportsAssociationManager VALUES (@name, @username)
        SET @success = 1
        RETURN
    END

    ELSE
    BEGIN
        SELECT @f = 2 FROM SystemUser
        WHERE EXISTS (SELECT S1.username
                      FROM SystemUser S1 
                      WHERE S1.password = @password AND S1.username = @username) 
        IF @f = 1
        BEGIN
            SELECT 'USERNAME ALREADY EXIST WITH A DIFFERENT PASSWORD'
            SET @success = 0
            RETURN
        END 

        ELSE
        BEGIN  
         INSERT INTO SportsAssociationManager VALUES (@name, @username)
         SET @success = 1
        END
    END
GO

CREATE PROCEDURE addNewMatch
@chname VARCHAR(20),
@cgname VARCHAR(20),
@start_time DATETIME,
@end_time DATETIME
AS
    DECLARE @x INT
    DECLARE @y INT

    SELECT @x = C1.id FROM Club C1 WHERE C1.name = @chname
    SELECT @y = C2.id FROM Club C2 WHERE C2.name = @cgname

    IF(@x IS NOT NULL AND @y IS NOT NULL)
        INSERT INTO Match VALUES(@start_time, @end_time, NULL, @x, @y)
GO

CREATE VIEW clubsWithNoMatches
AS
(SELECT C.name FROM Club C)
EXCEPT 
(SELECT C1.name FROM Club C1, Match M WHERE M.host_club_id = C1.id OR M.guest_club_id = C1.id)
GO

CREATE PROCEDURE deleteMatch
@chname VARCHAR(20),
@cgname VARCHAR(20)
AS
    DECLARE @x INT
    DECLARE @y INT

    SELECT @x = C1.id FROM Club C1 WHERE C1.name = @chname
    SELECT @y = C2.id FROM Club C2 WHERE C2.name = @cgname

    DELETE FROM Match WHERE host_club_id = @x AND guest_club_id = @y
GO

CREATE PROCEDURE deleteMatchesOnStadium
@stadium VARCHAR(20)
AS
  DECLARE @stad_id INT
  SELECT @stad_id = S.id from Stadium S WHERE S.name = @stadium
  DELETE FROM Match WHERE stadium_id = @stad_id AND CURRENT_TIMESTAMP < start_time
GO

CREATE PROCEDURE addClub
@cname VARCHAR(20),
@cl VARCHAR(20)
AS
    INSERT INTO Club VALUES (@cname, @cl)
GO

CREATE PROCEDURE addTicket
@chname VARCHAR(20),
@cgname VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @match_id INT
    DECLARE @stadid INT
    DECLARE @numTickets INT
    DECLARE @stadCap INT

    DECLARE @x INT
    DECLARE @y INT
    SELECT @x = C1.id FROM Club C1 WHERE C1.name = @chname
    SELECT @y = C2.id FROM Club C2 WHERE C2.name = @cgname

    SELECT @match_id = M.id,@stadid = M.stadium_id FROM Match M 
    WHERE M.host_club_id = @x AND M.guest_club_id = @y
    AND M.start_time = @datetime
    IF @match_id IS NULL 
    BEGIN
     SELECT 'THIS MATCH DOES NOT EXIST'
     RETURN
    END
    IF @stadid IS NULL
        BEGIN 
        SELECT 'CANNOT ADD TICKET AS THE STADIUM MUST BE SET FIRST'
    END
    ELSE
    BEGIN
        SELECT @stadCap = S.capacity
        FROM Match inner join Stadium S on (Match.stadium_id = S.id)
        WHERE @match_id = Match.id
    
        SELECT @numTickets = count(*)
        FROM Ticket T
        WHERE T.match_id = @match_id

        IF @numTickets>= @stadCap 
        BEGIN
            SELECT 'STADIUM CAPACITY FULL'
        END

        ELSE
        BEGIN
            INSERT INTO Ticket(status, match_id) VALUES(1, @match_id)
        END
    END
GO

CREATE PROCEDURE deleteClub
@cname VARCHAR(20)
AS
    DECLARE @gid INT
    SELECT @gid = C.id FROM CLUB C WHERE C.name = @cname

    DELETE FROM HostRequest WHERE HostRequest.match_id = ANY(
        SELECT M.id FROM Match M inner join CLub C on (M.guest_club_id = @gid OR M.host_club_id = @gid)
        )
    
    DELETE FROM Match WHERE Match.guest_club_id = @gid OR Match.host_club_id = @gid 
    DELETE FROM Club WHERE Club.name = @cname
GO

CREATE PROCEDURE addStadium
@sname VARCHAR(20),
@sl VARCHAR(20),
@sc INT
AS
    /* 1 means that the stadium is available */
    INSERT INTO Stadium VALUES (@sname, @sc, @sl, 1)
GO

CREATE PROCEDURE deleteStadium
@sname VARCHAR(20)
AS
    DELETE FROM Stadium WHERE Stadium.name = @sname
GO

CREATE PROCEDURE blockFan
@f_n VARCHAR(20) 
AS
    UPDATE Fan SET Fan.status = 0 WHERE Fan.national_id = @f_n
GO

CREATE PROCEDURE unblockFan
@f_n VARCHAR(20)
AS
    UPDATE Fan SET Fan.status = 1 WHERE Fan.national_id = @f_n
GO

CREATE PROCEDURE addRepresentative
@rname VARCHAR(20),
@cname VARCHAR(20),
@ruser VARCHAR(20),
@rp VARCHAR(20),
@success INT OUTPUT
AS
    SET @success = 0

    DECLARE @fll INT
    SELECT @fll = 1 FROM Club C INNER JOIN ClubRepresentative CR on (C.id = CR.club_id) WHERE C.name = @cname
    IF (@fll = 1)
    BEGIN
        SELECT 'THERE IS ALREADY A REPRESENTATIVE FOR THIS CLUB'
        SET @success = 0
        RETURN
    END

    DECLARE @f INT
    DECLARE @x int
    SET @f = 0
    SELECT @f = 1 FROM SystemUser
    WHERE EXISTS (SELECT S1.username
                  FROM SystemUser S1 
                 WHERE  S1.username = @ruser)
    IF(@f=0)
    BEGIN
        SELECT @x = C.id FROM Club C WHERE C.name = @cname
        IF @x IS NULL
        BEGIN
            SELECT 'CLUB NAME IS INVALID'
            SET @success = 0
            RETURN
        END
        INSERT INTO SystemUser values ( @ruser, @rp)  
        INSERT INTO ClubRepresentative values (@rname, @ruser, @x)
        SET @success = 1
        RETURN
    END

    ELSE
    BEGIN
        SELECT @f = 2 FROM SystemUser
        WHERE EXISTS (SELECT S1.username
                      FROM SystemUser S1 
                      WHERE S1.password = @rp AND S1.username = @ruser) 
        IF @f = 1
        BEGIN
            SELECT 'USERNAME ALREADY EXIST WITH A DIFFERENT PASSWORD'
            SET @success = 0
            RETURN
        END 

        ELSE
        BEGIN  
         SELECT @x = C.id FROM Club C WHERE C.name = @cname
         INSERT INTO ClubRepresentative values (@rname, @ruser, @x)
         SET @success = 1
        END
    END
GO

CREATE FUNCTION viewAvailableStadiumsOn
(@datetime DATETIME)
RETURNS TABLE
AS
RETURN
(
    SELECT S.name, S.location, S.capacity FROM Stadium S
    WHERE S.status = 1 AND 
    NOT EXISTS 
    (
    SELECT M.id FROM Match M 
    WHERE M.stadium_id = S.id AND M.start_time <= @datetime AND M.end_time >= @datetime
    )
)
GO

CREATE PROCEDURE addHostRequest
@cname VARCHAR(20),
@sname VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @host INT
    DECLARE @rep_id INT
    DECLARE @man_id INT
    DECLARE @stad_id INT
    DECLARE @match_id INT
    
    SELECT @host = C.id from Club C where C.name = @cname
    SELECT @rep_id = R.id FROM ClubRepresentative R, Club C WHERE R.club_id = C.id and C.name = @cname
    SELECT @stad_id = S.id FROM Stadium S WHERE S.name = @sname
    SELECT @man_id = M.id FROM StadiumManager M, Stadium S WHERE M.stadium_id = S.id AND S.name = @sname
    SELECT @match_id = M.id FROM Match M WHERE  M.start_time = @datetime AND M.host_club_id = @host

    INSERT INTO HostRequest VALUES('UNHANDLED', @match_id, @rep_id, @man_id)
GO

CREATE FUNCTION allUnassignedMatches
(@chname VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT CG.name, M.start_time FROM Match M, Club CH, Club CG
    WHERE CH.name = @chname AND M.host_club_id = CH.id AND M.guest_club_id = CG.id
    AND M.stadium_id IS NULL
)
GO

CREATE PROCEDURE addStadiumManager
@name VARCHAR(20),
@stname VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20),
@success INT OUTPUT
AS
    SET @success = 0
    DECLARE @fll INT
    SELECT @fll = 1 FROM Stadium S INNER JOIN StadiumManager SM ON (S.id = SM.stadium_id) WHERE S.name = @stname
    IF (@fll = 1)
    BEGIN
        SELECT 'THERE IS ALREADY A MANAGER FOR THIS STADIUM'
        SET @success = 0
        RETURN
    END

    DECLARE @f INT
    DECLARE @x int
    SET @f = 0

    SELECT @f = 1 FROM SystemUser
    WHERE EXISTS (SELECT S1.username
                  FROM SystemUser S1 
                  WHERE S1.username = @username)
    IF(@f=0)
    BEGIN
        SELECT @x = S.id FROM Stadium S WHERE S.name = @stname
        IF @x IS NULL
        BEGIN
            SELECT 'STADIUM NAME IS INVALID'
            SET @success = 0
            RETURN
        END
        INSERT INTO SystemUser VALUES (@username, @password)  
        INSERT INTO StadiumManager VALUES (@name, @username, @x)
        SET @success = 1
    END

    ELSE
    BEGIN
        SELECT @f = 2 FROM SystemUser
        WHERE EXISTS (SELECT S1.username
                      FROM SystemUser S1 
                      WHERE S1.password = @password AND S1.username = @username) 
        IF @f = 1
        BEGIN
            SELECT 'USERNAME ALREADY EXIST WITH A DIFFERENT PASSWORD'
            SET @success = 0
            RETURN
        END 

        ELSE
        BEGIN  
         SELECT @x = S.id FROM Stadium S WHERE S.name = @stname
         INSERT INTO StadiumManager VALUES (@name, @username, @x)
         SET @success = 1
        END
    END
GO

CREATE FUNCTION allPendingRequests
(@username VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT CR.name AS club_representative, C.name AS guest, M.start_time
    FROM HostRequest HR, Match M, ClubRepresentative CR, Club C,StadiumManager SM
    WHERE HR.match_id = M.id AND CR.id = HR.asked_by_id AND C.id = M.guest_club_id AND HR.status = 'UNHANDLED'
    AND SM.username=@username AND HR.handled_by_id = SM.id
)
GO

CREATE PROCEDURE acceptRequest
@username VARCHAR(20),
@chname VARCHAR(20),
@c2name VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @manId int
    DECLARE @matchId int
    DECLARE @reqId int
    DECLARE @stadId int
    DECLARE @c_rep int
    DECLARE @f int
    DECLARE @size int
    
    SELECT @manId = SD.id,@stadId = SD.stadium_id FROM StadiumManager SD WHERE SD.username= @username
    
    SELECT @size = S.capacity FROM Stadium S WHERE S.id = @stadId

    SELECT @matchId = M.id,@c_rep = CR.id
    FROM Match M inner join Club C1 on (M.host_club_id=C1.id AND @chname = C1.name ) 
    inner join Club C2 on (M.guest_club_id=C2.id AND @c2name = C2.name)
    inner join ClubRepresentative CR on (C1.id = CR.club_id)
    WHERE M.start_time = @datetime

    update HostRequest set HostRequest.status = 'ACCEPTED'  
    WHERE HostRequest.match_id = @matchId AND HostRequest.handled_by_id = @manId 
    AND HostRequest.asked_by_id = @c_rep AND HostRequest.status = 'UNHANDLED'

    DECLARE @i INT = 0;
    WHILE @i < @size
        BEGIN
        EXEC addTicket @chname, @c2name, @datetime
        SET @i = @i + 1;
        END;

    SELECT @f=1  FROM HostRequest
    WHERE HostRequest.match_id = @matchId AND HostRequest.handled_by_id = @manId 
    AND HostRequest.asked_by_id = @c_rep
    if @f IS NULL
    BEGIN
        SELECT 'Wrong accept request'
    END 
    ELSE 
    BEGIN

    UPDATE Match SET Match.stadium_id = @stadId WHERE Match.ID = @matchId
    DECLARE @Counter INT 
    SELECT @Counter=S.capacity FROM Stadium S WHERE S.id=@stadId
   
    END   
GO

CREATE PROCEDURE rejectRequest
@username VARCHAR(20),
@chname VARCHAR(20),
@c2name VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @x INT

    SELECT @x = H.id
    FROM HostRequest H, StadiumManager SM, Club CH, Club C2, Match M 
    WHERE SM.username = @username AND CH.name = @chname AND C2.name = @c2name 
    AND M.host_club_id = CH.id AND M.guest_club_id = C2.id
    AND M.start_time = @datetime
    AND H.match_id = M.id AND SM.id = H.handled_by_id 

    UPDATE HostRequest SET status = 'REJECTED' WHERE HostRequest.id = @x AND HostRequest.status = 'UNHANDLED'
GO

CREATE PROCEDURE addFan
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20),
@national_id VARCHAR(20),
@birth_date DATETIME,
@address VARCHAR(20),
@phone_no INT,
@success INT OUTPUT
AS
    SET @success = 0

    DECLARE @f INT
    DECLARE @x int
    SET @f = 0

    SELECT @f = 1 FROM SystemUser
    WHERE EXISTS (SELECT S1.username
                  FROM SystemUser S1 
                  WHERE S1.username = @username)
    IF(@f=0)
    BEGIN
        INSERT INTO SystemUser VALUES (@username, @password)  
        INSERT INTO Fan VALUES (@national_id, @birth_date, 1, @phone_no, @address, @name, @username)
        SET @success = 1
        RETURN
    END

    ELSE
    BEGIN
        SELECT @f = 2 FROM SystemUser
        WHERE EXISTS (SELECT S1.username
                      FROM SystemUser S1 
                      WHERE S1.password = @password AND S1.username = @username) 
        IF @f = 1
        BEGIN
            SELECT 'USERNAME ALREADY EXIST WITH A DIFFERENT PASSWORD'
            SET @success = 0
            RETURN
        END 

        ELSE
        BEGIN  
         INSERT INTO Fan VALUES (@national_id, @birth_date, 1, @phone_no, @address, @name, @username)
         SET @success = 1
        END
    END
GO

CREATE FUNCTION upcomingMatchesOfClub
(@cname VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT C1.name AS club, C2.name AS competing_club, M.start_time, CASE WHEN M.stadium_id IS NULL THEN NULL ELSE S.name END  AS stadium_name
    FROM Match M inner join Club C1 on ((C1.id = M.host_club_id OR C1.id = M.guest_club_id) AND C1.name = @cname)
    INNER JOIN Club C2 ON ((C2.id = M.host_club_id OR C2.id = M.guest_club_id) and C2.name <> @cname)
    left outer join Stadium S ON (M.stadium_id = S.id)
    WHERE CURRENT_TIMESTAMP < M.start_time 
)
GO

CREATE FUNCTION availableMatchesToAttend
(@datetime DATETIME)
RETURNS TABLE
AS
RETURN
(
    SELECT CH.name AS host_club, C2.name AS guest_club, M.start_time, S.name AS stadium_name
    FROM Club CH, Club C2, Match M left outer join Stadium S on (M.stadium_id = S.id)
    WHERE M.host_club_id = CH.id AND M.guest_club_id = C2.id 
    AND M.start_time >= @datetime
    AND EXISTS (SELECT T.id FROM Ticket T WHERE T.match_id = M.id AND T.status = 1)
)
GO

CREATE PROCEDURE purchaseTicket
@national_id VARCHAR(20),
@chname VARCHAR(20),
@cgname VARCHAR(20),
@datetime DATETIME,
@isblocked INT OUTPUT
AS
    SET @isblocked = 0
    DECLARE @fll BIT
    SELECT @fll = 1 FROM Fan WHERE Fan.national_id = @national_id
    IF (@fll <> 1)
    BEGIN
        SELECT 'FAN WITH GIVEN NATIONAL ID DOES NOT EXIST' AS Error
        RETURN
    END

    DECLARE @t_id INT
    DECLARE @f BIT
    SET @f = 0

    SELECT @f = 1 FROM Fan WHERE Fan.national_id = @national_id AND Fan.status = 0

    IF @f = 0
    BEGIN
        SELECT @t_id = T.id 
        FROM Ticket T, Match M, Club CH, Club CG
        WHERE CH.name = @chname AND CG.name = @cgname
        AND M.host_club_id = CH.id AND M.guest_club_id = CG.id
        AND M.start_time = @datetime AND T.status = 1

        IF @t_id IS NULL 
        BEGIN
            SELECT 'NO AVAILABLE TICKETS'
            RETURN
        END

        ELSE
        BEGIN
            INSERT INTO TicketBuyingTransaction VALUES (@national_id, @t_id)
            UPDATE Ticket SET status = 0 WHERE id = @t_id
        END
    END

    ELSE
    BEGIN
        SELECT 'Fan is blocked'
        SET @isblocked = 1
        RETURN
    END 
GO

CREATE PROCEDURE updateMatchHost
@chname VARCHAR(20),
@cgname VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @m_id INT
    DECLARE @h_id INT
    DECLARE @g_id INT

    SELECT @m_id = M.id, @h_id = CH.id, @g_id = CG.id 
    FROM Match M, Club CH, Club CG
    WHERE CH.name = @chname AND CG.name = @cgname AND M.host_club_id = CH.id 
    AND M.guest_club_id = CG.id AND M.start_time = @datetime

    UPDATE Match SET host_club_id = @g_id WHERE id = @m_id
    UPDATE Match SET guest_club_id = @h_id WHERE id = @m_id
GO

CREATE VIEW matchesPerTeam
AS
    (
    SELECT C.name AS club_name, Count(M.id) AS matches_played_count
    FROM Club C, Match M
    WHERE (M.host_club_id = C.id OR M.guest_club_id = C.id)
    AND CURRENT_TIMESTAMP > M.end_time
    GROUP BY C.name
    )UNION 
    (
    SELECT C1.name AS club_name, 0 AS matches_played_count
    FROM Club C1
    WHERE NOT EXISTS (SELECT C.name AS club_name, Count(M.id) AS matches_played_count
                    FROM Club C, Match M
                    WHERE (M.host_club_id = C.id OR M.guest_club_id = C.id)
                    AND CURRENT_TIMESTAMP > M.end_time AND C1.id = C.id
                    GROUP BY C.name)
    )
GO

CREATE VIEW clubsNeverMatched
AS
    SELECT C1.name AS first_club, C2.name AS second_club
    FROM Club C1, Club C2 
    WHERE C1.id > C2.id AND NOT EXISTS 
    (
        SELECT M.id FROM Match M WHERE 
        (M.host_club_id = C1.id AND M.guest_club_id = C2.id AND CURRENT_TIMESTAMP > M.start_time)
        OR
        (M.host_club_id = C2.id AND M.guest_club_id = C1.id AND CURRENT_TIMESTAMP > M.start_time)
    )
GO

CREATE FUNCTION clubsNeverPlayed
(@cname VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT C2.name 
    FROM Club C1, Club C2 
    WHERE C1.name = @cname AND C1.id <> C2.id AND NOT EXISTS
    (
    SELECT M.id FROM Match M WHERE
    (M.host_club_id = C1.id AND M.guest_club_id = C2.id AND CURRENT_TIMESTAMP > M.start_time)
    OR
    (M.host_club_id = C2.id AND M.guest_club_id = C1.id AND CURRENT_TIMESTAMP > M.start_time)
    )
)
GO

CREATE FUNCTION matchWithHighestAttendance
()
RETURNS TABLE
AS
RETURN
(   
    SELECT TOP 1 CH.name AS host_club, CG.name AS guest_club
    FROM Match M, Ticket T, Club CH, Club CG,TicketBuyingTransaction TBT
    WHERE TBT.ticket_id = T.id AND T.match_id = M.id AND M.host_club_id = CH.id AND 
          M.guest_club_id = CG.id
    GROUP BY M.id, CH.name, CG.name
    ORDER BY Count(T.id) DESC       
)
GO

CREATE FUNCTION matchesRankedByAttendance
()
RETURNS TABLE
AS
RETURN
(
    SELECT CH.name AS host_club, CG.name AS guest_club
    FROM Match M, Ticket T, Club CH, Club CG, TicketBuyingTransaction TBT
    WHERE TBT.ticket_id = T.id AND T.match_id = M.id AND M.host_club_id = CH.id AND
          M.guest_club_id = CG.id AND CURRENT_TIMESTAMP > M.end_time
    GROUP BY M.id, CH.name, CG.name
    ORDER BY Count(T.id) DESC OFFSET 0 rows
)
GO

CREATE FUNCTION requestsFromClub
(
@st_name VARCHAR(20),
@cname VARCHAR(20)
)
RETURNS TABLE
AS
RETURN
(
    SELECT @cname AS host_club, C2.name AS guest_club
    FROM HostRequest HR INNER JOIN ClubRepresentative CR ON (HR.asked_by_id = CR.id)
    INNER JOIN CLUB CH ON (CR.club_id = CH.id AND CH.name = @cname)
    INNER JOIN Match M on (HR.match_id=M.id)
    INNER JOIN Club C2 ON (M.guest_club_id = C2.id)
    INNER JOIN StadiumManager SM ON (HR.handled_by_id = SM.id)
    INNER JOIN Stadium S ON (S.id = SM.stadium_id AND @st_name = S.name)
    -- We assumed that milestone requires all requests handled ,unhandled 
)
GO

/* ADDITIONAL MILESTONE 3 CODE */

CREATE PROCEDURE userLogin
@username VARCHAR(20),
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT
AS
BEGIN
    SET @success = 0
    SELECT @success = 1 FROM SystemUser
    WHERE EXISTS (SELECT S1.username FROM SystemUser S1 
                  WHERE S1.password = @password AND S1.username = @username) 

    IF(@success = 1)
        BEGIN
        SET @type = 0

        SELECT @type = 1 FROM SystemAdmin A WHERE A.username = @username
            IF(@type = 1) RETURN

        SELECT @type = 2 FROM SportsAssociationManager S WHERE S.username = @username
            IF(@type = 2) RETURN

        SELECT @type = 3 FROM ClubRepresentative C WHERE C.username = @username
            IF(@type = 3) RETURN

        SELECT @type = 4 FROM StadiumManager S WHERE S.username = @username
            IF(@type = 4) RETURN

        SELECT @type = 5 FROM Fan F WHERE F.username = @username

        END
END
GO

CREATE PROCEDURE showClubInfo
@username VARCHAR(20)
AS
BEGIN
SELECT C.id AS club_id, C.name AS club_name, C.location FROM Club C, ClubRepresentative CR WHERE CR.username= @username AND CR.club_id = C.id
END
GO

CREATE PROCEDURE getClubOfRep
@username VARCHAR(20)
AS
BEGIN
SELECT C.name FROM Club C, ClubRepresentative CR WHERE CR.username = @username AND CR.club_id = C.id
END
GO

CREATE PROCEDURE showClubUpcomingMatches
@cname VARCHAR(20)
AS
BEGIN
    SELECT DISTINCT C1.name AS host_club, C2.name AS guest_club, M.start_time, M.end_time, S.name
    FROM Match M inner join Club C1 on (C1.id = M.host_club_id)
    INNER JOIN Club C2 ON (C2.id = M.guest_club_id)
    left outer join Stadium S ON (M.stadium_id = S.id)
    WHERE (C1.name = @cname OR C2.name = @cname) AND CURRENT_TIMESTAMP < M.start_time
    ORDER BY M.start_time DESC
END 
GO

CREATE PROCEDURE showAvailableStadiumsOn
@datetime DATETIME
AS
BEGIN
SELECT * FROM dbo.viewAvailableStadiumsOn(@datetime)
END
GO

CREATE PROCEDURE showStadiumInfo
@username VARCHAR(20)
AS
BEGIN
SELECT S.id AS stadium_id, S.name AS stadium_name, S.location, S.capacity, S.status 
FROM Stadium S, StadiumManager SM 
WHERE SM.username = @username AND SM.stadium_id = S.id
END
GO

CREATE PROCEDURE getStadiumOfManager
@username VARCHAR(20)
AS
BEGIN
    SELECT S.name FROM Stadium S, StadiumManager SM WHERE SM.username = @username AND SM.stadium_id = S.id
END
GO

CREATE PROCEDURE showHostRequests
@username VARCHAR(20)
AS
BEGIN
    SELECT CR.name AS club_representative, C1.name AS host_club, C2.name AS guest_club, 
           M.start_time, M.end_time, HR.status AS request_status
    FROM HostRequest HR, Match M, ClubRepresentative CR, Club C1, Club C2, StadiumManager SM
    WHERE HR.match_id = M.id AND CR.id = HR.asked_by_id AND C1.id = M.host_club_id AND C2.id = M.guest_club_id 
          AND SM.username=@username AND HR.handled_by_id = SM.id
END
GO

CREATE PROCEDURE showAvailableMatchesToAttend
@datetime DATETIME
AS
BEGIN
    SELECT CH.name AS host_club, C2.name AS guest_club, S.name AS stadium_name, S.location
    FROM Club CH, Club C2, Match M left outer join Stadium S on (M.stadium_id = S.id)
    WHERE M.host_club_id = CH.id AND M.guest_club_id = C2.id 
    AND M.start_time >= @datetime
    AND EXISTS (SELECT T.id FROM Ticket T WHERE T.match_id = M.id AND T.status = 1)
END
GO

CREATE PROCEDURE showAvailableMatchesToAttend2
@datetime DATETIME
AS
BEGIN
    SELECT CH.name AS host_club, C2.name AS guest_club, S.name AS stadium_name, S.location, M.start_time, M.id AS match_id
    FROM Club CH, Club C2, Match M left outer join Stadium S on (M.stadium_id = S.id)
    WHERE M.host_club_id = CH.id AND M.guest_club_id = C2.id 
    AND M.start_time >= @datetime
    AND EXISTS (SELECT T.id FROM Ticket T WHERE T.match_id = M.id AND T.status = 1)
END
GO

CREATE PROCEDURE getNatIDofFan
@username VARCHAR(20)
AS
BEGIN
    SELECT national_id FROM Fan WHERE Fan.username = @username
END
GO

CREATE PROCEDURE checkIfMatchHasAvailableTickets
@chname VARCHAR(20),
@cgname VARCHAR(20),
@datetime DATETIME,
@ticketsExist INT OUTPUT
AS
    DECLARE @t_id INT
    SET @t_id = 0
    SELECT @t_id = T.id 
            FROM Ticket T, Match M, Club CH, Club CG
            WHERE CH.name = @chname AND CG.name = @cgname
            AND M.host_club_id = CH.id AND M.guest_club_id = CG.id
            AND M.start_time = @datetime AND T.status = 1

    IF(@t_id <> 0)
    BEGIN
        SET @ticketsExist = 1
        RETURN
    END
        
    ELSE
    BEGIN
        SET @ticketsExist = 0
        RETURN
    END
GO

CREATE PROCEDURE deleteMatch2
@chname VARCHAR(20),
@cgname VARCHAR(20),
@start_time VARCHAR(20),
@end_time VARCHAR(20)
AS
    DECLARE @x INT
    DECLARE @y INT

    SELECT @x = C1.id FROM Club C1 WHERE C1.name = @chname
    SELECT @y = C2.id FROM Club C2 WHERE C2.name = @cgname

    DELETE FROM Match WHERE host_club_id = @x AND guest_club_id = @y AND start_time = @start_time AND end_time = @end_time
GO

CREATE VIEW clubsNeverScheduled
AS
    SELECT C1.name AS first_club, C2.name AS second_club
    FROM Club C1, Club C2 
    WHERE C1.id > C2.id AND NOT EXISTS 
    (
        SELECT M.id FROM Match M WHERE 
        (M.host_club_id = C1.id AND M.guest_club_id = C2.id)
        OR
        (M.host_club_id = C2.id AND M.guest_club_id = C1.id)
    )
GO
