CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    age INTEGER NOT NULL,
    gender VARCHAR(1) CHECK (gender IN ('M', 'F')),

    heart_rate DOUBLE PRECISION,
    blood_pressure_systolic DOUBLE PRECISION,
    blood_pressure_diastolic DOUBLE PRECISION,

    stress_level_biosensor DOUBLE PRECISION,
    stress_level_self_report DOUBLE PRECISION,

    physical_activity VARCHAR(20),
    sleep_quality VARCHAR(20),
    mood VARCHAR(20),

    study_hours DOUBLE PRECISION,
    project_hours DOUBLE PRECISION,

    health_risk_level VARCHAR(20),
    family_members INTEGER
);

CREATE INDEX idx_mood ON students(mood);
CREATE INDEX idx_health_risk ON students(health_risk_level);
CREATE INDEX idx_physical_activity ON students(physical_activity);

-- Drop tables in correct dependency order
DROP TABLE IF EXISTS students ;
DROP TABLE IF EXISTS genders ;
DROP TABLE IF EXISTS physical_activity_levels ;
DROP TABLE IF EXISTS sleep_quality_levels ;
DROP TABLE IF EXISTS moods ;
DROP TABLE IF EXISTS health_risk_levels ;

---------------------------------------------------
-- Dimension Tables
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
-- Fact Table
---------------------------------------------------

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    age INTEGER NOT NULL CHECK (age > 0),

    gender_id INTEGER NOT NULL REFERENCES genders(gender_id),

    heart_rate DOUBLE PRECISION NOT NULL,
    blood_pressure_systolic DOUBLE PRECISION NOT NULL,
    blood_pressure_diastolic DOUBLE PRECISION NOT NULL,

    stress_level_biosensor DOUBLE PRECISION NOT NULL,
    stress_level_self_report DOUBLE PRECISION NOT NULL,

    activity_id INTEGER NOT NULL REFERENCES physical_activity_levels(activity_id),
    sleep_id INTEGER NOT NULL REFERENCES sleep_quality_levels(sleep_id),
    mood_id INTEGER NOT NULL REFERENCES moods(mood_id),

    study_hours DOUBLE PRECISION NOT NULL,
    project_hours DOUBLE PRECISION NOT NULL,

    risk_id INTEGER NOT NULL REFERENCES health_risk_levels(risk_id),

    family_members INTEGER NOT NULL CHECK (family_members >= 0)
);

---------------------------------------------------
-- Indexes for analytics performance
---------------------------------------------------

CREATE INDEX idx_students_mood ON students(mood_id);
CREATE INDEX idx_students_risk ON students(risk_id);
CREATE INDEX idx_students_activity ON students(activity_id);


-- Insert dimension data

INSERT INTO genders (gender_code)
VALUES ('M'), ('F');

INSERT INTO physical_activity_levels (activity_level)
VALUES ('Low'), ('Moderate'), ('High');

INSERT INTO sleep_quality_levels (sleep_quality)
VALUES ('Poor'), ('Moderate'), ('Good');

INSERT INTO moods (mood_name)
VALUES ('Happy'), ('Neutral'), ('Stressed');

INSERT INTO health_risk_levels (risk_level)
VALUES ('Low'), ('Moderate'), ('High');
