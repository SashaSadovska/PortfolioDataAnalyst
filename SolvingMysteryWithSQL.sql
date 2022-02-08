/*

As a part of HarvardX CS50x: CS50's Introduction to Computer Science Course I (as a student) was asked to complete a problem set.
The goal was to write the set of SQL queries and to solve a mystery. I was having so much fun with this very first SQL project. 
Below is log of my SQL queries for completing the course task and solving the mystery...

*/

-- requesting a description from a crime report dated "took place on July 28, 2020 AND that it took place on Chamberlin Street."

SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 AND street = 'Chamberlin Street';

-- checking transcript of three witnesses who mentioned 'courthouse'

SELECT name, transcript FROM interviews WHERE month = 7 AND day = 28 AND transcript like '%courthouse%';

-- getting license plates numbers taped on security camera from 10:15 to 10:25 (witness #1)

SELECT license_plate FROM courthouse_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25;

-- (account_number or amount) info from ATM on Fifer Street when suspect was withdrawing money on 2020/07/28 (witness #2)

SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Fifer Street';

-- all calls lasted less than a minute on 2020/07/28 (caller or receiver) (witness #3)

SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60;

-- flight ID from passangers list who's passport # (thief passport #  within all witnesses's info: caller phone # & bank account # & plate #)

SELECT flight_id FROM passengers WHERE passport_number IN
(SELECT passport_number FROM people join bank_accounts on bank_accounts.person_id=people.id
WHERE phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25)
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Fifer Street'));

-- The thief ESCAPED TO: destination airport city on earliest flight 07/29/2020 with thief passport # (from above)

SELECT city FROM airports WHERE id IN
(SELECT destination_airport_id FROM flights WHERE id IN
(SELECT flight_id FROM passengers WHERE passport_number IN
(SELECT passport_number FROM people join bank_accounts on bank_accounts.person_id=people.id
WHERE phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25)
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Fifer Street')))
AND month = 7 AND day = 29 ORDER BY hour LIMIT 1);

-- The THIEF is: name from passenger list from the earliest flight (see above)

SELECT name FROM people WHERE passport_number IN
(SELECT passport_number FROM passengers WHERE passport_number IN
(SELECT passport_number FROM people join bank_accounts on bank_accounts.person_id=people.id
WHERE phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25)
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Fifer Street'))
AND flight_id = (SELECT id FROM flights WHERE id IN
(SELECT flight_id FROM passengers WHERE passport_number IN
(SELECT passport_number FROM people join bank_accounts on bank_accounts.person_id=people.id
WHERE phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25)
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Fifer Street')))
AND month = 7 AND day = 29 ORDER BY hour LIMIT 1));

-- The ACCOMPLICE is: name from people list by phone number who was the call receiver from thief

SELECT name FROM people WHERE phone_number =
(SELECT receiver FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60 AND caller = (SELECT phone_number FROM people WHERE passport_number IN
(SELECT passport_number FROM passengers WHERE passport_number IN
(SELECT passport_number FROM people join bank_accounts on bank_accounts.person_id=people.id
WHERE phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25)
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Fifer Street'))
AND flight_id = (SELECT id FROM flights WHERE id IN
(SELECT flight_id FROM passengers WHERE passport_number IN
(SELECT passport_number FROM people join bank_accounts on bank_accounts.person_id=people.id
WHERE phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25)
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND transaction_type = 'withdraw' AND atm_location = 'Fifer Street')))
AND month = 7 AND day = 29 ORDER BY hour LIMIT 1))));
