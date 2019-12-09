const name = "Arthur Fourfooz"
const promo = "B2A"

const q1 = `Select Name
from Track
where Milliseconds < (select Milliseconds
					  from Track
					  where TrackId like '3457')
`

const q2 = `Select Name
from Track
where MediaTypeId = (select MediaTypeId
					from Track
					where Name like 'Rehab')`
const q3 = `select p.PlaylistId, p.Name, COUNT(t.TrackId) as "Nombre de musique" , SUM(t.Milliseconds) as "temps total", AVG(t.Milliseconds) as "temps moyen"
from Playlist as p
	join PlaylistTrack as pt
	on p.PlaylistId=pt.PlaylistId
	join Track as t
	on pt.TrackId=t.TrackId
group by p.PlaylistId, p.Name
order by p.PlaylistId;`
const q4 = `SELECT P1.PlaylistId AS 'ID', P1.Name AS 'Playlist', SUM(T1.Milliseconds) AS 'Durée'
FROM Playlist P1
JOIN PlaylistTrack PT1
ON P1.PlaylistId = PT1.PlaylistId
JOIN Track T1
ON PT1.TrackId = T1.TrackId
WHERE (
    SELECT SUM(T2.Milliseconds) AS 'Durée'
    FROM Playlist P2
    JOIN PlaylistTrack PT2
    ON P2.PlaylistId = PT2.PlaylistId
    JOIN Track T2
    ON PT2.TrackId = T2.TrackId
    WHERE P1.PlaylistId = P2.PlaylistId
    ) > (
            SELECT AVG((d.totalPlaylistDuration) / (nb.numberMusic)) AS 'Durée moyenne'
            FROM Playlist P3
            JOIN (
                SELECT P4.PlaylistId, SUM(T3.Milliseconds) AS totalPlaylistDuration
                FROM Playlist P4
                JOIN PlaylistTrack PT3
                ON P4.PlaylistId = PT3.PlaylistId
                JOIN Track T3
                ON PT3.TrackId = T3.TrackId
                GROUP BY P4.PlaylistId
            ) d ON P3.PlaylistId = d.PlaylistId
            JOIN (
                SELECT PT4.PlaylistId, COUNT(T4.TrackId) AS numberMusic
                FROM track T4
                JOIN PlaylistTrack PT4
                ON PT4.TrackId = T4.TrackId
                GROUP BY PT4.PlaylistId
            ) nb ON P3.PlaylistId = nb.PlaylistId
        )
GROUP BY P1.PlaylistId, P1.Name`
const q5 = `select p.PlaylistId, p.Name
from Playlist as p
	join PlaylistTrack as pt
	on p.PlaylistId=pt.PlaylistId
	join Track as t
	on pt.TrackId=t.TrackId
group by p.PlaylistId, p.Name
having COUNT(t.TrackId) = (select COUNT(t.TrackId)
							from Playlist as p
								join PlaylistTrack as pt
								on p.PlaylistId=pt.PlaylistId
								join Track as t
								on pt.TrackId=t.TrackId
							where p.PlaylistId =1)
		or COUNT(t.TrackId) = (select COUNT(t.TrackId)
								from Playlist as p
									join PlaylistTrack as pt
									on p.PlaylistId=pt.PlaylistId
									join Track as t
									on pt.TrackId=t.TrackId
								where p.PlaylistId =13)
order by p.PlaylistId;`
const q6 = `select cu.FirstName, cu.LastName,i.Total
from Customer as cu 
	join Invoice as i
	on cu.customerId = i.customerId
group by cu.FirstName, cu.LastName,i.Total
having i.Total> (select MAX(i.total)
					  from Customer as cu 
						join Invoice as i
						on cu.customerId = i.customerId
					  where Country like 'France')
order by LastName;`
const q7 = `select BillingCountry, MAX(Total) as "Max", MIN(Total) as "Min", AVG(Total) as "Moyen", COUNT(BillingCountry) as "Total de commandes"
from Invoice
group by BillingCountry`
const q8 = `select*, AVG(UnitPrice)
from Track as t
	join MediaType as m
	on t.MediaTypeId = m.MediaTypeId
where UnitPrice>(select AVG(UnitPrice)
				 from Track)
group by TrackId,t.Name,AlbumId,t.MediaTypeId,GenreId,Composer,Milliseconds,Bytes,UnitPrice,m.MediaTypeId,m.Name`
const q9 = ``
const q10 = ``
const q11 = ``
const q12 = ``
const q13 = ``
const q14 = ``
const q15 = ``
const q16 = ``
const q17 = ``
const q18 = `IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ianCorporation')
	DROP DATABASE [ianCorporation]
GO
CREATE DATABASE [ianCorporation]
GO
USE [ianCorporation]
GO

CREATE TABLE [dbo].[User]
(
    [id] INT PRIMARY KEY IDENTITY,
    [username] VARCHAR(255) CONSTRAINT User_username_NN NOT NULL,
    [email] VARCHAR(255),
    [superuser] BIT CONSTRAINT User_superuser_NN NOT NULL DEFAULT(0)
);
GO

CREATE TABLE [dbo].[User_Group]
(
    [user_id] INT CONSTRAINT User_id_FK REFERENCES [User],
    [group_id] INT CONSTRAINT Group_id_FK REFERENCES [Group]
);
GO

CREATE TABLE [dbo].[User_Role]
(
    [user_id] INT CONSTRAINT User_id_FK REFERENCES [User],
    [role_id] INT CONSTRAINT Role_id_FK REFERENCES [Role]
);
GO

CREATE TABLE [dbo].[Group]
(
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(255) CONSTRAINT Group_name_NN NOT NULL,
    display_name VARCHAR(255),
    description TEXT
);
GO

CREATE TABLE [dbo].[Group_Role]
(
    [group_id] INT CONSTRAINT Group_id_FK REFERENCES [Group],
    [role_id] INT CONSTRAINT Role_id_FK REFERENCES [Role]
);
GO

CREATE TABLE [dbo].[Role]
(
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(255) CONSTRAINT Role_name_NN NOT NULL,
    display_name VARCHAR(255),
    description TEXT CONSTRAINT Role_description_NN NOT NULL,
);
GO

CREATE TABLE [dbo].[Role_Permission]
(
    [role_id] INT CONSTRAINT Role_id_FK REFERENCES [Role],
    [permission_id] INT CONSTRAINT Permission_id_FK REFERENCES [Permission]
);
GO

CREATE TABLE [dbo].[Permission]
(
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(255) CONSTRAINT Permission_name_NN NOT NULL,
    display_name VARCHAR(255),
    description TEXT CONSTRAINT Permission_name_NN NOT NULL,
);
GO`
const q19 = `INSERT INTO Track (Name, MediaTypeId, GenreId, Composer, Milliseconds, UnitPrice)
VALUES
('Long Cool Woman in a Black Dress', 1, 1, 'Allan Clarke', 195000, 0.99),
('Jeopardy', 1, 9, 'Greg Kihn', 227000, 0.99),
('Sweet Dreams (Are Made of This)', 1, 9, 'Annie Lennox', 295000,0.99);`
const q20 = `INSERT INTO Employee (LastName, FirstName, Country)
VALUES
('Fourfooz', 'Arthur', 'France'),
('Le coz', 'Yann', 'France');`
const q21 = `DELETE FROM Invoice WHERE InvoiceDate = 2010;`
const q22 = `UPDATE Invoice
SET CustomerId = (
    SELECT c.CustomerId, i.InvoiceId
    FROM Customer c
    JOIN Invoice i
    ON c.CustomerId = i.CustomerId
    WHERE c.Country = 'France'
    GROUP BY c.CustomerId, i.InvoiceId
    HAVING i.InvoiceId = MAX(i.InvoiceId)
)
WHERE BillingCountry = 'Germany' AND InvoiceDate BETWEEN '2011-01-02 00:00:00.000' AND '2014-01-01 00:00:00.000';`
const q23 = `UPDATE Invoice
SET Invoice.BillingCountry = Customer.Country
FROM Invoice
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
WHERE Invoice.BillingCountry != Customer.Country;`
const q24 = `ALTER TABLE Employee
ADD Salary INT`
const q25 = `UPDATE Employee
SET Salary = RAND() * (30000)+10000`
const q26 = `ALTER TABLE dbo.Invoice
DROP COLUMN BillingPostalCode;

SELECT *
FROM Invoice`











































// NE PAS TOUCHER CETTE SECTION
const tp = {name: name, promo: promo, queries: [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26]}
module.exports = tp

