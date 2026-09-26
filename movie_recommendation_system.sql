CREATE DATABASE movie_recommendation;
USE movie_recommendation;
CREATE TABLE movies (Movie_ID INT PRIMARY KEY,Title VARCHAR(255),Genres VARCHAR(255),Release_Year INT,Director VARCHAR(255),
    Cast TEXT,Keywords TEXT,Language VARCHAR(100),Runtime INT,Production_Company VARCHAR(255));
CREATE TABLE ratings (User_ID INT,Movie_ID INT,Rating DECIMAL(3,1),Rating_Date DATE,
    FOREIGN KEY (Movie_ID) REFERENCES movies(Movie_ID));
CREATE TABLE movie_revenue (Movie_ID INT PRIMARY KEY,Budget DECIMAL(15,2),Revenue DECIMAL(15,2),Popularity DECIMAL(10,2),
    Vote_Count INT,FOREIGN KEY (Movie_ID) REFERENCES movies(Movie_ID));
SELECT COUNT(*) AS Total_Movies FROM movies;
SELECT COUNT(*) AS Total_Ratings FROM ratings;
SELECT COUNT(*) AS Revenue_Records FROM movie_revenue;
SELECT COUNT(DISTINCT User_ID) AS Total_Users FROM ratings;
SELECT COUNT(DISTINCT Movie_ID) AS Rated_Movies FROM ratings;
SELECT Movie_ID, COUNT(*) AS Count FROM movies GROUP BY Movie_ID HAVING COUNT(*) > 1;
SELECT Movie_ID, COUNT(*) AS Count FROM movie_revenue GROUP BY Movie_ID HAVING COUNT(*) > 1;
SELECT User_ID, Movie_ID,COUNT(*) AS Rating_Count FROM ratings GROUP BY User_ID, Movie_ID HAVING COUNT(*) > 1;
SELECT SUM(Movie_ID IS NULL) AS Missing_Movie_ID,SUM(Title IS NULL) AS Missing_Title,
    SUM(Genres IS NULL) AS Missing_Genres,SUM(Release_Year IS NULL) AS Missing_Release_Year,
    SUM(Director IS NULL) AS Missing_Director,SUM(Cast IS NULL) AS Missing_Cast,
    SUM(Keywords IS NULL) AS Missing_Keywords,SUM(Language IS NULL) AS Missing_Language,
    SUM(Runtime IS NULL) AS Missing_Runtime,SUM(Production_Company IS NULL) AS Missing_Production_Company FROM movies;
SELECT SUM(User_ID IS NULL) AS Missing_User_ID,SUM(Movie_ID IS NULL) AS Missing_Movie_ID,
    SUM(Rating IS NULL) AS Missing_Rating,SUM(Rating_Date IS NULL) AS Missing_Rating_Date FROM ratings;
SELECT SUM(Movie_ID IS NULL) AS Missing_Movie_ID,SUM(Budget IS NULL) AS Missing_Budget,
    SUM(Revenue IS NULL) AS Missing_Revenue,SUM(Popularity IS NULL) AS Missing_Popularity,
    SUM(Vote_Count IS NULL) AS Missing_Vote_Count FROM movie_revenue;
SELECT COUNT(*) AS Invalid_Rating_Movie_IDs FROM ratings r LEFT JOIN movies m ON r.Movie_ID = m.Movie_ID
WHERE m.Movie_ID IS NULL;
SELECT COUNT(*) AS Invalid_Revenue_Movie_IDs FROM movie_revenue mr LEFT JOIN movies m ON mr.Movie_ID = m.Movie_ID
WHERE m.Movie_ID IS NULL;
SELECT Rating,COUNT(*) AS Rating_Count FROM ratings GROUP BY Rating ORDER BY Rating;
SELECT AVG(Rating) AS Average_Rating FROM ratings;
SELECT MIN(Rating) AS Minimum_Rating,MAX(Rating) AS Maximum_Rating FROM ratings;
SELECT m.Movie_ID,m.Title,AVG(r.Rating) AS Average_Rating,COUNT(r.Rating) AS Rating_Count,MIN(r.Rating) AS Minimum_Rating,
    MAX(r.Rating) AS Maximum_Rating FROM movies m JOIN ratings r ON m.Movie_ID = r.Movie_ID GROUP BY m.Movie_ID, m.Title
    ORDER BY Average_Rating DESC;
SELECT m.Title,AVG(r.Rating) AS Average_Rating,COUNT(r.Rating) AS Rating_Count FROM movies m JOIN ratings r ON m.Movie_ID = r.Movie_ID
GROUP BY m.Movie_ID, m.Title HAVING COUNT(r.Rating) >= 50 ORDER BY Average_Rating DESC LIMIT 20;
SELECT m.Title,COUNT(r.Rating) AS Rating_Count,AVG(r.Rating) AS Average_Rating FROM movies m JOIN ratings r
    ON m.Movie_ID = r.Movie_ID GROUP BY m.Movie_ID, m.Title ORDER BY Rating_Count DESC LIMIT 20;
SELECT User_ID,COUNT(*) AS Number_of_Ratings FROM ratings GROUP BY User_ID ORDER BY Number_of_Ratings DESC LIMIT 20;
SELECT User_ID,COUNT(*) AS Number_of_Ratings,AVG(Rating) AS Average_Rating FROM ratings
GROUP BY User_ID ORDER BY Number_of_Ratings DESC;
SELECT Genres,COUNT(*) AS Movie_Count FROM movies GROUP BY Genres ORDER BY Movie_Count DESC;
SELECT m.Genres, AVG(r.Rating) AS Average_Rating,COUNT(r.Rating) AS Rating_Count FROM movies m JOIN ratings r
    ON m.Movie_ID = r.Movie_ID GROUP BY m.Genres HAVING COUNT(r.Rating) >= 50 ORDER BY Average_Rating DESC;
