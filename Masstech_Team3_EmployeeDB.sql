use Masstech_Team3;



                                            -------  Users  -------


CREATE TABLE Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,

    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    Status BIT NOT NULL DEFAULT 1,  -- 1 = Active, 0 = Inactive
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    UpdatedAt DATETIME2 NULL
);


select * from Users;



                                    --------  Employee ------


CREATE TABLE Employee
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);


select * from Employee;




                                   --------  Department ------

CREATE TABLE Department
(
    DepartmentId INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(50) NOT NULL,
    NoOfEmp INT NOT NULL,
    Active VARCHAR(50) NULL,
    CreatedBy VARCHAR(50) NOT NULL,
    ModifiedBy VARCHAR(50) NULL,
    CreatedDate DATETIME NULL,
    ModifiedDate DATETIME NULL
);

EXEC sp_rename 'Department.Active', 'Status', 'COLUMN';



select * from Department;






INSERT INTO Department(DepartmentName,NoOfEmp,Active,CreatedBy,CreatedDate)
VALUES
('Human Resources', 5, 'Yes', 'Admin', GETDATE()),
('Information Technology', 12, 'Yes', 'Admin', GETDATE()),
('Finance', 4, 'Yes', 'Admin', GETDATE()),
('Operations', 8, 'Yes', 'Admin', GETDATE());


delete from Department
where DepartmentId = 5;


UPDATE Department
SET Status = 'Active'
WHERE Status = 'Yes';

UPDATE Department
SET Status = 'Inactive'
WHERE Status = 'No';




CREATE PROCEDURE sp_GetAllDepartment
AS
BEGIN
    SELECT 
        DepartmentId,
        DepartmentName,
        NoOfEmp,
        Status,
        CreatedBy,
        ModifiedBy,
        CreatedDate,
        ModifiedDate
    FROM Department
    ORDER BY DepartmentId DESC
END









CREATE PROCEDURE sp_InsertDepartment
    @DepartmentName NVARCHAR(100),
    @NoOfEmp INT,
    @Status VARCHAR(100),
    @CreatedBy NVARCHAR(100)
AS
BEGIN
    INSERT INTO Department
    (
        DepartmentName,
        NoOfEmp,
        Status,
        CreatedBy,
        CreatedDate
    )
    VALUES
    (
        @DepartmentName,
        @NoOfEmp,
        @Status,
        @CreatedBy,
        GETDATE()
    )
END





CREATE PROCEDURE sp_DeleteDepartment
    @DepartmentId INT
AS
BEGIN
    DELETE FROM Department
    WHERE DepartmentId = @DepartmentId
END






                                    --------  Role ------


CREATE TABLE Role (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(100) NOT NULL,
    Status VARCHAR(10),
    CreatedBy VARCHAR(50),
    ModifyBy VARCHAR(50)
);






INSERT INTO Role (RoleName, Status, CreatedBy, ModifyBy)
VALUES 
('Administrator', 'Active', 'System', 'System'),
('Manager', 'Active', 'System', 'System'),
('Team Lead', 'Active', 'System', 'System'),
('Developer', 'Active', 'System', 'System'),
('Tester', 'Active', 'System', 'System'),
('HR', 'Active', 'System', 'System'),
('Guest', 'Inactive', 'System', 'System');



select * from role;





--  Fetch All Roles (for GridView)


CREATE PROCEDURE sp_GetAllRoles
AS
BEGIN
    SELECT RoleID, RoleName, Status, CreatedBy, ModifyBy
    FROM Role
    ORDER BY RoleName;
END



--  Fetch Role by ID

CREATE PROCEDURE sp_GetRoleByID
    @RoleID INT
AS
BEGIN
    SELECT RoleID, RoleName, Status, CreatedBy, ModifyBy
    FROM Role
    WHERE RoleID = @RoleID;
END




--  Insert Role


CREATE PROCEDURE sp_InsertRole
    @RoleName VARCHAR(100),
    @Status BIT,
    @CreatedBy VARCHAR(50)
AS
BEGIN
    INSERT INTO Role (RoleName, Status, CreatedBy)
    VALUES (@RoleName, @Status, @CreatedBy);
END



--  Update Role

CREATE PROCEDURE sp_UpdateRole
    @RoleID INT,
    @RoleName VARCHAR(100),
    @Status BIT,
    @ModifyBy VARCHAR(50)
AS
BEGIN
    UPDATE Role
    SET RoleName = @RoleName,
        Status = @Status,
        ModifyBy = @ModifyBy
    WHERE RoleID = @RoleID;
END





--  Delete Role

CREATE PROCEDURE sp_DeleteRole
    @RoleID INT
AS
BEGIN
    DELETE FROM Role
    WHERE RoleID = @RoleID;
END