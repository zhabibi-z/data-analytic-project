import psycopg2
import random

conn = psycopg2.connect(
    host="localhost",
    database="postgres",
    user="postgres",
    password="postgres"
)
cur = conn.cursor()

# Generate and insert 1000 random student health records
for i in range(1, 1001):
    student_id = i
    age = random.randint(18, 25)
    gender = random.choice(['M', 'F'])
    heart_rate = round(random.uniform(50, 100), 2)
    bp_systolic = round(random.uniform(90, 140), 2)
    bp_diastolic = round(random.uniform(60, 90), 2)
    stress_bio = round(random.uniform(1, 10), 2)
    stress_self = round(random.uniform(1, 10), 2)
    physical_activity = random.choice(['Low', 'Moderate', 'High'])
    sleep_quality = random.choice(['Poor', 'Moderate', 'Good'])
    mood = random.choice(['Happy', 'Stressed', 'Neutral'])
    study_hours = round(random.uniform(5, 50), 2)
    project_hours = round(random.uniform(5, 30), 2)
    health_risk = random.choice(['Low', 'Moderate', 'High'])
    family_members = random.randint(1, 15)
    
    cur.execute(
        """
        INSERT INTO student_health (student_id, age, gender, heart_rate, blood_pressure_systolic, blood_pressure_diastolic, stress_level_biosensor, stress_level_self_report, physical_activity, sleep_quality, mood, study_hours, project_hours, health_risk_level, family_members)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """,
        (student_id, age, gender, heart_rate, bp_systolic, bp_diastolic, stress_bio, stress_self, physical_activity, sleep_quality, mood, study_hours, project_hours, health_risk, family_members)
    )

conn.commit()
cur.close()
conn.close()