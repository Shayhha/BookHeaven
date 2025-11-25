DROP DATABASE IF EXISTS BookHeaven;
CREATE DATABASE BookHeaven

CREATE TABLE Users (
    userId INT IDENTITY(1,1) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY(userId)
);

CREATE TABLE UserInfo (
    userId INT IDENTITY(1,1) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    isAdmin BIT DEFAULT 0,
    PRIMARY KEY(userId),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE Address (
    userId INT PRIMARY KEY NOT NULL,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    apartNum INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE CreditCards (
    userId INT NOT NULL,
    number VARCHAR(100) NOT NULL,
    date VARCHAR(5) NOT NULL, -- storing as string in mm/yy format
    ccv INT NOT NULL,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE Books (
    name VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    date VARCHAR(10) NOT NULL, -- storing as string in dd/mm/yyyy format
    bookId INT IDENTITY(1,1) UNIQUE NOT NULL,
    category VARCHAR(255) NOT NULL,
    format VARCHAR(255) NOT NULL,
    price FLOAT(2) NOT NULL,
    stock INT NOT NULL,
    imageUrl VARCHAR(500) NOT NULL,
    ageLimitation INT NOT NULL,
    salePrice FLOAT(2) DEFAULT 0,
    PRIMARY KEY (name, author, date)
);

CREATE TABLE Orders (
    orderId INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    orderDate VARCHAR(10) NOT NULL, -- storing as string in dd/mm/yyyy format
    totalPrice FLOAT(2) NOT NULL,
    shippingDate VARCHAR(10),
    shippingNum AS CONCAT('D45o9sqZA', CAST(orderId AS VARCHAR(20))) PERSISTED UNIQUE,
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE OrderDetails (
    orderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    orderId INT NOT NULL,
    bookId INT NOT NULL,
    bookName VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price FLOAT(2) NOT NULL,
    FOREIGN KEY (orderId) REFERENCES Orders(orderId),
    FOREIGN KEY (bookId) REFERENCES Books(bookId)
);

CREATE TABLE Cart (
    userId INT,
    bookId INT,
    amount INT,
    PRIMARY KEY(userId, bookId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (bookId) REFERENCES Books(bookId)
);

--Insert all of our default books into Books table
SET IDENTITY_INSERT Books ON;

INSERT INTO Books (name, author, date, bookId, category, format, price, stock, imageUrl, ageLimitation, salePrice)
VALUES 
    ('To Kill a Mockingbird', 'Harper Lee', '11/07/1960', 1, 'Fiction, Drama', 'Paperback', 10.99, 100, 'https://m.media-amazon.com/images/I/71j4Ua+aPyL.jpg', 6, 9.99),
    ('Me Before You', 'Jojo Moyes', '12/31/2012', 2, 'Romance, Fiction', 'Paperback', 9.99, 120, 'https://m.media-amazon.com/images/I/61yk+NL+u9L._AC_UF1000,1000_QL80_.jpg', 14, 8.99),
    ('The Great Gatsby', 'F. Scott Fitzgerald', '10/04/1925', 3, 'Fiction, Romance', 'Paperback', 9.99, 120, 'https://m.media-amazon.com/images/I/71egatZdhiL._AC_UF1000,1000_QL80_.jpg', 10, 8.99),
    ('Pride and Prejudice', 'Jane Austen', '28/01/1813', 4, 'Romance', 'Paperback', 8.75, 90, 'https://m.media-amazon.com/images/I/41TYCIYe2-L.jpg', 12, 0),
    ('The Catcher in the Rye', 'J.D. Salinger', '16/07/1951', 5, 'Fiction', 'Hardcover', 11.25, 110, 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1398034300i/5107.jpg', 2, 9.25),
    ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', '26/06/1997', 6, 'Fantasy', 'Paperback', 8.99, 1000, 'https://embed.cdn.pais.scholastic.com/v1/products/identifiers/isbn/9780590353403/primary/renditions/600?useMissingImage=true', 9, 7.49),
    ('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', '02/07/1998', 7, 'Fantasy', 'Paperback', 9.99, 950, 'https://images.booksense.com/images/014/130/9781594130014.jpg', 9, 8.49),
    ('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', '08/07/1999', 8, 'Fantasy', 'Paperback', 10.99, 900, 'https://images.booksense.com/images/358/136/9780439136358.jpg', 9, 9.49),
    ('Harry Potter and the Goblet of Fire', 'J.K. Rowling', '08/07/2000', 9, 'Fantasy', 'Paperback', 11.99, 850, 'https://images.booksense.com/images/595/139/9780439139595.jpg', 9, 10.49),
    ('Harry Potter and the Order of the Phoenix', 'J.K. Rowling', '21/06/2003', 10, 'Fantasy', 'Paperback', 12.99, 800, 'https://images.booksense.com/images/064/358/9780439358064.jpg', 9, 11.49),
    ('Harry Potter and the Half-Blood Prince', 'J.K. Rowling', '16/07/2005', 11, 'Fantasy', 'Paperback', 13.99, 750, 'https://prodimage.images-bn.com/pimages/9780439785969_p0_v3_s1200x630.jpg', 9, 12.49),
    ('Harry Potter and the Deathly Hallows', 'J.K. Rowling', '21/07/2007', 12, 'Fantasy', 'Paperback', 14.99, 700, 'https://m.media-amazon.com/images/I/811t1pfIZXL._AC_UF1000,1000_QL80_.jpg', 9, 13.49),
    ('Gone Girl', 'Gillian Flynn', '05/06/2012', 13, 'Thriller, Mystery', 'Paperback', 12.99, 500, 'https://m.media-amazon.com/images/I/41Upy5cz73L._AC_UF1000,1000_QL80_.jpg', 18, 0),
    ('The Girl with the Dragon Tattoo', 'Stieg Larsson', '16/08/2005', 14, 'Thriller, Mystery', 'Hardcover', 15.49, 450, 'https://m.media-amazon.com/images/I/71PK0mfHRDL._AC_UF894,1000_QL80_.jpg', 18, 0),
    ('The Da Vinci Code', 'Dan Brown', '18/03/2003', 15, 'Thriller, Mystery', 'Paperback', 10.99, 600, 'https://m.media-amazon.com/images/I/51yCvlBVEQL._AC_UF1000,1000_QL80_.jpg', 16, 9.99),
    ('The Silence of the Lambs', 'Thomas Harris', '05/05/1988', 16, 'Thriller, Mystery', 'Paperback', 9.99, 700, 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1327268210i/6586236.jpg', 18, 8.49),
    ('The Bourne Identity', 'Robert Ludlum', '04/02/1980', 17, 'Thriller', 'Paperback', 8.99, 550, 'https://upload.wikimedia.org/wikipedia/en/6/65/Ludlum_-_The_Bourne_Identity_Coverart.png', 16, 0),
    ('The Girl on the Train', 'Paula Hawkins', '13/01/2015', 18, 'Thriller, Mystery', 'Hardcover', 14.99, 400, 'https://m.media-amazon.com/images/I/81-Q2OAVeXL._AC_UF1000,1000_QL80_.jpg', 18, 12.99),
    ('The Diary of a Young Girl', 'Anne Frank', '25/06/1947', 19, 'Biography', 'Paperback', 10.99, 800, 'https://m.media-amazon.com/images/I/51Eyjz65gyL._AC_UF1000,1000_QL80_.jpg', 18, 0),
    ('Steve Jobs', 'Walter Isaacson', '24/10/2011', 20, 'Biography', 'Hardcover', 14.99, 700, 'https://m.media-amazon.com/images/I/71ENRyxwxoL._AC_UF1000,1000_QL80_.jpg', 14, 0),
    ('The Autobiography of Malcolm X', 'Malcolm X and Alex Haley', '29/10/1965', 21, 'Biography', 'Paperback', 11.99, 750, 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1652640513i/26137012.jpg', 18, 0),
    ('Unbroken: A World War II Story of Survival, Resilience, and Redemption', 'Laura Hillenbrand', '16/11/2010', 22, 'Biography', 'Paperback', 13.99, 600, 'https://m.media-amazon.com/images/I/81x7SoBVJZL._AC_UF1000,1000_QL80_.jpg', 16, 0),
    ('Dune', 'Frank Herbert', '01/06/1965', 23, 'Science Fiction', 'Paperback', 11.99, 800, 'https://m.media-amazon.com/images/I/71oO1E-XPuL._AC_UF894,1000_QL80_.jpg', 12, 0),
    ('The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', '12/10/1979', 24, 'Science Fiction, Comedy', 'Paperback', 9.99, 750, 'https://m.media-amazon.com/images/I/51vfuNNWMTS.jpg', 14, 0),
    ('Neuromancer', 'William Gibson', '01/07/1984', 25, 'Science Fiction', 'Paperback', 10.49, 700, 'https://m.media-amazon.com/images/I/81m-rJnUdRL._AC_UF1000,1000_QL80_.jpg', 12, 9.49),
    ('Foundation', 'Isaac Asimov', '01/05/1951', 26, 'Science Fiction', 'Paperback', 12.99, 850, 'https://m.media-amazon.com/images/I/81J4LjdqQFL._AC_UF1000,1000_QL80_.jpg', 14, 0),
    ('Snow Crash', 'Neal Stephenson', '02/06/1992', 27, 'Science Fiction', 'Paperback', 11.49, 900, 'https://upload.wikimedia.org/wikipedia/en/d/d5/Snowcrash.jpg', 16, 0),
    ('The Silent Patient', 'Alex Michaelides', '05/02/2019', 28, 'Mystery, Thriller', 'Hardcover', 14.99, 500, 'https://m.media-amazon.com/images/I/91lslnZ-btL._AC_UF1000,1000_QL80_.jpg', 9, 10.99),
    ('Big Little Lies', 'Liane Moriarty', '29/07/2014', 29, 'Mystery, Drama', 'Paperback', 12.49, 600, 'https://m.media-amazon.com/images/I/61-hanqwPAL._AC_UF1000,1000_QL80_.jpg', 12, 0),
    ('The Woman in the Window', 'A.J. Finn', '02/01/2018', 30, 'Mystery, Thriller', 'Hardcover', 13.99, 600, 'https://i.ebayimg.com/images/g/~M8AAOSwiBhf~eEN/s-l600.jpg', 16, 12.99),
    ('Sharp Objects', 'Gillian Flynn', '26/09/2006', 31, 'Mystery, Thriller', 'Paperback', 10.99, 800, 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1475695315l/18045891.jpg', 14, 0),
    ('The Hobbit', 'J.R.R. Tolkien', '21/09/1937', 32, 'Fantasy', 'Paperback', 11.99, 500, 'https://i.pinimg.com/736x/eb/d4/71/ebd4718474badba8ac59598eb578f1e3.jpg', 12, 10.99),
    ('The Glass Menagerie', 'Tennessee Williams', '31/03/1944', 33, 'Drama', 'Hardcover', 12.99, 550, 'https://m.media-amazon.com/images/I/A1rUmsyKmbL._AC_UF1000,1000_QL80_.jpg', 16, 0),
    ('Death of a Salesman', 'Arthur Miller', '10/02/1949', 34, 'Drama', 'Paperback', 11.49, 700, 'https://upload.wikimedia.org/wikipedia/en/2/20/DeathOfASalesman.jpg', 16, 0),
    ('Dirk Gently''s Holistic Detective Agency', 'Douglas Adams', '01/05/1987', 35, 'Comedy, Science Fiction', 'Paperback', 11.99, 700, 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1554401296l/365.jpg', 14, 10.99),
    ('Good Omens', 'Terry Pratchett and Neil Gaiman', '01/05/1990', 36, 'Comedy, Fantasy', 'Paperback', 10.99, 750, 'https://m.media-amazon.com/images/I/81nmLYgG1iL._AC_UF1000,1000_QL80_.jpg', 14, 0),
    ('Three Men in a Boat', 'Jerome K. Jerome', '26/05/1889', 37, 'Comedy, Fiction', 'Paperback', 8.99, 700, 'https://m.media-amazon.com/images/I/71RA3pAijjL._AC_UF1000,1000_QL80_.jpg', 12, 7.99),
	('Bibi: My Story', 'Benjamin Netanyahu', '18/10/2022', 38, 'Biography', 'Hardcover', 20, 25, 'https://m.media-amazon.com/images/I/71dsNcn-i3L._AC_UF1000,1000_QL80_.jpg', 16, 0),
	('Chocolate Cake', 'Michael Rosen', '02/11/2017', 39, 'Comedy', 'Paperback', 12, 40, 'https://www.michaelrosen.co.uk/wp-content/uploads/2017/09/A1mAzTT-0jL.jpg', 4, 0),
	('Little Rabbit Foo Foo', 'Michael Rosen', '07/04/2003', 41, 'Comedy', 'Paperback', 13, 44, 'https://m.media-amazon.com/images/I/91KlyY7-TkL._AC_UF894,1000_QL80_.jpg', 4, 0),
	('Michael Rosen''s Big Book of Bad Things', 'Michael Rosen', '21/09/2010', 42, 'Comedy', 'Paperback', 15, 56, 'https://m.media-amazon.com/images/I/91Jhs3KkjsL._AC_UF894,1000_QL80_.jpg', 5, 0),
	('TOP G Escape The Matrix: Discover the Real World', 'Andrew Tate', '18/12/2022', 43, 'Biography', 'Hardcover', 19.90, 60, 'https://m.media-amazon.com/images/I/61fJPvPk-vL._AC_UF1000,1000_QL80_.jpg', 18, 0),
	('Clean Code: A Handbook of Agile Software Craftsmanship', ' Robert C. Martin', '01/08/2008', 44, 'Biography', 'Hardcover', 19.90, 25, 'https://m.media-amazon.com/images/I/51E2055ZGUL._AC_UF1000,1000_QL80_.jpg', 16, 0),
	('Introduction to C Programming ', 'Reema Thareja', '18/12/2022', 45, 'Biography', 'Hardcover', 19.90, 60, 'https://m.media-amazon.com/images/I/51lAnx+XV1L._AC_UF1000,1000_QL80_.jpg', 16, 0),
	('Einstein: His Life and Universe', ' Walter Isaacson', '13/05/2008', 46, 'Biography, Science', 'Hardcover', 34.90, 60, 'https://m.media-amazon.com/images/I/61lzepo-L4L._AC_UF1000,1000_QL80_.jpg', 16, 0),
	('The Annotated Turing', 'Charles Petzold', '16/06/2008', 47, 'Biography, Science', 'Hardcover', 15.90, 60, 'https://m.media-amazon.com/images/I/71-QoycuvBL._AC_UF1000,1000_QL80_.jpg', 16, 0);

SET IDENTITY_INSERT Books OFF;