CREATE DATABASE ResumeClassification;
USE ResumeClassification;

CREATE TABLE ExtractedDetails (
    File_Name VARCHAR(255), 
    Category VARCHAR(255),
    Employee_Name VARCHAR(255) NOT NULL,
    Education VARCHAR(255) NOT NULL,
    Skills TEXT,
    Professional_Experience TEXT,
    Companies_Worked TEXT,
    Years_of_Experience FLOAT CHECK (Years_of_Experience >= 0)
);

SHOW VARIABLES LIKE 'secure_file_priv';

TRUNCATE TABLE ExtractedDetails;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_details.csv'
INTO TABLE ExtractedDetails
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;

SELECT * FROM ExtractedDetails LIMIT 60;

### Perform SQL Queries for Data Analysis
# 1. View All Resumes
SELECT * FROM ExtractedDetails;

# 2. Count the Number of Resumes per Job Category
SELECT Category, COUNT(*) AS ResumeCount 
FROM ExtractedDetails 
GROUP BY Category;

# 3. Identify Top Skills for Each Job Category
SELECT Category, Skills, COUNT(*) AS Count 
FROM ExtractedDetails 
GROUP BY Category, Skills 
ORDER BY Category, Count DESC;

# 4. Find Candidates with 5+ Years of Experience (Senior Level)
SELECT Employee_Name, Category, Years_of_Experience 
FROM ExtractedDetails 
WHERE Years_of_Experience >= 5
ORDER BY Years_of_Experience DESC;

# 5. Find Junior-Level Candidates (Less than 2 Years Experience)
SELECT Employee_Name, Category, Years_of_Experience
FROM ExtractedDetails
WHERE Years_of_Experience <= 2
ORDER BY Years_of_Experience ASC;


# 5. Find the Most Common Education Qualifications
SELECT Education, COUNT(*) AS Count 
FROM ExtractedDetails 
GROUP BY Education 
ORDER BY Count DESC;

# 6. Rank Employees Based on Experience
SELECT Employee_Name, Category, Years_of_Experience,
       RANK() OVER (PARTITION BY Category ORDER BY Years_of_Experience DESC) AS RankInCategory
FROM ExtractedDetails;

### Category-Specific SQL Analysis
# PeopleSoft Developers Analysis
SELECT Employee_Name, Category, Education, Skills, Professional_Experience, Years_of_Experience, Companies_Worked
FROM ExtractedDetails 
WHERE Category = 'PeopleSoft Resumes'
ORDER BY Years_of_Experience DESC;

# Workday Developers Analysis
SELECT Employee_Name, Category, Education, Skills, Professional_Experience, Years_of_Experience, Companies_Worked
FROM ExtractedDetails 
WHERE Category = 'WorkDay Resumes'
ORDER BY Years_of_Experience DESC;

# React.js Developers Analysis
SELECT Employee_Name, Category, Education, Skills, Professional_Experience, Years_of_Experience, Companies_Worked
FROM ExtractedDetails 
WHERE Category = 'React JS Developer Resumes'
ORDER BY Years_of_Experience DESC;

# SQL Developer LIGHTING Insight Analysis
SELECT Employee_Name, Category, Education, Skills, Professional_Experience, Years_of_Experience, Companies_Worked
FROM ExtractedDetails 
WHERE Category = 'SQL Developer Lighting Insight'
ORDER BY Years_of_Experience DESC;

# Calculate the Percentage of Senior-Level Employees per Category
SELECT Category,
       COUNT(CASE WHEN Years_of_Experience >= 5 THEN 1 END) * 100.0 / COUNT(*) AS Senior_Percentage
FROM ExtractedDetails
GROUP BY Category
ORDER BY Senior_Percentage DESC;

# Extract Candidates Matching a Specific Skillset
SELECT Employee_Name, Category, Skills
FROM ExtractedDetails
WHERE Skills LIKE '%Python%' OR Skills LIKE '%SQL%' OR Skills LIKE '%React%';










