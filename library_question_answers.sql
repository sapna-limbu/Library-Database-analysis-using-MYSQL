USE library;

-- 1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

SELECT BR.library_branch_BranchName, SUM(C.book_copies_No_of_Copies) AS total_copies
FROM tbl_book_copies AS C
JOIN  tbl_book AS B ON B.book_BookID = C.book_copies_BookID
JOIN tbl_library_branch AS BR ON C.book_copies_BranchID = BR.library_branch_BranchID
WHERE B.book_title = 'The Lost Tribe' AND BR.library_branch_BranchName = 'Sharpstown'
GROUP BY BR.library_branch_BranchName;


WITH cte AS(SELECT *
FROM tbl_book_copies AS C
JOIN tbl_book AS B
ON C.book_copies_BookID=B.book_BookID
JOIN tbl_library_branch AS BR
ON BR.library_branch_BranchID=C.book_copies_BranchID)
SELECT library_branch_BranchName, book_copies_No_Of_Copies
FROM cte
WHERE book_Title='The Lost Tribe' AND library_branch_BranchName='Sharpstown'
GROUP BY BR.library_branch_BranchName,book_copies_No_Of_Copies;

-- 2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?

SELECT BR.library_branch_BranchName, SUM(C.book_copies_No_of_Copies) AS total_copies
FROM tbl_book_copies AS C
JOIN tbl_book AS B ON B.book_BookID = C.book_copies_BookID
JOIN tbl_library_branch AS BR ON C.book_copies_BranchID = BR.library_branch_BranchID
WHERE B.book_title = 'The Lost Tribe'
GROUP BY BR.library_branch_BranchName
ORDER BY total_copies DESC;

WITH cte1 AS(SELECT *
FROM tbl_book_copies AS C
JOIN tbl_book AS B
ON C.book_copies_BookID=B.book_BookID
JOIN tbl_library_branch AS BR
ON BR.library_branch_BranchID=C.book_copies_BranchID)
SELECT library_branch_BranchName,count(library_branch_BranchName)*book_copies_No_Of_Copies as lost_tribe_count
FROM cte1
WHERE book_Title='The Lost Tribe'
GROUP BY library_branch_BranchName,book_copies_No_Of_Copies;

-- 3. Retrieve the names of all borrowers who do not have any books checked out

SELECT borrower_BorrowerName FROM tbl_borrower
WHERE borrower_CardNo NOT IN (SELECT book_loans_CardNo FROM tbl_book_loans);

WITH cte2 AS (SELECT DISTINCT book_loans_CardNo
FROM tbl_book_loans)
SELECT borrower_BorrowerName
FROM tbl_borrower
WHERE NOT EXISTS (SELECT 1 FROM cte2 WHERE book_loans_CardNo = borrower_CardNo);


-- 4 For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, 
-- the borrower's name, and the borrower's address. 
/* NOTE : I HAVE INSERTED DATA IN  DATE FORMAT AS YYYY-MM-DD, IF YOUR DATA IS IN YYYY-DD-MM KINDLY REVERSE THE DATE TO GET CORRECT ANSWER */

SELECT B.book_title, BR.borrower_BorrowerName, BR.borrower_BorrowerAddress
FROM tbl_book_loans AS BL
INNER JOIN tbl_book AS B ON BL.book_loans_BookID = B.book_BookID
INNER JOIN tbl_borrower AS BR ON BL.book_loans_CardNo = BR.borrower_CardNo
INNER JOIN tbl_library_branch AS LB ON BL.book_loans_BranchID = LB.library_branch_BranchID
WHERE BL.book_loans_DueDate = '2018-03-02' AND LB.library_branch_BranchName = 'Sharpstown';


WITH cte3 AS( SELECT * FROM  tbl_library_branch AS LB
JOIN tbl_book_loans AS BL
ON LB.library_branch_BranchID=BL.book_loans_BranchID
JOIN tbl_borrower AS BR
ON BR.borrower_CardNo=BL.book_loans_CardNo
JOIN tbl_book AS B
ON B.book_BookID=BL.book_loans_BookID)
SELECT book_Title,borrower_BorrowerName,borrower_BorrowerAddress FROM cte3
WHERE book_loans_DueDate='2018-03-02' AND library_branch_BranchName ='Sharpstown';


-- 5 For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

SELECT LB.library_branch_BranchName, COUNT(*) AS book_loans
FROM tbl_book_loans AS BL
INNER JOIN tbl_library_branch AS LB ON BL.book_loans_BranchID = LB.library_branch_BranchID
GROUP BY LB.library_branch_BranchName
ORDER BY book_loans DESC;

WITH cte4 AS(
SELECT * FROM tbl_library_branch as LB
JOIN tbl_book_loans AS BL
ON LB.library_branch_BranchID=BL.book_loans_BranchID)
SELECT library_branch_BranchName,count(library_branch_BranchName) as book_loans 
FROM cte4
GROUP BY library_branch_BranchName
ORDER BY book_loans DESC;


-- 6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

SELECT BR.borrower_BorrowerName,BR.borrower_BorrowerAddress,COUNT(*) AS Books_checked
FROM tbl_borrower AS BR
INNER JOIN tbl_book_loans AS BL ON BR.borrower_CardNo = BL.book_loans_CardNo
GROUP BY BR.borrower_BorrowerName, BR.borrower_BorrowerAddress
HAVING COUNT(*) > 5
ORDER BY Books_checked DESC;

WITH cte5 AS(
SELECT * FROM tbl_borrower AS BR
JOIN tbl_book_loans AS BL
ON BR.borrower_CardNo=BL.book_loans_CardNo)
SELECT borrower_BorrowerName,borrower_BorrowerAddress,count(borrower_CardNo) AS Books_checked
FROM cte5
GROUP BY borrower_BorrowerName,borrower_BorrowerAddress
HAVING Books_checked>5
ORDER BY Books_checked DESC;


-- 7.  For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

SELECT B.book_title, COUNT(BC.book_copies_No_Of_Copies) * BC.book_copies_No_Of_Copies AS Copies
FROM tbl_book_authors AS BA
INNER JOIN tbl_book AS B ON BA.book_authors_BookID = B.book_BookID
INNER JOIN tbl_book_copies AS BC ON B.book_BookID = BC.book_copies_BookID
INNER JOIN tbl_library_branch AS LB ON BC.book_copies_BranchID = LB.library_branch_BranchID
WHERE BA.book_authors_AuthorName = 'Stephen King' AND LB.library_branch_BranchName = 'Central'
GROUP BY book_title,book_copies_No_Of_Copies;

-- central_br alias given to the cte 
WITH central_br AS(
SELECT * FROM tbl_book_authors AS BA
JOIN tbl_book AS B
ON BA.book_authors_BookID=B.book_BookID
JOIN tbl_book_copies AS BC
ON BC.book_copies_BookID=B.book_BookID
JOIN tbl_library_branch AS LB
ON LB.library_branch_BranchID=BC.book_copies_BranchID)
SELECT book_Title,count(book_copies_No_Of_Copies)*book_copies_No_Of_Copies AS Copies
FROM central_br
WHERE book_authors_AuthorName='Stephen King' AND library_branch_BranchName='Central'
GROUP BY book_Title,book_copies_No_Of_Copies;















select * from tbl_library_branch;
select * from tbl_book_copies;
select * from tbl_book;
select * from tbl_borrower;
select * from tbl_book_loans;
select * from tbl_book_authors;