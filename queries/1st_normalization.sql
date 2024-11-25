DO $$
BEGIN

CREATE TABLE books(
    CRN varchar(5) NOT NULL,
    ISBN varchar(13) NOT NULL,
    Title varchar(255) NOT NULL,
    Edition smallint NOT NULL,
    Publisher varchar(100) NOT NULL,
    Publisher_Address varchar(255) NOT NULL,
    Pages smallint NOT NULL,
    Year smallint NOT NULL,
    Course_Name varchar(100) NOT NULL,
    PRIMARY KEY (CRN, ISBN)
);

CREATE TABLE authors(
    Author_ID serial PRIMARY KEY,
    Author_Name varchar(255) NOT NULL UNIQUE
);

CREATE TABLE book_authors (
    CRN varchar(5) NOT NULL,
    ISBN varchar(13) NOT NULL,
    Author_ID int NOT NULL,
    PRIMARY KEY (CRN, ISBN, Author_ID),
    FOREIGN KEY (CRN, ISBN) REFERENCES books (CRN, ISBN)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Author_ID) REFERENCES authors (Author_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO books(CRN, ISBN, Title, Edition, Publisher, Publisher_Address, Pages, Year, Course_Name)
SELECT
    CRN, ISBN, Title, Edition, Publisher, Publisher_Address, Pages, Year, Course_Name
FROM unnormalized;

INSERT INTO authors (Author_Name)
SELECT DISTINCT TRIM(author_name) AS Author_Name
FROM (
    SELECT DISTINCT UNNEST(STRING_TO_ARRAY(Authors, ',')) AS author_name
    FROM unnormalized
) AS split_authors
ON CONFLICT (Author_Name) DO NOTHING;

INSERT INTO book_authors (CRN, ISBN, Author_ID)
SELECT
    u.CRN,
    u.ISBN,
    a.Author_ID
FROM unnormalized u
CROSS JOIN LATERAL
    UNNEST(STRING_TO_ARRAY(u.Authors, ',')) AS split_author(author_name)
JOIN authors a ON a.Author_Name = TRIM(split_author.author_name);

END $$;