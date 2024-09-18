CREATE DATABASE library;
USE library;

CREATE TABLE books (
    id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    publication_date DATE,
    ISBN VARCHAR(13)
);

CREATE TABLE authors (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    biography TEXT
);

CREATE TABLE publishers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE genres (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);


CREATE TABLE book_genres (
    id INT PRIMARY KEY,
    book_id INT,
    genre_id INT,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

INSERT INTO books (id, title, author, publication_date, ISBN) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', '1960-07-11', '9780061120084'),
(2, '1984', 'George Orwell', '1949-06-08', '9780451524935'),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', '9780743273565'),
(4, 'Pride and Prejudice', 'Jane Austen', '1813-01-28', '9780141439511');

INSERT INTO authors (id, name, biography) VALUES
(1, 'Harper Lee', 'Harper Lee was an American novelist known for her Pulitzer Prize-winning novel, To Kill a Mockingbird.'),
(2, 'George Orwell', 'George Orwell was a British novelist, essayist, and critic known for his dystopian novel, 1984.'),
(3, 'F. Scott Fitzgerald', 'F. Scott Fitzgerald was an American novelist and short story writer known for his novels and stories that capture the essence of the Jazz Age.'),
(4, 'Jane Austen', 'Jane Austen was an English novelist known for her novels of manners and romance, such as Pride and Prejudice.');

INSERT INTO publishers (id, name, address) VALUES
(1, 'J.B. Lippincott & Co.', 'Philadelphia, PA'),
(2, 'Secker and Warburg', 'London, UK'),
(3, 'Charles Scribner''s Sons', 'New York, NY'),
(4, 'T. Egerton', 'London, UK');

INSERT INTO genres (id, name, description) VALUES
(1, 'Fiction', 'Novels and short stories that are not based on real events.'),
(2, 'Classics', 'Novels and works of literature considered to be of high importance and influence.'),
(3, 'Mystery', 'Novels and stories that involve solving a puzzle or uncovering a hidden truth.'),
(4, 'Rockstory', 'Novels and stories that focus on the relationship between characters.');


INSERT INTO book_genres (id, book_id, genre_id) VALUES
(1, 1, 2),
(2, 2, 1), 
(3, 3, 2), 
(4, 4, 4); 

SELECT * FROM books;

SELECT * FROM authors;

SELECT books.title, authors.name AS author
FROM books
JOIN authors ON books.author = authors.name;

SELECT books.title, genres.name AS genre
FROM books
JOIN book_genres ON books.id = book_genres.book_id
JOIN genres ON book_genres.genre_id = genres.id;

CREATE TABLE patrons (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE membership_types (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    duration INT
);

CREATE TABLE patron_membership (
    id INT PRIMARY KEY,
    patron_id INT,
    membership_type_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id),
    FOREIGN KEY (membership_type_id) REFERENCES membership_types(id)
);

CREATE TABLE patron_fines (
    id INT PRIMARY KEY,
    patron_id INT,
    fine_amount DECIMAL(10, 2),
    fine_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

CREATE TABLE patron_payments (
    id INT PRIMARY KEY,
    patron_id INT,
    payment_amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

INSERT INTO patrons (id, name, email, phone_number, address) VALUES
(1, 'John Doe', 'johndoe@example.com', '123-456-7890', '123 Main St'),
(2, 'Jane Smith', 'janesmith@example.com', '987-654-3210', '456 Elm St'),
(3, 'Bob Johnson', 'bobjohnson@example.com', '555-123-4567', '789 Oak St'),
(4, 'Alice Brown', 'alicebrown@example.com', '111-222-3333', '321 Maple St'),
(5, 'Mike Davis', 'mikedavis@example.com', '444-555-6666', '901 Pine St');

INSERT INTO membership_types (id, name, description, duration) VALUES
(1, 'Basic', 'Access to library materials for 1 year', 365),
(2, 'Premium', 'Access to library materials, digital media, and special events for 1 year', 365),
(3, 'Student', 'Access to library materials for 6 months', 180),
(4, 'Senior', 'Access to library materials for 1 year, with discounts on programs and services', 365),
(5, 'Family', 'Access to library materials for 1 year, for up to 5 family members', 365);

INSERT INTO patron_membership (id, patron_id, membership_type_id, start_date, end_date) VALUES
(1, 1, 1, '2022-01-01', '2023-01-01'),
(2, 2, 2, '2022-06-01', '2023-06-01'),
(3, 3, 3, '2022-09-01', '2023-03-01'),
(4, 4, 4, '2022-03-01', '2023-03-01'),
(5, 5, 5, '2022-12-01', '2023-12-01');

INSERT INTO patron_fines (id, patron_id, fine_amount, fine_date) VALUES
(1, 1, 5.00, '2022-02-01'),
(2, 2, 10.00, '2022-07-01'),
(3, 3, 2.00, '2022-10-01'),
(4, 4, 8.00, '2022-04-01'),
(5, 5, 12.00, '2022-11-01');

INSERT INTO patron_payments (id, patron_id, payment_amount, payment_date) VALUES
(1, 1, 20.00, '2022-01-15'),
(2, 2, 50.00, '2022-06-15'),
(3, 3, 15.00, '2022-09-15'),
(4, 4, 30.00, '2022-03-15'),
(5, 5, 60.00, '2022-12-15');

SELECT * FROM patrons;

SELECT patrons.name, membership_types.name AS membership_type, patron_membership.start_date, patron_membership.end_date
FROM patrons
JOIN patron_membership ON patrons.id = patron_membership.patron_id
JOIN membership_types ON patron_membership.membership_type_id = membership_types.id;

SELECT patrons.name, patron_fines.fine_amount, patron_fines.fine_date
FROM patrons
JOIN patron_fines ON patrons.id = patron_fines.patron_id;

SELECT patrons.name, patron_payments.payment_amount, patron_payments.payment_date
FROM patrons
JOIN patron_payments ON patrons.id = patron_payments.patron_id;









