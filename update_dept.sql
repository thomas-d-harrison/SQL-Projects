BEGIN TRANSACTION;

DECLARE @BatchSize INT = 1000; -- Adjust the batch size as needed
DECLARE @RowsAffected INT = @BatchSize;

WHILE @RowsAffected = @BatchSize
BEGIN
    UPDATE TOP (@BatchSize) Employees
    SET Department = '002'
    WHERE Department = '001';

    SET @RowsAffected = @@ROWCOUNT;

    -- To prevent the script from running indefinitely
    IF @RowsAffected = 0
        BREAK;
END;

-- Commit or Rollback the transaction
-- COMMIT TRANSACTION;
-- ROLLBACK TRANSACTION;

-- Remember to commit or rollback based on the outcome

-- Uncomment either COMMIT or ROLLBACK based on the success of the operation
-- COMMIT TRANSACTION;
ROLLBACK TRANSACTION; -- Uncomment and execute this if you encounter any issues

-- Remember to monitor the server and check the results before committing the transaction
