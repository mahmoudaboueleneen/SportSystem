---testing

--31 tests  29 done

--compile all procedures , functions,tables  

--initialize
DROP DATABASE dbproj2
CREATE DATABASE dbproj2

EXEC createAllTables

------------------------------------------------

--- reset tables
EXEC dropAllTables
EXEC dropAllProceduresFunctionsViews
EXEC clearAllTables
DROP PROCEDURE createAllTables
--RECOMPILE PROCEDURES
EXEC createAllTables


------------------------------------------------



--START TESTING


--------> i , a


EXEC addAssociationManager 'assosManager1','usernameAhmed','123'
SELECT * FROM  allAssocManagers


--------> vi , 


EXEC addClub 'barca','spain'
EXEC addClub 'real','spain'
EXEC addClub 'liverpool','england'
EXEC addClub 'inter','italy'

SELECT * FROM allClubs


--------> xiii

EXEC addRepresentative 'koman','barca','userBarcaRep1','333'
EXEC addRepresentative 'Ahmed','real','userRealRep2','333'
EXEC addRepresentative 'Mohmoud','liverpool','userLiverRep3','333'
EXEC addRepresentative 'Tarek', 'inter','userInterRep4','333'
EXEC addRepresentative 'Tarekokodsm','inter','userInterRep4','333'
SELECT * FROM allClubRepresentatives
--------> ix 

EXEC addStadium 'santiago','spain',200
EXEC addStadium 'losail','qatar',300
EXEC addStadium 'anfield','england',200

SELECT * FROM allStadiums
----------> xvii

EXEC addStadiumManager 'Stadmanger1Hossam','santiago','userSantiagoManger','1223'
EXEC addStadiumManager 'Stadmanger1Amr','losail','userLosailManger','1223'
EXEC addStadiumManager 'Stadmanger1Youssef','anfield','userAnfieldManger','1223'

SELECT * FROM allStadiumManagers



----------> ii

EXEC addNewMatch 'liverpool','barca','2051/12/17 13:00:00','2051/12/17 15:00:00'
EXEC addNewMatch 'liverpool','inter','2011/12/20 13:00:00','2011/12/20 15:00:00'
EXEC addNewMatch 'liverpool','inter','2023/12/20 13:00:00','2023/12/20 15:00:00'
EXEC addNewMatch 'liverpool','inter','2023/11/20 13:00:00','2023/11/20 15:00:00'
EXEC addNewMatch 'liverpool','real','2020/11/20 13:00:00','2020/11/20 15:00:00'
EXEC addNewMatch 'liverpool','inter','2024/11/20 13:00:00','2024/11/20 15:00:00'
EXEC addNewMatch 'liverpool','real','2025/11/20 13:00:00','2025/11/20 15:00:00'

SELECT * FROM allMatches



---------->iii

SELECT * FROM clubsWithNoMatches


---------->xv 
EXEC addHostRequest 'liverpool','anfield','2011/12/17 13:00:00'
EXEC addHostRequest 'liverpool','losail','2020/11/20 13:00:00'
EXEC addHostRequest 'liverpool','anfield','2023/12/20 13:00:00'
EXEC addHostRequest 'liverpool','anfield','2023/11/20 13:00:00'
EXEC addHostRequest 'liverpool','anfield','2024/11/20 13:00:00'
EXEC addHostRequest 'liverpool','anfield','2025/11/20 13:00:00'


SELECT * FROM allRequests

---------> xix Not working logic , NEED TO PREVENT DUPLICATES

EXEC acceptRequest 'userAnfieldManger','liverpool','barca','2011-12-17 13:00:00'
EXEC acceptRequest 'userLosailManger','liverpool','real','2020/11/20 13:00:00'
EXEC acceptRequest 'userAnfieldManger','liverpool','inter','2023/12/20 13:00:00'
EXEC acceptRequest 'userAnfieldManger','liverpool','inter','2023/11/20 13:00:00'
EXEC acceptRequest 'userAnfieldManger','liverpool','real','2025/11/20 13:00:00'

SELECT * FROM allMatches
SELECT * FROM allRequests
SELECT * FROM Ticket
SELECT * FROM Match

