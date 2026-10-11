CREATE TABLE Users (
    UserId        INT IDENTITY(1,1) PRIMARY KEY,
    FullName      NVARCHAR(100) NOT NULL,
    Email         NVARCHAR(150) NOT NULL UNIQUE,
    EnrollmentNo  NVARCHAR(30)  NULL,
    Phone         NVARCHAR(20)  NULL,
    PasswordHash  NVARCHAR(200) NOT NULL,
    PasswordSalt  NVARCHAR(100) NOT NULL,
    Role          NVARCHAR(20)  NOT NULL DEFAULT 'Student',
    IsActive      BIT           NOT NULL DEFAULT 1,
    CreatedAt     DATETIME2     NOT NULL DEFAULT SYSDATETIME()
);

CREATE UNIQUE INDEX UX_Users_EnrollmentNo
    ON Users(EnrollmentNo) WHERE EnrollmentNo IS NOT NULL;

CREATE TABLE Students (
    StudentId   INT IDENTITY(1,1) PRIMARY KEY,
    UserId      INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Users(UserId),
    Course      NVARCHAR(50)  NULL,
    Department  NVARCHAR(100) NULL,
    Block       NVARCHAR(30)  NULL,
    RoomNumber  NVARCHAR(20)  NULL,
    Status      NVARCHAR(20)  NOT NULL DEFAULT 'Active'
);

CREATE TABLE ContactMessages (
    MessageId   INT IDENTITY(1,1) PRIMARY KEY,
    FullName    NVARCHAR(100) NOT NULL,
    Email       NVARCHAR(150) NOT NULL,
    Subject     NVARCHAR(200) NOT NULL,
    Message     NVARCHAR(MAX) NOT NULL,
    CreatedAt   DATETIME2     NOT NULL DEFAULT SYSDATETIME()
);