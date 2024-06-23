-- DROP DATABASE Library;
-- drop table tbl_book_authors;

/* creating database*/
CREATE DATABASE Library;

USE Library;

/* Publisher */
CREATE TABLE tbl_publisher(
Publisher_PublisherName VARCHAR(255) PRIMARY KEY,
Publisher_PublisherAddress VARCHAR(255),
Publisher_PublisherPhone VARCHAR(255));

/* Borrower */
CREATE TABLE tbl_borrower(
borrower_CardNo INT PRIMARY KEY AUTO_INCREMENT,
borrower_BorrowerName VARCHAR(255),
borrower_BorrowerAddress VARCHAR(255),
borrower_Borrowerphone VARCHAR(255));

/* Library Branch */
CREATE TABLE tbl_library_branch(
library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
library_branch_BranchName VARCHAR(255),
library_branch_BranchAddress VARCHAR(255));

/* Book */
CREATE TABLE tbl_book(
book_BookID INT PRIMARY KEY AUTO_INCREMENT,
book_Title VARCHAR(255),
book_PublisherName VARCHAR(255),
FOREIGN KEY (book_PublisherName)
REFERENCES tbl_publisher(Publisher_PublisherName)ON DELETE CASCADE);

/* Book Author */
CREATE TABLE tbl_book_authors(
book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
book_authors_BookID INT,
book_authors_AuthorName VARCHAR(255),
FOREIGN KEY (book_authors_BookID)
REFERENCES tbl_book(book_BookID)ON DELETE CASCADE);

/* Book Copies*/
CREATE TABLE tbl_book_copies(
book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
book_copies_BookID INT,
book_copies_BranchID  INT,
book_copies_No_of_Copies INT,
FOREIGN KEY(book_copies_BookID) 
REFERENCES tbl_book(book_BookID)ON DELETE CASCADE,
FOREIGN KEY(book_copies_BranchID)
REFERENCES tbl_library_branch(library_branch_BranchID)ON DELETE CASCADE);

/* Book Loans*/
CREATE TABLE tbl_book_loans(
book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
book_loans_BookID INT,
book_loans_BranchID INT,
book_loans_CardNo INT,
book_loans_DateOut DATE,
book_loans_DueDate DATE,
FOREIGN KEY(book_loans_BookID)
REFERENCES tbl_book(book_BookID)ON DELETE CASCADE,
FOREIGN KEY(book_loans_BranchID)
REFERENCES tbl_library_branch(library_branch_BranchID)ON DELETE CASCADE,
FOREIGN KEY(book_loans_CardNo)
REFERENCES tbl_borrower(borrower_CardNo)ON DELETE CASCADE);



/* Inserting data in  tbl_book_authors */
insert into tbl_book_authors(book_authors_BookID, book_authors_AuthorName) VALUES
(1,	'Patrick Rothfuss'),(2,	'Stephen King'),(3,	'Stephen King'),(4,	'Frank Herbert'),(5,	'J.R.R. Tolkien'),(6,	'Christopher Paolini'),(6,	'Patrick Rothfuss'),(8, 'J.K. Rowling'),
(9,	'Haruki Murakami'),(10, 'Shel Silverstein'),(11, 'Douglas Adams'),(12, 'Aldous Huxley'),(13, 'William Goldman'),(14, 'Chuck Palahniuk'),(15, 'Louis Sachar'),
(16, 'J.K. Rowling'),(17, 'J.K. Rowling'),(18, 'J.R.R. Tolkien'),(19, 'George R.R. Martin'),(20, 'Mark Lee');

/* Inserting data in  tbl_book_loans*/
insert into tbl_book_loans(book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate) VALUES
(1,	1, 100, '2018-01-01', '2018-02-02'),
(2,	1, 100, '2018-01-01', '2018-02-02'),
(3,	1, 100, '2018-01-01', '2018-02-02'),
(4, 1, 100, '2018-01-01', '2018-02-02'),
(5, 1, 102, '2018-03-01', '2018-03-02'),
(6, 1, 102, '2018-03-01', '2018-03-02'),
(7, 1, 102, '2018-03-01', '2018-03-02'),
(8, 1, 102, '2018-03-01', '2018-03-02'),
(9, 1, 102, '2018-03-01', '2018-03-02'),
(11, 1, 102, '2018-03-01', '2018-03-02'),
(12, 2, 105, '2017-12-12', '2018-12-01'),
(10, 2, 105, '2017-12-12', '2017-12-01'),
(20, 2, 105, '2018-03-02', '2018-03-03'),
(18, 2, 105, '2018-05-01', '2018-05-02'),
(19, 2, 105, '2018-05-01', '2018-05-02'),
(19, 2, 100, '2018-03-01', '2018-03-02'),
(11, 2, 106, '2018-07-01', '2018-07-02'),
(1, 2, 106, '2018-07-01', '2018-07-02'),
(2, 2, 100, '2018-07-01', '2018-07-02'),
(3, 2, 100, '2018-07-01', '2018-07-02'),
(5, 2, 105, '2017-12-12', '2018-12-01'),
(4, 3, 103, '2018-09-01', '2018-09-02'),
(7, 3, 102, '2018-03-01', '2018-03-02'),
(17, 3, 102, '2018-03-01', '2018-03-02'),
(16, 3, 104, '2018-03-01', '2018-03-02'),
(15,3, 104, '2018-03-01', '2018-03-02'),
(15, 3, 107, '2018-03-01', '2018-03-02'),
(14, 3, 104, '2018-03-01','2018-03-02'),
(13, 3, 107, '2018-03-01', '2018-03-02'),
(13, 3, 102, '2018-03-01', '2018-03-02'),
(19, 3, 102, '2017-12-12', '2018-12-01'),
(20, 4, 103,'2018-03-01', '2018-03-02'),
(1, 4, 102, '2018-12-01', '2018-12-02'),
(3, 4, 107, '2018-03-01', '2018-03-02'),
(18, 4, 107, '2018-03-01', '2018-03-02'),
(12, 4, 102, '2018-04-01', '2018-04-02'),
(11, 4, 103, '2018-01-15', '2018-02-15'),
(9, 4, 103, '2018-01-15', '2018-02-15'),
(7, 4, 107, '2018-01-01', '2018-02-02'),
(4, 4, 103, '2018-01-01', '2018-02-02'),
(1, 4, 103, '2017-02-02', '2018-02-03'),
(20, 4, 103, '2018-03-01', '2018-03-02'),
(1, 4, 102, '2018-12-01', '2018-12-02'),
(3, 4, 107, '2018-01-13', '2018-02-13'),
(18, 4, 107, '2018-01-13', '2018-02-13'),
(12, 4, 102, '2018-01-14', '2018-02-14'),
(11, 4, 103, '2018-01-15', '2018-02-15'),
(9, 4, 103, '2018-01-15', '2018-02-15'),
(7, 4, 107, '2018-01-19', '2018-02-19'),
(4, 4, 103, '2018-01-19', '2018-02-19'),
(1, 4, 103, '2018-01-22', '2018-02-22');






