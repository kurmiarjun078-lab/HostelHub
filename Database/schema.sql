/* ============================================================
   HostelHub - Complete schema (safe to run multiple times)
   ============================================================ */

/* ---------- USERS ---------- */
IF OBJECT_ID('dbo.Users', 'U') IS NULL
CREATE TABLE dbo.Users (
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
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_Users_EnrollmentNo' AND object_id = OBJECT_ID('dbo.Users'))
CREATE UNIQUE INDEX UX_Users_EnrollmentNo ON dbo.Users(EnrollmentNo) WHERE EnrollmentNo IS NOT NULL;
GO

/* ---------- STUDENTS ---------- */
IF OBJECT_ID('dbo.Students', 'U') IS NULL
CREATE TABLE dbo.Students (
    StudentId   INT IDENTITY(1,1) PRIMARY KEY,
    UserId      INT NOT NULL UNIQUE FOREIGN KEY REFERENCES dbo.Users(UserId),
    Course      NVARCHAR(50)  NULL,
    Department  NVARCHAR(100) NULL,
    Block       NVARCHAR(30)  NULL,
    RoomNumber  NVARCHAR(20)  NULL,
    Status      NVARCHAR(20)  NOT NULL DEFAULT 'Active'
);
GO

/* ---------- ROOMS ---------- */
IF OBJECT_ID('dbo.Rooms', 'U') IS NULL
CREATE TABLE dbo.Rooms (
    RoomId            INT IDENTITY(1,1) PRIMARY KEY,
    Block             NVARCHAR(30) NOT NULL,
    RoomNumber        NVARCHAR(20) NOT NULL,
    [Floor]           INT          NOT NULL DEFAULT 1,
    Wing              NVARCHAR(30) NULL,
    Capacity          INT          NOT NULL DEFAULT 4,
    UnderMaintenance  BIT          NOT NULL DEFAULT 0,
    CONSTRAINT UQ_Rooms UNIQUE (Block, RoomNumber),
    CONSTRAINT CK_Rooms_Capacity CHECK (Capacity BETWEEN 1 AND 10)
);
GO

IF COL_LENGTH('dbo.Rooms', 'Wing') IS NULL
    ALTER TABLE dbo.Rooms ADD Wing NVARCHAR(30) NULL;
IF COL_LENGTH('dbo.Rooms', 'UnderMaintenance') IS NULL
    ALTER TABLE dbo.Rooms ADD UnderMaintenance BIT NOT NULL DEFAULT 0;
GO

/* ---------- STUDENTS: extra columns (profile + room link) ---------- */
IF COL_LENGTH('dbo.Students', 'DateOfBirth') IS NULL
    ALTER TABLE dbo.Students ADD DateOfBirth DATE NULL;
IF COL_LENGTH('dbo.Students', 'Gender') IS NULL
    ALTER TABLE dbo.Students ADD Gender NVARCHAR(10) NULL;
IF COL_LENGTH('dbo.Students', 'Semester') IS NULL
    ALTER TABLE dbo.Students ADD Semester TINYINT NULL;
IF COL_LENGTH('dbo.Students', 'GuardianName') IS NULL
    ALTER TABLE dbo.Students ADD GuardianName NVARCHAR(100) NULL;
IF COL_LENGTH('dbo.Students', 'GuardianRelation') IS NULL
    ALTER TABLE dbo.Students ADD GuardianRelation NVARCHAR(30) NULL;
IF COL_LENGTH('dbo.Students', 'GuardianPhone') IS NULL
    ALTER TABLE dbo.Students ADD GuardianPhone NVARCHAR(20) NULL;
IF COL_LENGTH('dbo.Students', 'BedNumber') IS NULL
    ALTER TABLE dbo.Students ADD BedNumber TINYINT NULL;
IF COL_LENGTH('dbo.Students', 'RoomId') IS NULL
    ALTER TABLE dbo.Students ADD RoomId INT NULL
        CONSTRAINT FK_Students_Rooms FOREIGN KEY REFERENCES dbo.Rooms(RoomId);
GO

-- Ek room mein ek bed number sirf ek student ko
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_Students_Bed' AND object_id = OBJECT_ID('dbo.Students'))
CREATE UNIQUE INDEX UX_Students_Bed ON dbo.Students(RoomId, BedNumber)
    WHERE RoomId IS NOT NULL AND BedNumber IS NOT NULL;
GO

/* ---------- COMPLAINTS ---------- */
IF OBJECT_ID('dbo.Complaints', 'U') IS NULL
CREATE TABLE dbo.Complaints (
    ComplaintId   INT IDENTITY(1,1) PRIMARY KEY,
    StudentId     INT NOT NULL
        CONSTRAINT FK_Complaints_Students FOREIGN KEY REFERENCES dbo.Students(StudentId),
    Category      NVARCHAR(30)   NOT NULL,
    Subject       NVARCHAR(150)  NOT NULL,
    Description   NVARCHAR(1000) NULL,
    Status        NVARCHAR(20)   NOT NULL DEFAULT 'Pending',
    AdminRemarks  NVARCHAR(500)  NULL,
    CreatedAt     DATETIME2      NOT NULL DEFAULT SYSDATETIME(),
    UpdatedAt     DATETIME2      NULL,
    ResolvedAt    DATETIME2      NULL,
    CONSTRAINT CK_Complaints_Status CHECK (Status IN ('Pending', 'In Progress', 'Resolved'))
);
GO

IF COL_LENGTH('dbo.Complaints', 'AdminRemarks') IS NULL
    ALTER TABLE dbo.Complaints ADD AdminRemarks NVARCHAR(500) NULL;
IF COL_LENGTH('dbo.Complaints', 'UpdatedAt') IS NULL
    ALTER TABLE dbo.Complaints ADD UpdatedAt DATETIME2 NULL;
IF COL_LENGTH('dbo.Complaints', 'ResolvedAt') IS NULL
    ALTER TABLE dbo.Complaints ADD ResolvedAt DATETIME2 NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Complaints_Student' AND object_id = OBJECT_ID('dbo.Complaints'))
CREATE INDEX IX_Complaints_Student ON dbo.Complaints(StudentId);
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Complaints_Status' AND object_id = OBJECT_ID('dbo.Complaints'))
CREATE INDEX IX_Complaints_Status ON dbo.Complaints(Status);
GO

/* ---------- MESS MENU ---------- */
IF OBJECT_ID('dbo.MessMenu', 'U') IS NULL
CREATE TABLE dbo.MessMenu (
    MenuId     INT IDENTITY(1,1) PRIMARY KEY,
    DayName    NVARCHAR(15)  NOT NULL UNIQUE,
    Breakfast  NVARCHAR(500) NOT NULL,
    Lunch      NVARCHAR(500) NOT NULL,
    Dinner     NVARCHAR(500) NOT NULL
);
GO

/* ---------- MESS FEEDBACK ---------- */
IF OBJECT_ID('dbo.MessFeedback', 'U') IS NULL
CREATE TABLE dbo.MessFeedback (
    FeedbackId  INT IDENTITY(1,1) PRIMARY KEY,
    StudentId   INT NOT NULL
        CONSTRAINT FK_MessFeedback_Students FOREIGN KEY REFERENCES dbo.Students(StudentId),
    Taste       TINYINT NOT NULL,
    Quality     TINYINT NOT NULL,
    Hygiene     TINYINT NOT NULL,
    Comment     NVARCHAR(500) NULL,
    CreatedAt   DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT CK_MessFeedback_Rating CHECK
        (Taste BETWEEN 1 AND 5 AND Quality BETWEEN 1 AND 5 AND Hygiene BETWEEN 1 AND 5)
);
GO

/* ---------- NOTICES ---------- */
IF OBJECT_ID('dbo.Notices', 'U') IS NULL
CREATE TABLE dbo.Notices (
    NoticeId        INT IDENTITY(1,1) PRIMARY KEY,
    Title           NVARCHAR(150) NOT NULL,
    Category        NVARCHAR(30)  NOT NULL,
    Content         NVARCHAR(MAX) NOT NULL,
    TargetAudience  NVARCHAR(50)  NOT NULL DEFAULT 'All Students',
    Status          NVARCHAR(20)  NOT NULL DEFAULT 'Published',
    PublishDate     DATETIME2     NOT NULL DEFAULT SYSDATETIME(),
    ExpiryDate      DATETIME2     NULL,
    CreatedBy       INT NULL
        CONSTRAINT FK_Notices_Users FOREIGN KEY REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_Notices_Status CHECK (Status IN ('Published', 'Scheduled', 'Expired')),
    CONSTRAINT CK_Notices_Category CHECK (Category IN ('General', 'Mess', 'Maintenance', 'Events', 'Important'))
);
GO

IF COL_LENGTH('dbo.Notices', 'ExpiryDate') IS NULL
    ALTER TABLE dbo.Notices ADD ExpiryDate DATETIME2 NULL;
IF COL_LENGTH('dbo.Notices', 'CreatedBy') IS NULL
    ALTER TABLE dbo.Notices ADD CreatedBy INT NULL
        CONSTRAINT FK_Notices_Users FOREIGN KEY REFERENCES dbo.Users(UserId);
GO

/* ---------- FEES ---------- */
IF OBJECT_ID('dbo.Fees', 'U') IS NULL
CREATE TABLE dbo.Fees (
    FeeId        INT IDENTITY(1,1) PRIMARY KEY,
    StudentId    INT NOT NULL
        CONSTRAINT FK_Fees_Students FOREIGN KEY REFERENCES dbo.Students(StudentId),
    Description  NVARCHAR(100) NOT NULL,
    Amount       DECIMAL(10, 2) NOT NULL,
    DueDate      DATE NULL,
    PaidOn       DATE NULL,
    Status       NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    CONSTRAINT CK_Fees_Amount CHECK (Amount >= 0),
    CONSTRAINT CK_Fees_Status CHECK (Status IN ('Pending', 'Paid', 'Overdue'))
);
GO

/* ---------- ATTENDANCE ---------- */
IF OBJECT_ID('dbo.Attendance', 'U') IS NULL
CREATE TABLE dbo.Attendance (
    AttendanceId    INT IDENTITY(1,1) PRIMARY KEY,
    StudentId       INT NOT NULL
        CONSTRAINT FK_Attendance_Students FOREIGN KEY REFERENCES dbo.Students(StudentId),
    AttendanceDate  DATE NOT NULL,
    Status          NVARCHAR(10) NOT NULL,
    CONSTRAINT UQ_Attendance UNIQUE (StudentId, AttendanceDate),
    CONSTRAINT CK_Attendance_Status CHECK (Status IN ('Present', 'Absent'))
);
GO

/* ---------- ROOM CHANGE REQUESTS ---------- */
IF OBJECT_ID('dbo.RoomChangeRequests', 'U') IS NULL
CREATE TABLE dbo.RoomChangeRequests (
    RequestId        INT IDENTITY(1,1) PRIMARY KEY,
    StudentId        INT NOT NULL
        CONSTRAINT FK_RoomChange_Students FOREIGN KEY REFERENCES dbo.Students(StudentId),
    RequestedRoomId  INT NULL
        CONSTRAINT FK_RoomChange_Rooms FOREIGN KEY REFERENCES dbo.Rooms(RoomId),
    Reason           NVARCHAR(500) NOT NULL,
    Status           NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    CreatedAt        DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    ReviewedAt       DATETIME2 NULL,
    CONSTRAINT CK_RoomChange_Status CHECK (Status IN ('Pending', 'Approved', 'Rejected'))
);
GO

/* ---------- STARTER DATA (sirf tab jab table khali ho) ---------- */

IF NOT EXISTS (SELECT 1 FROM dbo.Rooms)
INSERT INTO dbo.Rooms (Block, RoomNumber, [Floor], Capacity)
SELECT b.Block, CAST(f.Fl * 100 + r.N AS NVARCHAR(10)), f.Fl, 4
FROM (VALUES ('Block A'), ('Block B'), ('Block C')) b(Block)
CROSS JOIN (VALUES (1), (2), (3)) f(Fl)
CROSS JOIN (VALUES (1), (2), (3), (4), (5)) r(N);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.MessMenu)
INSERT INTO dbo.MessMenu (DayName, Breakfast, Lunch, Dinner) VALUES
('Monday',    'Poha, Jalebi, Milk',            'Kadhi Pakora, Rice, Roti, Salad',    'Aloo Gobi, Dal Makhani, Roti, Rice'),
('Tuesday',   'Aloo Paratha, Curd, Tea',       'Rajma, Jeera Rice, Roti, Mixed Veg', 'Paneer Butter Masala, Roti, Dal, Sweet'),
('Wednesday', 'Idli, Sambar, Chutney',         'Chole Bhature, Onion Salad, Lassi',  'Mix Veg Curry, Roti, Jeera Rice'),
('Thursday',  'Bread Omelette / Veg Sandwich', 'Lemon Rice, Curd, Papad, Poriyal',   'Chicken Curry / Soya Chaap, Roti, Rice'),
('Friday',    'Upma, Coconut Chutney, Tea',    'Dal Fry, Rice, Aloo Bhujia, Roti',   'Egg Curry / Matar Paneer, Roti, Pulao'),
('Saturday',  'Puri Sabzi, Halwa',             'Khichdi, Kadhi, Papad, Pickle',      'Chinese Combo (Noodles, Manchurian)'),
('Sunday',    'Masala Dosa, Sambar',           'Special Veg Biryani, Raita, Salan',  'Light Dinner (Soup, Sandwich, Fruit)');
GO
