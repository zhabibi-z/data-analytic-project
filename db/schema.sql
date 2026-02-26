---------------------------------------------------
-- DROP TABLES (fact first due to FK dependencies)
---------------------------------------------------

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS genders;
DROP TABLE IF EXISTS physical_activity_levels;
DROP TABLE IF EXISTS sleep_quality_levels;
DROP TABLE IF EXISTS moods;
DROP TABLE IF EXISTS health_risk_levels;

---------------------------------------------------
-- DIMENSION TABLES
---------------------------------------------------

CREATE TABLE genders (
    gender_id SERIAL PRIMARY KEY,
    gender_code VARCHAR(1) UNIQUE NOT NULL
);

CREATE TABLE physical_activity_levels (
    activity_id SERIAL PRIMARY KEY,
    activity_level VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE sleep_quality_levels (
    sleep_id SERIAL PRIMARY KEY,
    sleep_quality VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE moods (
    mood_id SERIAL PRIMARY KEY,
    mood_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE health_risk_levels (
    risk_id SERIAL PRIMARY KEY,
    risk_level VARCHAR(20) UNIQUE NOT NULL
);

---------------------------------------------------
-- FACT TABLE
---------------------------------------------------

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    age SMALLINT NOT NULL,

    gender_id INTEGER NOT NULL REFERENCES genders(gender_id),
    activity_id INTEGER NOT NULL REFERENCES physical_activity_levels(activity_id),
    sleep_id INTEGER NOT NULL REFERENCES sleep_quality_levels(sleep_id),
    mood_id INTEGER NOT NULL REFERENCES moods(mood_id),
    risk_id INTEGER NOT NULL REFERENCES health_risk_levels(risk_id),

    heart_rate REAL,
    blood_pressure_systolic REAL,
    blood_pressure_diastolic REAL,
    stress_level_biosensor REAL,
    stress_level_self_report REAL,
    study_hours REAL,
    project_hours REAL,
    family_members SMALLINT
);

---------------------------------------------------
-- SEED DIMENSION DATA
---------------------------------------------------

INSERT INTO genders (gender_code) VALUES ('M'), ('F');

INSERT INTO physical_activity_levels (activity_level)
VALUES ('Low'), ('Moderate'), ('High');

INSERT INTO sleep_quality_levels (sleep_quality)
VALUES ('Poor'), ('Moderate'), ('Good');

INSERT INTO moods (mood_name)
VALUES ('Happy'), ('Neutral'), ('Stressed');

INSERT INTO health_risk_levels (risk_level)
VALUES ('Low'), ('Moderate'), ('High');