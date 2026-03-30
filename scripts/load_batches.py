
import psycopg2
import csv

conn = psycopg2.connect(
    host="localhost",
    database="postgres",
    user="postgres",
    password="postgres"
)
cur = conn.cursor()

# Clear the students table to avoid duplicate key errors
cur.execute("DELETE FROM students;")

# Placeholder mappings for demonstration (replace with real lookups when dimension tables are ready)
gender_map = {"M": 1, "F": 2}
activity_map = {"Low": 1, "Moderate": 2, "High": 3}
sleep_map = {"Poor": 1, "Moderate": 2, "Good": 3}
mood_map = {"Happy": 1, "Neutral": 2, "Stressed": 3}
risk_map = {"Low": 1, "Moderate": 2, "High": 3}

with open("data/student_health_data.csv", "r") as file:
    reader = csv.DictReader(file)
    row_count = 0
    for row in reader:
        cur.execute(
            """
            INSERT INTO students (
                student_id, age, gender_id, activity_id, sleep_id, mood_id, risk_id,
                heart_rate, blood_pressure_systolic, blood_pressure_diastolic,
                stress_level_biosensor, stress_level_self_report,
                study_hours, project_hours, family_members
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (
                row["Student_ID"],
                row["Age"],
                gender_map.get(row["Gender"], None),
                activity_map.get(row["Physical_Activity"], None),
                sleep_map.get(row["Sleep_Quality"], None),
                mood_map.get(row["Mood"], None),
                risk_map.get(row["Health_Risk_Level"], None),
                row["Heart_Rate"],
                row["Blood_Pressure_Systolic"],
                row["Blood_Pressure_Diastolic"],
                row["Stress_Level_Biosensor"],
                row["Stress_Level_Self_Report"],
                row["Study_Hours"],
                row["Project_Hours"],
                row["Family_members"]
            )
        )
        row_count += 1
        if row_count % 100 == 0:
            print(f"Inserted {row_count} rows...")

conn.commit()
print(f"Successfully inserted {row_count} rows from CSV.")
cur.close()
conn.close()