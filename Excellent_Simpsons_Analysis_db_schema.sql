-- Create all 8 tables for Excellent_Simpson_Analysis db

-- Drop tables using CASCADE to remove dependencies as well
DROP TABLE IF EXISTS Season_Year CASCADE;

DROP TABLE IF EXISTS All_Episodes CASCADE;

DROP TABLE IF EXISTS Baby_Names_Popularity CASCADE;

DROP TABLE IF EXISTS Guest_Stars_All CASCADE;

DROP TABLE IF EXISTS Guest_Stars_Season CASCADE;

DROP TABLE IF EXISTS Viewers CASCADE;

DROP TABLE IF EXISTS Ratings CASCADE;

DROP TABLE IF EXISTS Episode_Phrases CASCADE;

CREATE TABLE Season_Year (
	Season_Number INT NOT NULL UNIQUE,
	Season_Year_Aired INT NOT NULL UNIQUE, 
 	PRIMARY KEY(Season_Number)
);

CREATE TABLE All_Episodes (
	Season_Number INT NOT NULL,
	Episode_Number INTEGER NOT NULL,
	Episode_Title VARCHAR(50),
 	PRIMARY KEY(Season_Number, Episode_Number),
	FOREIGN KEY(Season_Number) REFERENCES Season_Year(Season_Number)
);

CREATE TABLE Baby_Names_Popularity (
	Season_Year_Aired INT NOT NULL,
	Character_Name VARCHAR(30) NOT NULL,
	Name_Rank INTEGER NOT NULL,
	PRIMARY KEY(Season_Year_Aired, Character_Name),
	FOREIGN KEY(Season_Year_Aired) REFERENCES Season_Year(Season_Year_Aired)
);

CREATE TABLE Guest_Stars_All (
	Season_Number INT NOT NULL,
	Guest_Star_Name VARCHAR(30) NOT NULL,
	Episode_title VARCHAR(50) NOT NULL,
	PRIMARY KEY(Season_Number),
	FOREIGN KEY(Season_Number) REFERENCES Season_Year(Season_Number)
);

CREATE TABLE Guest_Star_Season (
	Season_Number INT NOT NULL,
	Count_of_Appearances INT NOT NULL,
	PRIMARY KEY(Season_Number),
	FOREIGN KEY(Season_Number) REFERENCES Season_Year(Season_Number)
);

CREATE TABLE Viewers (
	Season_Number INT NOT NULL,
	Number_of_Episodes INT NOT NULL,
	Average_Ep_Viewers_in_mil FLOAT NOT NULL,
	Most_Watched_Ep_Viewer_in_mil FLOAT NOT NULL,
	Episode_Title VARCHAR(50),
	PRIMARY KEY(Season_Number),
	FOREIGN KEY(Season_Number) REFERENCES Season_Year(Season_Number)
);

CREATE TABLE Ratings (
	Season_Number INT NOT NULL,
	Number_of_Episodes INT NOT NULL,
	Season_Rank INT NOT NULL,
	Rating VARCHAR(5),
	PRIMARY KEY(Season_Number),
	FOREIGN KEY(Season_Number) REFERENCES Season_Year(Season_Number)
);

CREATE TABLE Episode_Phrases (
	Season_Number INT NOT NULL,
	Episode_Number INT NOT NULL,
	Most_common_phrase VARCHAR(50) NOT NULL,
	FOREIGN KEY(Season_Number) REFERENCES Season_Year(Season_Number)
);