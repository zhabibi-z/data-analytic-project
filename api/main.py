from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel
from typing import Optional
import psycopg2
import psycopg2.extras
import os

app = FastAPI(title="Student Health Data API", version="1.0.0")

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "database": os.getenv("DB_NAME", "postgres"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASSWORD", "postgres"),
    "port": int(os.getenv("DB_PORT", "5432")),
}

def get_connection():
    return psycopg2.connect(**DB_CONFIG)

class Student(BaseModel):
    student_id: int
    age: Optional[float]
    gender: Optional[str]
    heart_rate: Optional[float]
    blood_pressure_systolic: Optional[float]
    blood_pressure_diastolic: Optional[float]
    stress_level_biosensor: Optional[float]
    stress_level_self_report: Optional[float]
    physical_activity: Optional[str]
    sleep_quality: Optional[str]
    mood: Optional[str]
    study_hours: Optional[float]
    project_hours: Optional[float]
    health_risk_level: Optional[str]
    family_members: Optional[int]

@app.get("/health")
def health_check():
    return {"status": "ok"}

@app.get("/students", response_model=list[Student])
def get_students(
    limit: int = Query(default=100, le=1000),
    offset: int = Query(default=0, ge=0),
    risk_level: Optional[str] = Query(default=None),
):
    with get_connection() as conn:
        cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        if risk_level:
            cur.execute(
                """
                SELECT
                    student_id, age, gender, heart_rate,
                    blood_pressure_systolic, blood_pressure_diastolic,
                    stress_level_biosensor, stress_level_self_report,
                    physical_activity, sleep_quality, mood,
                    study_hours, project_hours, health_risk_level, family_members
                FROM students
                WHERE LOWER(health_risk_level) = LOWER(%s)
                ORDER BY student_id
                LIMIT %s OFFSET %s
                """,
                (risk_level, limit, offset),
            )
        else:
            cur.execute(
                """
                SELECT
                    student_id, age, gender, heart_rate,
                    blood_pressure_systolic, blood_pressure_diastolic,
                    stress_level_biosensor, stress_level_self_report,
                    physical_activity, sleep_quality, mood,
                    study_hours, project_hours, health_risk_level, family_members
                FROM students
                ORDER BY student_id
                LIMIT %s OFFSET %s
                """,
                (limit, offset),
            )
        rows = cur.fetchall()
        return [dict(row) for row in rows]

@app.get("/students/{student_id}", response_model=Student)
def get_student(student_id: int):
    with get_connection() as conn:
        cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        cur.execute(
            """
            SELECT
                student_id, age, gender, heart_rate,
                blood_pressure_systolic, blood_pressure_diastolic,
                stress_level_biosensor, stress_level_self_report,
                physical_activity, sleep_quality, mood,
                study_hours, project_hours, health_risk_level, family_members
            FROM students
            WHERE student_id = %s
            """,
            (student_id,),
        )
        row = cur.fetchone()
        if row is None:
            raise HTTPException(status_code=404, detail="Student not found")
        return dict(row)
