DO $$
BEGIN

DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS books;


CREATE TABLE books (
    ISBN varchar(13) NOT NULL PRIMARY KEY,
    Title varchar(255) NOT NULL,
    Edition smallint NOT NULL,
    Publisher varchar(100) NOT NULL,
    Publisher_Address varchar(255) NOT NULL,
    Pages smallint NOT NULL,
    Year smallint NOT NULL
);

CREATE TABLE authors (
    Author_ID serial PRIMARY KEY,
    Author_Name varchar(255) NOT NULL UNIQUE
);

CREATE TABLE book_authors (
    ISBN varchar(13) NOT NULL,
    Author_ID int NOT NULL,
    PRIMARY KEY (ISBN, Author_ID),
    FOREIGN KEY (ISBN) REFERENCES books (ISBN)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Author_ID) REFERENCES authors (Author_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE courses (
    CRN varchar(5) NOT NULL PRIMARY KEY,
    Course_Name varchar(100) NOT NULL
);

CREATE TABLE course_books (
    CRN varchar(5) NOT NULL,
    ISBN varchar(13) NOT NULL,
    PRIMARY KEY (CRN, ISBN),
    FOREIGN KEY (CRN) REFERENCES courses (CRN)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES books (ISBN)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO books (ISBN, Title, Edition, Publisher, Publisher_Address, Pages, Year)
SELECT DISTINCT
    ISBN,
    Title,
    Edition,
    Publisher,
    Publisher_Address,
    Pages,
    Year
FROM unnormalized;

INSERT INTO authors (Author_Name)
SELECT DISTINCT TRIM(author_name) AS Author_Name
FROM (
    SELECT UNNEST(STRING_TO_ARRAY(Authors, ',')) AS author_name
    FROM unnormalized
) AS split_authors
ON CONFLICT (Author_Name) DO NOTHING;

INSERT INTO book_authors (ISBN, Author_ID)
SELECT DISTINCT
    u.ISBN,
    a.Author_ID
FROM unnormalized u
CROSS JOIN LATERAL
    UNNEST(STRING_TO_ARRAY(u.Authors, ',')) AS split_author(author_name)
JOIN authors a ON a.Author_Name = TRIM(split_author.author_name);

INSERT INTO courses (CRN, Course_Name)
SELECT DISTINCT
    CRN,
    Course_Name
FROM unnormalized;

INSERT INTO course_books (CRN, ISBN)
SELECT DISTINCT
    u.CRN,
    u.ISBN
FROM unnormalized u;

END $$;