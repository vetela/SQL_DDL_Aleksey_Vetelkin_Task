drop table if exists Country cascade;
drop table if exists Area cascade;
drop table if exists Mountain cascade;
drop table if exists Climber cascade;
drop table if exists Climb cascade;
drop table if exists Equipment cascade;
drop table if exists ClimberEquipment cascade;
drop table if exists Weather cascade;
drop table if exists Route cascade;
drop table if exists MountainReview cascade;

CREATE TABLE Country (
    country_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE Area (
    area_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Country(country_id)
);

CREATE TABLE Mountain (
    mountain_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    height DECIMAL NOT NULL CHECK (height >= 0),
    area_id INT NOT NULL,
    FOREIGN KEY (area_id) REFERENCES Area(area_id)
);

CREATE TABLE Climber (
    climber_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    address TEXT,
    gender TEXT CHECK (gender IN ('Male', 'Female')),
    email TEXT UNIQUE
);

CREATE TABLE Climb (
    climb_id SERIAL PRIMARY KEY,
    climber_id INT NOT NULL,
    mountain_id INT NOT NULL,
    start_date TIMESTAMP NOT NULL CHECK (start_date > '2000-01-01'),
    end_date TIMESTAMP NOT NULL CHECK (end_date >= start_date),
    FOREIGN KEY (climber_id) REFERENCES Climber(climber_id),
    FOREIGN KEY (mountain_id) REFERENCES Mountain(mountain_id)
);

CREATE TABLE Equipment (
    equipment_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE ClimberEquipment (
	climber_id INT,
    equipment_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    PRIMARY KEY (climber_id, equipment_id),
    FOREIGN KEY (climber_id) REFERENCES Climber(climber_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Weather (
    weather_id SERIAL PRIMARY KEY,
    temperature DECIMAL NOT NULL CHECK (temperature >= 0),
    precipitation DECIMAL NOT NULL CHECK (precipitation >= 0),
    wind_speed DECIMAL NOT NULL CHECK (wind_speed >= 0),
    climbing_condition TEXT NOT NULL,
    climb_id INT NOT NULL,
    FOREIGN KEY (climb_id) REFERENCES Climb(climb_id)
);

CREATE TABLE Route (
    route_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    difficulty TEXT NOT NULL,
    mountain_id INT NOT NULL,
    FOREIGN KEY (mountain_id) REFERENCES Mountain(mountain_id)
);

CREATE TABLE MountainReview (
    mountain_id INT NOT NULL,
    climber_id INT NOT NULL,
    rating DECIMAL NOT NULL CHECK (rating >= 0),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (mountain_id, climber_id),
    FOREIGN KEY (mountain_id) REFERENCES Mountain(mountain_id),
    FOREIGN KEY (climber_id) REFERENCES Climber(climber_id)
);


-- Populate tables with sample data

INSERT INTO Country (name)
VALUES ('Lithuania'), ('France');

INSERT INTO Area (name, country_id) 
VALUES ('Vilnius District', 1),
	   ('Kaunas Region', 1),
	   ('Cannes Area', 2),
	   ('Nice Region', 2);

INSERT INTO Mountain (name, height, area_id) 
VALUES ('Three Crosses', 142, 1),
       ('fictional cannes mountain', 4567.89, 2);

INSERT INTO Climber (first_name, last_name, address, gender, email) 
VALUES ('Ivan', 'Ivanov', 'savanoriu pr. 11', 'Male', 'ivan.ivanov@gmail.com'),
       ('Anna', 'Bomyti', 'Sant Martí st. 19', 'Female', 'anna.Bomyti@gmail.com');

INSERT INTO Climb (climber_id, mountain_id, start_date, end_date)
VALUES (1, 1, '2022-02-22', '2022-02-25'),
       (2, 2, '2011-11-11', '2012-12-12');

INSERT INTO Equipment (name) 
VALUES ('Rope'),
       ('Crampons');

INSERT INTO ClimberEquipment (climber_id, equipment_id, quantity) 
VALUES (1, 1, 2),
       (2, 2, 3);

INSERT INTO Weather (temperature, precipitation, wind_speed, climbing_condition, climb_id) 
VALUES (11.1, 0.3, 11.0, 'Good', 1),
       (3.3, 0.4, 22.0, 'Challenging', 2);

INSERT INTO Route (name, difficulty, mountain_id)
VALUES ('Basic Route', 'Moderate', 1),
       ('Breathtaking Journey', 'Difficult', 2);
  
INSERT INTO MountainReview (mountain_id, climber_id, rating, review_text)
VALUES (1, 1, 4.9, 'Unbelievable view from the top'),
       (2, 2, 1.1, 'Way too challenging as for me');

-- Add 'record_ts' field with default value to each table

ALTER TABLE Country ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE Area ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE Mountain ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE Climber ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE Climb ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE Equipment ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE ClimberEquipment ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE Weather ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE Route ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;
ALTER TABLE MountainReview ADD COLUMN record_ts TIMESTAMP DEFAULT current_date;

-- SELECT * FROM Country;
-- SELECT * FROM Area;
-- SELECT * FROM Mountain;
-- SELECT * FROM Climber;
-- SELECT * FROM Climb;
-- SELECT * FROM Equipment;
-- SELECT * FROM ClimberEquipment;
-- SELECT * FROM Weather;
-- SELECT * FROM Route;
-- SELECT * FROM MountainReview;
