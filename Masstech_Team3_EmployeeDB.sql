use Masstech_Team3;



                                            -------  Users  -------


--CREATE TABLE Users
--(
--   UserId INT IDENTITY(1,1) PRIMARY KEY,

--    FirstName NVARCHAR(100) NOT NULL,
--    LastName NVARCHAR(100) NOT NULL,
--    Email NVARCHAR(255) NOT NULL UNIQUE,
--    PasswordHash NVARCHAR(255) NOT NULL,
--    PhoneNumber NVARCHAR(20) NULL,
--    Status BIT NOT NULL DEFAULT 1,  -- 1 = Active, 0 = Inactive
--   CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
--    UpdatedAt DATETIME2 NULL
--);

-- drop table users;




CREATE TABLE Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    RoleName NVARCHAR(50) NOT NULL   -- e.g., Admin, Manager, Employee
);






ALTER TABLE Users
ADD 
    Designation NVARCHAR(100) NULL,
    ReportingManagerId INT NULL,
    DOJ DATE NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Active',
    CreatedBy INT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifyBy INT NULL,
    ModifyDate DATETIME NULL,
    Action NVARCHAR(50) NULL;


ALTER TABLE Users
ADD PhotoUrl NVARCHAR(500) NULL;

ALTER TABLE Users
ADD ModifiedBy VARCHAR(100) NULL;

ALTER TABLE Users
DROP COLUMN ReportingManagerId;

ALTER TABLE Users
DROP COLUMN ModifyBy;


ALTER TABLE Users
ADD ReportingManager NVARCHAR(150) NULL;




ALTER PROCEDURE sp_GetAllUsers
AS
BEGIN
    SELECT 
        UserId,
        Name,
        Email,
        PhoneNumber,
        Designation,
        ReportingManager,
        DOJ,
        Status,
        CreatedBy,
        Action
    FROM Users
END



drop procedure sp_GetAllUsers;

CREATE PROCEDURE sp_GetAllUsers
AS
BEGIN
    SELECT 
        UserId,
        Name,
        Email,
        PhoneNumber,
        Designation,
        ReportingManager,
        DOJ,
        Status,
        CreatedBy,
        Action,
        PhotoUrl,
        ModifiedBy
    FROM Users
END







CREATE PROCEDURE sp_GetEmployeeSummary
AS
BEGIN
    SELECT 
        COUNT(*) AS TotalEmployee,
        SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS ActiveEmployee,
        SUM(CASE WHEN Status = 'Inactive' THEN 1 ELSE 0 END) AS InactiveEmployee,
        SUM(CASE 
                WHEN DATEDIFF(DAY, DOJ, GETDATE()) <= 30 
                THEN 1 ELSE 0 
            END) AS NewJoiner
    FROM Users
END





INSERT INTO Users (Name, Email, PasswordHash, PhoneNumber, RoleName)
VALUES
('Alice Admin', 'admin@gmail.com', 'Admin@123', '9999999999', 'Admin'),
('Bob Manager', 'manager@gmail.com', 'Manager@123', '8888888888', 'Manager'),
('Charlie Employee', 'employee@gmail.com', 'Employee@123', '7777777777', 'Employee');



select * from Users;



--  Procedure for Login Page

CREATE PROCEDURE sp_logindetails
    @Email NVARCHAR(255),
    @Password NVARCHAR(255)
AS
BEGIN

   
    SELECT Name, Email, PasswordHash, PhoneNumber, RoleName
    FROM Users
    WHERE Email = @Email
      AND PasswordHash = @Password;
END;





EXEC sp_logindetails 'admin@gmail.com', 'Admin@123';




--  Procedure for Employee List

CREATE PROCEDURE sp_GetAllUsers
AS
BEGIN
    SELECT 
        Name,
        Email,
        PhoneNumber,
        Designation,
        ReportingManager,
        DOJ,
        Status,
        CreatedBy,
        Action
    FROM Users
END





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



EXEC sp_rename 'Role.ModifyBy', 'ModifiedBy', 'COLUMN';

TRUNCATE TABLE Role;


INSERT INTO Role (RoleName, Status, CreatedBy, ModifiedBy)
VALUES 
('Admin', 'Active', 'Admin', 'Admin'),
('Manager', 'Active', 'Admin', 'Admin'),
('Employee', 'Active', 'Admin', 'Admin');





INSERT INTO Role (RoleName, Status, CreatedBy, ModifiedBy)
VALUES 
('Team Lead', 'Active', 'Admin', 'Admin'),
('Developer', 'Active', 'Admin', 'Admin'),
('Tester', 'Active', 'Admin', 'Admin'),
('HR', 'Active', 'Admin', 'Admin'),
('Accountant', 'Active', 'Admin', 'Admin'),
('Support', 'Active', 'Admin', 'Admin'),
('Guest', 'Inactive', 'Admin', 'Admin');



UPDATE Role
SET Status = 'Inactive'
WHERE RoleName IN ('Tester', 'Support', 'Accountant');



UPDATE Role
SET Status = 'Inactive'
WHERE RoleID = 3;

select * from role;




--  Fetch All Roles (for GridView)


CREATE PROCEDURE sp_GetAllRoles
AS
BEGIN
    SELECT RoleID, RoleName, Status, CreatedBy, ModifiedBy
    FROM Role
    ORDER BY RoleName;
END



ALTER PROCEDURE sp_GetAllRoles
AS
BEGIN
    -- We use 'AS ModifiedBy' to match your ASPX DataField
    SELECT RoleId, RoleName, Status, CreatedBy, ModifiedBy 
    FROM Role;
END




--  Fetch Role by ID

CREATE PROCEDURE sp_GetRoleByID
    @RoleID INT
AS
BEGIN
    SELECT RoleID, RoleName, Status, CreatedBy, ModifiedBy
    FROM Role
    WHERE RoleID = @RoleID;
END




--  Insert Role


CREATE PROCEDURE sp_InsertRole
    @RoleName VARCHAR(100),
    @Status BIT,
    @CreatedBy VARCHAR(50),
    @ModifiedBy VARCHAR(50)
AS
BEGIN
    INSERT INTO Role (RoleName, Status, CreatedBy, ModifiedBy)
    VALUES (@RoleName, @Status, @CreatedBy, @ModifiedBy);
END



--  Update Role

CREATE PROCEDURE sp_UpdateRole
    @RoleID INT,
    @RoleName VARCHAR(100),
    @Status BIT,
    @ModifiedBy VARCHAR(50)
AS
BEGIN
    UPDATE Role
    SET RoleName = @RoleName,
        Status = @Status,
        ModifiedBy = @ModifiedBy
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