SELECT Language,COUNT(*) AS Movie_Count FROM movies GROUP BY Language ORDER BY Movie_Count DESC;
SELECT m.Language, AVG(r.Rating) AS Average_Rating,COUNT(r.Rating) AS Rating_Count FROM movies m JOIN ratings r
    ON m.Movie_ID = r.Movie_ID GROUP BY m.Language ORDER BY Average_Rating DESC;
SELECT Release_Year,COUNT(*) AS Movie_Count FROM movies GROUP BY Release_Year ORDER BY Release_Year;
SELECT m.Release_Year,AVG(r.Rating) AS Average_Rating,COUNT(r.Rating) AS Rating_Count FROM movies m JOIN ratings r
    ON m.Movie_ID = r.Movie_ID GROUP BY m.Release_Year ORDER BY m.Release_Year;
SELECT m.Title,mr.Budget,mr.Revenue FROM movies m JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID 
ORDER BY mr.Revenue DESC LIMIT 20;
SELECT m.Title,mr.Budget,mr.Revenue FROM movies m JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID 
ORDER BY mr.Budget DESC LIMIT 20;
SELECT m.Title,mr.Budget,mr.Revenue,ROUND((mr.Revenue - mr.Budget) / NULLIF(mr.Budget, 0),2) AS ROI FROM movies m
JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID WHERE mr.Budget > 0 ORDER BY ROI DESC LIMIT 20;
SELECT m.Title,mr.Popularity,mr.Vote_Count FROM movies m JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID
ORDER BY mr.Popularity DESC LIMIT 20;
SELECT m.Title,mr.Popularity,AVG(r.Rating) AS Average_Rating,COUNT(r.Rating) AS Rating_Count FROM movies m
JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID JOIN ratings r ON m.Movie_ID = r.Movie_ID
GROUP BY m.Movie_ID,m.Title,mr.Popularity ORDER BY mr.Popularity DESC;
SELECT m.Title,mr.Vote_Count,AVG(r.Rating) AS Average_Rating FROM movies m JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID
JOIN ratings r ON m.Movie_ID = r.Movie_ID GROUP BY m.Movie_ID,m.Title,mr.Vote_Count ORDER BY mr.Vote_Count DESC;
CREATE VIEW movie_analytics AS SELECT m.Movie_ID,m.Title,m.Genres,m.Release_Year,m.Director,m.Language,m.Runtime,
    m.Production_Company,mr.Budget,mr.Revenue,mr.Popularity,mr.Vote_Count,AVG(r.Rating) AS Average_Rating,
    COUNT(r.Rating) AS Rating_Count FROM movies m LEFT JOIN ratings r ON m.Movie_ID = r.Movie_ID LEFT JOIN movie_revenue mr
    ON m.Movie_ID = mr.Movie_ID GROUP BY m.Movie_ID, m.Title,m.Genres,m.Release_Year,m.Director,m.Language,m.Runtime,
    m.Production_Company,mr.Budget,mr.Revenue,mr.Popularity,mr.Vote_Count;
SELECT * FROM movie_analytics;
SELECT m.Movie_ID,m.Title FROM movies m LEFT JOIN ratings r ON m.Movie_ID = r.Movie_ID WHERE r.Movie_ID IS NULL;
SELECT m.Movie_ID,m.Title FROM movies m LEFT JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID WHERE mr.Movie_ID IS NULL;
SELECT User_ID, Movie_ID,Rating FROM ratings ORDER BY User_ID, Movie_ID;
SELECT r1.User_ID AS User_1, r2.User_ID AS User_2,COUNT(*) AS Common_Movies FROM ratings r1 JOIN ratings r2
    ON r1.Movie_ID = r2.Movie_ID AND r1.User_ID < r2.User_ID GROUP BY r1.User_ID,r2.User_ID ORDER BY Common_Movies DESC;
SELECT m.Title,r.Rating,r.Rating_Date FROM ratings r JOIN movies m ON r.Movie_ID = m.Movie_ID WHERE r.User_ID = 1
ORDER BY r.Rating DESC;
SELECT m.Movie_ID,m.Title,m.Genres,AVG(r.Rating) AS Average_Rating,COUNT(r.Rating) AS Rating_Count,mr.Popularity FROM movies m
JOIN ratings r ON m.Movie_ID = r.Movie_ID LEFT JOIN movie_revenue mr ON m.Movie_ID = mr.Movie_ID GROUP BY m.Movie_ID,
m.Title,m.Genres,mr.Popularity HAVING COUNT(r.Rating) >= 20 ORDER BY Average_Rating DESC, Rating_Count DESC;
CREATE VIEW recommendation_data AS SELECT m.Movie_ID,m.Title,m.Genres,m.Release_Year,m.Director,m.Cast,m.Keywords,
    m.Language,m.Runtime,m.Production_Company,mr.Budget,mr.Revenue,mr.Popularity,mr.Vote_Count,AVG(r.Rating) AS Average_Rating,
    COUNT(r.Rating) AS Rating_Count FROM movies m LEFT JOIN ratings r ON m.Movie_ID = r.Movie_ID LEFT JOIN movie_revenue mr
    ON m.Movie_ID = mr.Movie_ID GROUP BY m.Movie_ID, m.Title,m.Genres,m.Release_Year,m.Director,m.Cast,m.Keywords,m.Language,
    m.Runtime,m.Production_Company,mr.Budget,mr.Revenue,mr.Popularity,mr.Vote_Count;
SELECT * FROM recommendation_data;