---------->vii need for coonstarints

EXEC addTicket 'liverpool','real','2025/11/20 13:00:00'
EXEC addTicket 'liverpool','inter','2024/11/20 13:00:00'

SELECT * FROM allTickets
SELECT * FROM Ticket


---------->iv

EXEC deleteMatch 'liverpool','barca'

SELECT * FROM allMatches

SELECT * FROM allRequests
---------->viii

EXEC deleteClub 'barca'
SELECT * FROM allClubs
SELECT * FROM allMatches
SELECT * FROM allClubRepresentatives


---------->x 

EXEC deleteStadium 'santiago'
SELECT * FROM allStadiums
SELECT * FROM allStadiumManagers


----------->xvi

SELECT * FROM dbo.allUnassignedMatches('liverpool')

----------->xxii not working NOT WORKING IN CASE OF NULL STADIUMS

SELECT * FROM dbo.upcomingMatchesOfClub('liverpool')
SELECT * FROM allMatches


-----------> xxiii NOT WORKING IN CASE OF NULL STADIUMS

SELECT * FROM dbo.availableMatchesToAttend('2012')
SELECT * FROM Ticket
SELECT * FROM TicketBuyingTransaction

---------->xxv 

EXEC updateMatchHost 'liverpool','inter','2011/12/20 13:00:00'

SELECT * FROM allMatches

---------->xxvi wrong if club has zero matches

SELECT * FROM matchesPerTeam


---------->xxvii

SELECT * FROM clubsNeverMatched


---------->xxviii

SELECT * FROM dbo.clubsNeverPlayed('liverpool')




-------->xviii not wroking logic

SELECT * FROM dbo.allPendingRequests('userLosailManger')


-------->xx
EXEC rejectRequest 'userLosailManger','liverpool','inter','2011/12/20 13:00:00'

SELECT * FROM allRequests


--------->xxi

EXEC addFan 'naser','userfan','123','994949494','1998-12-20','first Settlment',0129584733
EXEC addFan 'fares','userfan2','fd123','114949494','1998-12-20','first Settlment',0129544763
EXEC addFan 'mazen','userfan2','fd123','1144','1998-12-20','first Settlment',0129544763
EXEC addFan 'dina','userfan2','fd123','1932324','1998-12-20','first Settlment',0129544763
EXEC addFan 'morad','userfan2','fd123','100203','1998-12-20','first Settlment',0129544763
SELECT * FROM allFans
--------->xxiv wrong need to check if the fan is blocked

EXEC purchaseTicket '114949494','liverpool','real','2020/11/20 13:00:00'
SELECT * FROM TicketBuyingTransaction
SELECT * FROM Ticket

--------->xi

EXEC blockFan '994949494'
SELECT * FROM allFans

----------> xii

EXEC unblockFan '994949494'
SELECT * FROM allFans

---------->xiv 

SELECT * FROM Match
SELECT * FROM dbo.viewAvailableStadiumsOn('2023-1-1 14:00:00.000')

---------->xxix wrong use transactions in code 
SELECT * FROM dbo.matchWithHighestAttendance()
SELECT * FROM TicketBuyingTransaction


---------->xxxi
SELECT * FROM dbo.requestsFromClub('losail','liverpool')


---------->xxx
SELECT * FROM dbo.matchesRankedByAttendance()


---------->v

EXEC deleteMatchesOnStadium 'anfield'

INSERT INTO SystemUser VALUES ('adminuser','123')
INSERT INTO SystemAdmin VALUES ('Ahmed','adminuser')

SELECT * FROM Club
SELECT * FROM allClubs
SELECT * FROM Stadium
SELECT * FROM SystemUser
SELECT * FROM SystemAdmin
SELECT * FROM Match
SELECT * FROM allMatches
SELECT * FROM HostRequest
SELECT * FROM Ticket
SELECT * FROM Fan
SELECT * FROM ClubRepresentative
SELECT * FROM SportsAssociationManager
SELECT * FROM StadiumManager
SELECT * FROM dbo.availableMatchesToAttend(CURRENT_TIMESTAMP)