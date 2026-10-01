from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import mysql.connector

def extract_data():
    conn = mysql.connector.connect(
        host="customerfeedback.c5i420e4ghsy.ap-south-1.rds.amazonaws.com",
        port=3306,
        user="admin",
        password="****",
        database="customerfeedback"
    )
    cursor = conn.cursor()
    cursor.execute("SELECT COUNT(*) FROM feedback")
    count = cursor.fetchone()[0]
    print(f"Extracted {count} rows from feedback table")
    conn.close()

def curate_data():
    print("Curation step: cleaning missing values, standardizing formats (simulated)")

def load_data():
    print("Load step: loading curated data into warehouse (simulated)")

default_args = {
    'owner': 'sophia',
    'start_date': datetime(2026, 1, 1),
}

with DAG(
    dag_id='customer_feedback_etl',
    default_args=default_args,
    schedule='@daily',
    catchup=False
) as dag:

    extract_task = PythonOperator(
        task_id='extract_from_mysql',
        python_callable=extract_data
    )

    curate_task = PythonOperator(
        task_id='curate_data',
        python_callable=curate_data
    )

    load_task = PythonOperator(
        task_id='load_to_warehouse',
        python_callable=load_data
    )

    extract_task >> curate_task >> load_task