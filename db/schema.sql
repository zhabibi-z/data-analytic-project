CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);

CREATE TABLE batches (
    batch_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    yield_pct NUMERIC(5,2) NOT NULL,
    downtime_min INTEGER NOT NULL
);

INSERT INTO products (product_name)
VALUES ('A'), ('B'), ('C');

CREATE TABLE student_health (
    student_id INTEGER PRIMARY KEY,
    age INTEGER,
    gender VARCHAR(10),
    heart_rate NUMERIC(10,2),
    blood_pressure_systolic NUMERIC(10,2),
    blood_pressure_diastolic NUMERIC(10,2),
    stress_level_biosensor NUMERIC(10,2),
    stress_level_self_report NUMERIC(10,2),
    physical_activity VARCHAR(20),
    sleep_quality VARCHAR(20),
    mood VARCHAR(20),
    study_hours NUMERIC(10,2),
    project_hours NUMERIC(10,2),
    health_risk_level VARCHAR(20),
    family_members INTEGER
);