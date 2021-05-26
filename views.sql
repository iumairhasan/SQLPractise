
/*
Create a view to include the encryption and
schemabinding options. Encryption protects the
view query definition. Schemabinding means the
definition of the database object(s) on which
the view is defined can not be changed without
first dropping the view.
*/
CREATE VIEW vwEmployeeContactInfo1 
WITH ENCRYPTION, SCHEMABINDING 
AS 
SELECT e.[BusinessEntityID] as [ContactID], FirstName,
MiddleName, LastName, JobTitle
FROM Person.Person c
INNER JOIN HumanResources.Employee e
ON c.BusinessEntityID = e.BusinessEntityID;


select *
from vwEmployeeContactInfo1
exec sp_helptext vwEmployeeContactInfo1;

drop view vwEmployeeContactInfo1;


CREATE VIEW vwEmployeeContactInfo124
AS
SELECT e.[BusinessEntityID] as [ContactID], FirstName,
MiddleName, LastName, JobTitle
FROM Person.Person c
INNER JOIN HumanResources.Employee e
ON c.BusinessEntityID = e.BusinessEntityID;

-- Select from the view
SELECT * FROM vwEmployeeContactInfo124;
-- See the script that generated the view
EXEC sp_helptext vwEmployeeContactInfo124;

DROP VIEW vwEmployeeContactInfo124;

/*
Alter the view to remove schemabinding – must
restate everything, including changes.
*/
ALTER VIEW vwEmployeeContactInfo124 
WITH ENCRYPTION 
AS 
SELECT e.[BusinessEntityID] as [ContactID], FirstName,
MiddleName, LastName, JobTitle
FROM Person.Person c
INNER JOIN HumanResources.Employee e
ON c.BusinessEntityID = e.BusinessEntityID;