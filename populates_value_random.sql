-- The main purpose in this query is to create synthetic data. There are no meaning of values, only replicate format.
INSERT INTO books (CRN, ISBN, Title, Authors, Edition, Publisher, Publisher_Address, Pages, Year, Course_Name)
SELECT
  LPAD((FLOOR(RANDOM() * 99999))::text, 5, '0'),
  '978' || LPAD((FLOOR(RANDOM() * 9999999999))::text, 10, '0'),
  'Title_' || CHR(65 + FLOOR(RANDOM() * 26)::int) || CHR(65 + FLOOR(RANDOM() * 26)::int),

  --If random value is less than 0.5, then 1 author. Else 2 authors.
  CASE WHEN RANDOM() < 0.5 THEN
    'Author ' || CHR(65 + FLOOR(RANDOM() * 26)::int) || CHR(65 + FLOOR(RANDOM() * 26)::int)
  ELSE
    'Author ' || CHR(65 + FLOOR(RANDOM() * 26)::int) || CHR(65 + FLOOR(RANDOM() * 26)::int) || ', ' ||
    'Author ' || CHR(65 + FLOOR(RANDOM() * 26)::int) || CHR(65 + FLOOR(RANDOM() * 26)::int)
  END,

  FLOOR(RANDOM() * 10 + 1)::int,
  'Publisher_' || CHR(65 + FLOOR(RANDOM() * 26)::int),
  'Address_' || CHR(65 + FLOOR(RANDOM() * 26)::int) || CHR(65 + FLOOR(RANDOM() * 26)::int),
  FLOOR(RANDOM() * 1000 + 100)::int,
  FLOOR(RANDOM() * 50 + 1970)::int,
  'Course_' || CHR(65 + FLOOR(RANDOM() * 26)::int)
FROM generate_series(1, 10000);
