-- Identify what tabes are in the database
SELECT name 
  FROM sqlite_master
 WHERE type = 'table';

/* Context: You vaguely remember that the crime was a ​murder​ that occurred 
sometime on ​**Jan.15, 2018​** and that it took place in ​**SQL City​**. */

 -- Retrieve the crime scene report from the police department’s database
 SELECT *
    FROM crime_scene_report
   WHERE date = '20180115' 
    AND type = 'murder'
    AND city = 'SQL City';

-- Result: Security footage shows that there were 2 witnesses. 
-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

-- Find Witness 1
SELECT *
    FROM person
 WHERE address_street_name = 'Northwestern Dr'
    ORDER BY address_number DESC
    LIMIT 1;

--Result (Witness 1): 
-- id	name	license_id	address_number	address_street_name	ssn
-- 14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

-- Find Witness 2
SELECT * 
    FROM person
 WHERE name LIKE '%Annabel%'
    AND address_street_name = 'Franklin Ave';

--Result (Witness 2):
-- id	name	license_id	address_number	address_street_name	ssn
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

-- Retrieve interviews for the 2 witnesses
SELECT *
    FROM interview
 WHERE person_id = 14887
    OR person_id = 16371;

-- Result:
-- Interview 1: I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
    -- The membership number on the bag started with "48Z". 
    -- Only gold members have those bags. The man got into a car with a plate that included "H42W".
-- Interview 2: I saw the murder happen, and I recognized the killer from my gym when I was 
    -- working out last week on January the 9th.


-- Narrow down suspects based on car plate and gym membership
SELECT m.id, m.name, p.id, p.license_id, dl.plate_number 
    FROM get_fit_now_member AS m
    INNER JOIN person AS p
        ON m.person_id = p.id
    INNER JOIN drivers_license AS dl 
        ON p.license_id = dl.id
 WHERE m.id LIKE '48Z%'
    AND m.membership_status = 'gold';

-- Result: Congrats, you found the murderer! 
    -- But wait, there's more... If you think you're up for a challenge, 
    -- try querying the interview transcript of the murderer to find the real villain behind this crime. 
    -- If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. 

-- Query the interview script of the murderer
SELECT * 
    FROM interview
 WHERE person_id = 67318;

 -- Result: I was hired by a woman with a lot of money. 
    -- I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
    -- She has red hair and she drives a Tesla Model S. 
    -- I know that she attended the SQL Symphony Concert 3 times in December 2017.

-- Identify the murderer
SELECT p.id, p.name, dl.height, dl.hair_color, dl.car_make, dl.car_model, fb.event_name, fb.date
    FROM person AS p 
    INNER JOIN drivers_license AS dl
        ON p.license_id = dl.id
    INNER JOIN facebook_event_checkin AS fb 
        ON fb.person_id = p.id
    WHERE dl.height BETWEEN 65 AND 67
        AND dl.hair_color = 'red'
        AND dl.car_make = 'Tesla'
        AND dl.car_model = 'Model S';

-- Solution: Miranda Priestly
-- Result: Congrats, you found the brains behind the murder! 
-- Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!
 
