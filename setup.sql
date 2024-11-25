CREATE TABLE unnormalized(
    CRN varchar(5) NOT NULL,
    ISBN varchar(13) NOT NULL,
    Title varchar(255) NOT NULL,
    Authors varchar(255) NOT NULL,
    Edition smallint NOT NULL,
    Publisher varchar(100) NOT NULL,
    Publisher_Address varchar(255) NOT NULL,
    Pages smallint NOT NULL,
    Year smallint NOT NULL,
    Course_Name varchar(100) NOT NULL,
    PRIMARY KEY (CRN, ISBN)
);