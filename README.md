![Simpsons Image](https://files.slack.com/files-pri/T01A3845EPK-F01GGJSFYUD/image.png)


Final Report:

"I used to be with 'it', but then they changed what 'it' was.” -- Abe Simpson

“I'm an old man. I hate everything but Matlock!”-- also Abe Simpson.

The Simpsons used to be ‘it.’ But over the show’s 30+ year run, has it maintained its cultural relevance? Or have the times changed so much since the show’s initial airing that it has become as much of a relic as Grandpa Simpson?

To answer this question, we looked at several datasets related to The Simpsons. How has the show’s popularity changed over time and can we see any correlation between the show’s popularity and its use of catchphrases and guest stars? And is there a correlation between the popularity of the show and baby names?


EXTRACT

Our datasources for this analysis include:

Wikipedia had much of the information needed to perform most of our analyses on The Simpsons. These pages had HTML tables listing ratings data, episode titles and guest stars. All of this information we scraped from the site and pulled into a pandas dataframe that we saved to CSVs. This source was easy to find. The other sources were a bit more challenging.

Next we wanted to find a source of data for baby names. We wanted to know if people have been naming their babies after the show’s most popular characters. This proved to be challenging because we had to find a website that displayed the data in an easy to capture way. We were looking for a ranking of each name from 1990 to 2019. The social security website was the first attempt, but it required a more complex code to pull the html table since the queries did not generate a unique url for each name. Upon inspection, the html from the completed query page generated individual tables for each year of data, so the data cleaning process would prove to be more complicated than one single table. Rather than writing code to deal with this we found a different website that had unique url for each name query. That website, behindthename.com, also generated mostly clean html tables of the top 1000 names given to babies each year.

We also wanted to see how the show’s use of catchphrases changed over time and 
To do this, we used a website that included the full transcript of every script from each of the show’s 639 episodes. For this, we used BeautifulSoup to scrape the HTML from transcripts.foreverdreaming.org in order to analyze the frequency of certain words being used on the show.
		
 
TRANSFORM:

			WIKIPEDIA
			
For the tables from Wikipedia, these appeared simple enough but there are several tables for each page and we had to experiment to find the one we wanted.
The tables appear on the Wikipedia page with subheadings, and on the website this allows the data to look neat, however, in a dataframe, the columns are all multi-index, which complicated the code when working on them. For example, this column --  ('Viewership','Most watched episode', 'Viewers(millions)') -- is the number of viewers that watched the highest rated episode of that season.
Also two columns, the number of the season and the years of the season are both called, 'Season', 'Season', 'Season. To isolate these to possibly use them as a key for our databases, meant isolating the columns in individual dataframes, renaming and resetting the index and then re-merging the dataframes. It looks simple but it took a lot to unwrap.
Another issue for the data clean up was that the numbers are listed as string data types, instead of integers. This meant that some sorting actions resulted in unexpected results. So the datatypes had to be reset to integers.
These tables had to be filtered and cleaned, and several tables had to be concatenated and merged. The show has been on so long that Wikipedia breaks up the more detailed pages about the show into two pages based on the seasons.

			BEHINDTHENAME.COM

Rather than writing code to deal with this we found a different website that had unique url for each name query. This website also generated mostly clean tables. To clean this data, we wrote a for loop to go through names of the main cast and select supporting roles. Key clean up tasks included the following:

Removing names that did not appear on the baby name website at all
Dropping excess rows with an if statement - names with masculine and feminine rankings have 7 columns, and names with only masculine or only feminine rankings had 4 columns. In both scenarios, we only wanted the first 3 columns.
Renaming columns to Year & Rank
Replacing otherwise null cells (either empty or “-”) with nan in order to dropna
Drop years prior to 1990
Add column with string of character’s name - useful to the next step of concatenating

The for loop generated a dictionary of dataframes, one for each character. We then concatenated the dataframes with values (half the names did not rank in the top 1000 baby names at all during the time period) and reset the index since the years column had multiple values for each year. This final dataframe was saved to a csv

Initially, we had merged the name dataframes so that the year or season was the index and each column was the character’s name and rank. This dataframe set up was helpful for generating visualizations, but it was less helpful for relating to other data in the database.

Transcripts.foreverdreaming.org

To analyze this information, we used python to iterate through the show transcripts and to run several for loops to count the utterances of several common catchphrases.
Special conditions were added to filter out some directions for the actors, phrases like laughing, gasping, crying. The information was also found on several websites so another for loop was created to iterate through all of the URLs.




LOAD:

All of our tables were saved as CSV files and then loaded into SQL. 

Season_Year
Season_Number INTEGER PK
Year INTEGER
All_Episodes
Season_Number INTEGER PK FK >- Season_Year.Season_Number
Episode_Number INTEGER PK
Episode_Title VARCHAR(50)
Baby_Names_Popularity
Year INTEGER PK FK >- Season_Year.Year
Name VARCHAR(30) PK
Name_Rank INTEGER
Guest_Stars_All
Season_Number INTEGER PK FK - Season_Year.Season_Number
Guest_Star_Name VARCHAR(30)
Episode_title VARCHAR(50)
Guest_Star_Season
Season_Number INTEGER PK FK - Season_Year.Season_Number
Count_of_Appearances INTEGER
Viewers
Season_Number INTEGER PK FK - Season_Year.Season_Number
Number_of_Episodes INTEGER
Average_Ep_Viewers_in_mil FLOAT
Most_Watched_Ep_Viewer_in_mil FLOAT
Episode_Title INTEGER
Ratings
Season_Number INTEGER PK FK - Season_Year.Season_Number
Number_of_Episodes INTEGER
Ep_Rank INTEGER
Rating VARCHAR(5)
Episode_Phrases
Season_Number INTEGER FK >- Season_Year.Season_Number
Episode_Number INTEGER FK >- All_Episodes.Episode_Number
Most_common_phrase VARCHAR(50)

