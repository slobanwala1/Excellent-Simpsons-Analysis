-- Queries used in class presentation

SELECT * FROM baby_names_popularity;
SELECT * FROM episode_phrases;
SELECT * FROM guest_star_season;
SELECT * FROM guest_stars_all;
SELECT * FROM ratings;
SELECT * FROM season_year;
SELECT * FROM viewers;

SELECT season_year.season_number, Guest_Stars_All.guest_star_name, Guest_Stars_All.episode_title, ratings.season_rank, viewers.average_ep_viewers_in_mil,
viewers.most_watched_ep_viewer_in_mil
FROM season_year
LEFT JOIN Guest_Stars_All ON season_year.season_number = Guest_Stars_All.season_number
LEFT JOIN ratings ON Guest_Stars_All.season_number = ratings.season_number
LEFT JOIN viewers ON ratings.season_number = viewers.season_number
order by season_year.season_number asc;


SELECT * from episode_phrases
order by occurrences desc;

--SELECT * from episode_phrases
--order by most_common_phrase desc;


SELECT * from episode_phrases
WHERE most_common_phrase = 'Homer: Doh!' OR most_common_phrase = 'D''oh!'

SELECT season_number, sum(occurrences) from episode_phrases
WHERE most_common_phrase = 'Homer: Doh!' OR most_common_phrase = 'D''oh!'
group by season_number
order by season_number asc;
 



SELECT * FROM guest_star_season;