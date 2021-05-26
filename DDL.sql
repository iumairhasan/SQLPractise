CREATE TABLE PART (Part_Id int, Category_Id int,
Description varchar(50));

-- Declare SQL variables.
DECLARE @Part_Id int; DECLARE @Category_Id int; DECLARE @Desc varchar(50);
-- Initilize SQL variables.
SET @Part_Id = 0; SET @Category_Id = 0;
-- Populate the test table.
WHILE @Part_Id < 10 
BEGIN 
	SET @Part_Id = @Part_Id + 1; 
	WHILE @Category_Id < 3 
	BEGIN 
		SET @Category_Id = @Category_Id + 1; 
		SET @Desc = 'Part_Id is ' + cast(@Part_Id as char(1)) + ' Category_Id ' + cast(@Category_Id as char(1));
		INSERT INTO PART 
			VALUES (@Part_Id, @Category_Id, @Desc ); 
	END; 
	SET @Category_Id = 0; 
END;



-- Retrieve the test data.
SELECT * FROM PART;
-- Drop the test table.
DROP TABLE PART;