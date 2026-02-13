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