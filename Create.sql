use DMDD_TEAM17;

--employee table


create table [Employee] 
(
employeeID INT IDENTITY(1000,1) PRIMARY KEY,
cateringID INT not null,
employeeName nvarchar(60) NOT NULL,
employeeEmail varchar(100) NOT NULL,
employeeAddress varchar(100),
employeeMobileNO CHAR(10),
CONSTRAINT fk_catering_employee FOREIGN KEY(cateringID) REFERENCES catering(cateringID),
);
GO

--Student table

create table [Student] 
(
studentID INT IDENTITY(1000,1) PRIMARY KEY,
studentName nvarchar(45),
studentEmail varchar(100) NOT NULL,
college varchar(60),
major varchar(45),
studentMobileNO CHAR(10),
DOB DATE NOT NULL
);
GO


--Billing table

--drop table [Billing];

ALTER TABLE [Billing]
add CONSTRAINT chk_category CHECK (category IN ('UG', 'PG'));
GO
create table [Billing]
( BillID INT IDENTITY(1,1) PRIMARY KEY,
studentID INT Not null,
Amount Int not null,
feeStatus varchar(40) not null,
deadline DATE,
duration DATE,
category VARCHAR(45),
CONSTRAINT fk_billing_student FOREIGN KEY(studentID) REFERENCES Student(studentID),
CONSTRAINT chk_feestatus CHECK (feeStatus IN ('Finished', 'Pending')),
CONSTRAINT chk_category CHECK (category IN ('UG', 'PG')),
)
GO

--visitor


create table [visitor]
( visitorID INT IDENTITY(1000,1) PRIMARY KEY,
studentID INT Not null,
visitorName VARCHAR(60) not null,
timeIN time,
timeOut time,
visiteddate date,
CONSTRAINT fk_visitor_student FOREIGN KEY(studentID) REFERENCES Student(studentID)
)
GO

--Catering


create table [Catering]
( cateringID INT IDENTITY(1000,1) PRIMARY KEY,
managementID INT Not null,
cateringName VARCHAR(60) not null,
cateringEmail VARCHAR(60) not null,
cateringAddress VARCHAR (100),
packageList VARCHAR (60),
CONSTRAINT fk_management_catering FOREIGN KEY(managementID) REFERENCES [Management](managementID)
)
GO

--catering package


create table [Catering package]
( packageID INT IDENTITY(1000,1) PRIMARY KEY,
cateringID INT Not null,

packageName VARCHAR(60) not null,
packageCost Numeric,
packageContent VARCHAR (20),
CONSTRAINT fk_catering_package FOREIGN KEY(cateringID) REFERENCES Catering(cateringID),
CONSTRAINT chk_pkgcontent CHECK (packageContent IN ('Veg', 'Non-Veg')),
)
GO

--ORDER

create table [order]
( orderID INT IDENTITY(1000,1) PRIMARY KEY,
packageID INT Not null,
studentID int not null,
orderDate date,
CONSTRAINT fk_order_student FOREIGN KEY(studentID) REFERENCES student(studentID),
CONSTRAINT fk_order_cp FOREIGN KEY(packageID) REFERENCES [catering package](packageID),
)
GO

--Delivery

create table [Delivery]
( deliveryID INT IDENTITY(1000,1) PRIMARY KEY,
orderID int,
packageID INT Not null,
deliveryStatus VARCHAR(45),
employeeID int not null,
managerID int not null,
deliveryDate date,
CONSTRAINT fk_deli_emp FOREIGN KEY(employeeID) REFERENCES employee(employeeID),
CONSTRAINT fk_deli_cp FOREIGN KEY(packageID) REFERENCES [catering package](packageID),
CONSTRAINT fk_deli_hm FOREIGN KEY(managerID) REFERENCES [Hostel Manager](managerID),
CONSTRAINT fk_deli_order FOREIGN KEY(orderID) REFERENCES [order](orderID),
CONSTRAINT chk_delivery CHECK (deliveryStatus IN ('Deliverd', 'Not-Delivered')
)
GO

--studentPackage


create table [student package]
( studentpackageID INT IDENTITY(1000,1) PRIMARY KEY,
studentID INT Not null,
packageID INT Not null,
deliverDate date,
CONSTRAINT fk_student_package FOREIGN KEY(studentID) REFERENCES student(studentID),
CONSTRAINT fk_sp_package FOREIGN KEY(packageID) REFERENCES [Catering package](packageID)
)
GO


--Management 

alter table [Management] add userName VARCHAR(20);
alter table [Management] add PASSWORD VARCHAR(20);

create table [Management]
( managementID INT IDENTITY(1000,1) PRIMARY KEY,
managementName VARCHAR(60) not null,
address varchar(80) not null,
userName VARCHAR(20),
PASSWORD VARCHAR(20),
contact Numeric
)
GO


--Hostel manager

--drop table [Hoster Manager];

use DMDD_TEAM17;


create table [Hostel Manager]
( managerID INT IDENTITY(1000,1) PRIMARY KEY,
managementID INT Not null,
managerName VARCHAR(60) not null,
manageremail VARCHAR(60) not null,
address varchar(80) not null,
contact Numeric
CONSTRAINT fk_management_manager FOREIGN KEY(managementID) REFERENCES [Management](managementID),
)
GO

--Hostel

create table [Hostel]
( hostelID INT IDENTITY(1000,1) PRIMARY KEY,
managerID INT Not null,
hostelName VARCHAR(60) not null,
maxOccupany int not null,
currentOccupancy int not null,
totalRooms int not null,
location VARCHAR(45),
CONSTRAINT fk_hostel_hm FOREIGN KEY(managerID) REFERENCES [Hostel Manager](managerID)
)
GO

-- room

create table [Room]
( roomID INT IDENTITY(1000,1) PRIMARY KEY,
hostelID INT Not null,
capacity INT Not null
CONSTRAINT fk_hostel_room FOREIGN KEY(hostelID) REFERENCES [Hostel](hostelID)
)
GO

--Room date

create table [Room Date]
( roomDateID INT IDENTITY(1000,1) PRIMARY KEY,
roomID INT Not null,
studentID INT Not null,
startDate date,
endDate date,
CONSTRAINT fk_date_room FOREIGN KEY(roomID) REFERENCES [room](roomID),
CONSTRAINT fk_date_student FOREIGN KEY(studentID) REFERENCES [student](studentID)
)
GO

--feedback


create table [feedback]
( feedbackID INT IDENTITY(1000,1) PRIMARY KEY,
managementID INT Not null,
studentID INT Not null,
feedback varchar(100),
Date date,
CONSTRAINT fk_fb_management FOREIGN KEY(managementID) REFERENCES [management](managementID),
CONSTRAINT fk_fb_student FOREIGN KEY(studentID) REFERENCES [student](studentID)
)
GO


