Create database SQLPractise;

Go

Use SQLPractise;

create table TargetCustomers
(
	TargetID int not null primary key,
	FirstName varchar(10) not null,
	LastName varchar(10) not null,
	Address varchar(20) not null,
	City varchar(20) not null,
	State varchar(20) not null,
	Zipcode int
);

create table MailingLists
(
	MailingListID int not null primary key,
	MailingList varchar(50)  not null
)

create table TargetMailingLists
(
	TargetID int not null
		References TargetCustomers(TargetID),
	MailingListID int not null
		References MailingLists(MailingListID),
	Constraint PKTargetMailingList primary key clustered (TargetID, MailingListID)
)

alter table TargetMailingLists alter column MailingListID int not null;