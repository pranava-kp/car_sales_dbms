USE rto;


-- Plaintext Passwords: 'password123', 'password456', 'password789'
UPDATE user_login SET password = '$2a$10$GsCLLMZi2v1OJItvB/6DMOBWCKlmQ8fk7fZbgqAT4jEUsHlJ5/B8G' WHERE user_id = 'RAMESH P';
UPDATE user_login SET password = '$2a$10$rgEilcxPZC75l14eT2UGOOPsovM8d7dQ4twzKV89nou7cWQtqPvne' WHERE user_id = 'SURESH S';
UPDATE user_login SET password = '$2a$10$/tpT3FzoNxi1NXPijYKQ/.s1KkfX7Md/u.klo1SstVQChr2Gtmq9i' WHERE user_id = 'VIGNESH R';

-- Plaintext Passwords: 'honda456', 'hyundai789', 'maruti123'
UPDATE manufacturer_login SET password = '$2a$10$s4J/AQdjAtKK7LCXK5hSI.g4gRhmIShScH0TP9q/LeyvX6ng/qsH.' WHERE user_id = 'Honda';
UPDATE manufacturer_login SET password = '$2a$10$FOvoOsBo/u5sOVqLN3kQUec2prlBMSGbM1uudM2wOUk0lA3NcYmjK' WHERE user_id = 'Hyundai';
UPDATE manufacturer_login SET password = '$2a$10$HjtnrCI8M5ADmCXhQsOWBOmI5qTtQd63VZMpj8CTOOyRBB3CpHeMu' WHERE user_id = 'Maruti';

-- Plaintext Passwords: 'admin123', 'admin456', 'admin789'
UPDATE rto_login SET password = '$2a$10$Q2OYaY.L15xdh6MJwtmn8ug9T5raUJGNdif87kZ./nhrnQWomX0TS' WHERE user_id = 'KA01';
UPDATE rto_login SET password = '$2a$10$KqvKxF5/fEkCqiXxCsY4zuLUiCHqzW1d.XP8lUnBHQHNM0MKVGTBC' WHERE user_id = 'KA04';
UPDATE rto_login SET password = '$2a$10$d/mfGwQni4awNiuF23Dtw.xBXd8axisqg6VnI/6E2oOvKCbhQH6WG' WHERE user_id = 'KA41';
