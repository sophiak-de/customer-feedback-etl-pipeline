# customer-feedback-etl-pipeline
Batch ETL pipeline: MySQL → Python/Pandas → S3 → Redshift-style warehouse → Airflow → Power BI
# Customer Feedback & Sales ETL Pipeline

## Overview
Batch ETL pipeline built to extract, clean, and analyze customer feedback and sales data.

## Architecture
MySQL (RDS) → Python/Pandas (extract & curate) → Amazon S3 (staging) 
→ PostgreSQL (Redshift-pattern warehouse) → SQL analysis → Power BI dashboard
→ Apache Airflow (orchestration, on EC2)

## Tools Used
- Python, Pandas, mysql-connector-python, boto3, SQLAlchemy
- AWS: RDS (MySQL), S3, EC2
- PostgreSQL (used as a Redshift substitute for free-tier practice)
- Apache Airflow
- Power BI

## What I Built
- Extraction script pulling data from MySQL
- Data curation: handled missing values, duplicates, type validation
- Staged curated CSVs in S3
- Loaded curated data into a warehouse
- SQL analysis: joins, aggregations, subqueries, window functions
- Power BI dashboard: feedback trends, category performance
- Airflow DAG orchestrating extract → curate → load

## Note
Redshift was substituted with PostgreSQL locally, since Redshift isn't fully free-tier eligible.
