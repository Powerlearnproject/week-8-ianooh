
-- Database Schema Creation

CREATE TABLE Regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255),
    population INT
);

CREATE TABLE Water_Sources (
    source_id INT PRIMARY KEY,
    region_id INT,
    source_type VARCHAR(255),
    capacity INT,
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Water_Quality (
    quality_id INT PRIMARY KEY,
    source_id INT,
    test_date DATE,
    quality_level VARCHAR(255),
    FOREIGN KEY (source_id) REFERENCES Water_Sources(source_id)
);

CREATE TABLE Access_Levels (
    access_id INT PRIMARY KEY,
    region_id INT,
    access_percentage DECIMAL(5, 2),
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

-- Sample Data Population

INSERT INTO Regions (region_id, region_name, population) VALUES
(1, 'Region A', 50000),
(2, 'Region B', 30000);

INSERT INTO Water_Sources (source_id, region_id, source_type, capacity) VALUES
(1, 1, 'Well', 1000),
(2, 1, 'Rainwater Tank', 500),
(3, 2, 'River', 2000);

INSERT INTO Water_Quality (quality_id, source_id, test_date, quality_level) VALUES
(1, 1, '2024-09-30', 'Good'),
(2, 2, '2024-09-28', 'Fair'),
(3, 3, '2024-09-25', 'Poor');

INSERT INTO Access_Levels (access_id, region_id, access_percentage) VALUES
(1, 1, 85.50),
(2, 2, 60.75);

-- SQL Queries for Data Retrieval and Analysis

-- Query to retrieve all regions with their water sources and access levels
SELECT r.region_name, r.population, w.source_type, a.access_percentage
FROM Regions r
JOIN Water_Sources w ON r.region_id = w.region_id
JOIN Access_Levels a ON r.region_id = a.region_id;

-- Query to retrieve water sources with poor water quality and their corresponding regions
SELECT r.region_name, w.source_type, q.quality_level
FROM Water_Quality q
JOIN Water_Sources w ON q.source_id = w.source_id
JOIN Regions r ON w.region_id = r.region_id
WHERE q.quality_level = 'Poor';
