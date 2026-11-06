# Sales Data Pipeline

An end-to-end Data Engineering project that demonstrates how to extract, transform, and load sales data into PostgreSQL using Python, with Docker-based infrastructure, Terraform, and Kestra for workflow orchestration.

## Project Overview

This project implements a simple ETL (Extract, Transform, Load) pipeline for processing sales transaction data.

The goal is to build a structured and reproducible data workflow while gaining practical experience with data transformation, relational databases, containerization, infrastructure provisioning, and orchestration.

## Tech Stack

- **Python:** ETL development
- **Pandas:** Data cleaning and transformation
- **PostgreSQL:** Relational data storage
- **SQLAlchemy & psycopg2:** Database connectivity
- **Docker:** Containerized infrastructure
- **Terraform:** Infrastructure provisioning
- **Kestra:** Workflow orchestration
- **pytest:** Automated testing
- **uv:** Python dependency management
- **SQL:** Data querying and validation

## Pipeline Architecture

```text
Sales CSV Dataset
        |
        v
   Python ETL
        |
        |-- Extract
        |-- Transform
        |-- Load
        |
        v
   PostgreSQL
        |
        v
  SQL Queries

Kestra: Workflow Orchestration
Terraform + Docker: Infrastructure
pytest: Automated Testing
```

## ETL Workflow

### 1. Extract

The pipeline reads sales transaction records from a CSV file using Pandas.

### 2. Transform

The transformation stage prepares the dataset for storage and analysis.

Key operations include:

- Converting date fields into datetime format.
- Calculating total sales amounts using `quantity * price`.
- Preparing structured records for database insertion.

### 3. Load

The processed data is loaded into PostgreSQL using SQLAlchemy and psycopg2.

The database provides persistent storage and allows the transformed data to be queried using SQL.

## Infrastructure and Orchestration

The project uses Docker and Terraform to provision and manage the infrastructure.

The environment includes:

- A PostgreSQL container for sales data.
- A separate PostgreSQL container for Kestra metadata.
- A Kestra container for workflow orchestration.
- A Docker network connecting the services.
- Persistent storage for Kestra.

Kestra is used to manage the execution of the sales pipeline, providing a foundation for repeatable and automated ETL workflows.

## Testing

The project uses pytest to test pipeline functionality.

Run the tests using:

```bash
uv run pytest
```

## Project Structure

The Python ETL components are organized into separate modules:

```text
src/
└── sales_data_pipeline/
    ├── extract.py
    ├── transform.py
    └── load.py
```

Separating extraction, transformation, and loading makes the pipeline easier to maintain, test, and extend.

## Key Learning Outcomes

This project provides hands-on experience with:

- Designing modular ETL pipelines.
- Processing structured datasets using Pandas.
- Integrating Python applications with PostgreSQL.
- Managing containerized services using Docker.
- Provisioning infrastructure with Terraform.
- Exploring workflow orchestration with Kestra.
- Writing automated tests for data-processing code.

## Future Improvements

- Expand the pipeline to handle larger datasets.
- Add automated data-quality checks.
- Introduce incremental data loading.
- Improve monitoring and error handling.
- Add reporting and analytical dashboards.

## Project Purpose

This project was developed as a hands-on learning experience to strengthen practical Data Engineering skills and explore the tools and workflows used in modern data platforms.
