# Data Ingestion

This document explains how to run the data ingestion script to generate and load random student health data into the database.

## Prerequisites

- PostgreSQL database running with the schema applied (see db/schema.sql)
- Python installed

## Running the Script

1. Ensure the database is running and schema is applied.
2. Run the script: `python scripts/load_batches.py`

## Verification

After running, check in DBeaver: `SELECT COUNT(*) FROM student_health;` should show 1000 rows.

## Notes

- The script generates 1000 random records for student health data.
- Connects to localhost postgres database with user postgres, password postgres.
- Adjust connection details if needed.