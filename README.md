# GoodBooks Multi-DB Project

## Overview
This project explores the migration and analysis of the GoodBooks dataset across three different database technologies:
1. **MySQL** – Relational model with SQL queries.  
2. **Apache Cassandra** – Distributed, wide-column NoSQL model with CQL.  
3. **Neo4j** – Graph database model with Cypher queries.

The goal is to compare data modelling, ingestion and query patterns in each system and demonstrate their strengths and constraints.

## Project Structure

```
.
├── Relatório Final BD2 - 2023.pdf   # Final project report (in Portuguese)
├── Scripts/                         # SQL/CQL/Cypher scripts
│   ├── scriptmysql.sql              # MySQL schema, data load & queries
│   ├── scriptcassandra.sql          # Cassandra keyspace, table & queries
│   └── scriptneo4j.sql              # Neo4j import & Cypher queries
└── Ficheiros CSV/                   # Source datasets in CSV format
    ├── books.csv
    ├── tags.csv
    ├── book_tags.csv
    ├── ratings.csv
    └── to_read.csv
```

## Prerequisites

- **MySQL** (v8.0 or later)  
- **Docker** with **Apache Cassandra** for CQLSH  
- **Neo4j** (Desktop or Server v4.x or later)  
- **DBeaver** or another SQL client (optional, for MySQL)  
- **cypher-shell** or Neo4j Browser for running Cypher scripts

## Setup & Usage

### 1. MySQL

1. Start your MySQL server and create a new database:
   ```sql
   DROP DATABASE IF EXISTS goodbooks;
   CREATE DATABASE goodbooks;
   USE goodbooks;
   ```

2. Execute `Scripts/scriptmysql.sql` to:
   - Create tables (`books`, `tags`, `book_tags`, `ratings`, `to_read`)
   - Load data from `Ficheiros CSV/`
   - Run analytical queries

### 2. Apache Cassandra

1. Launch Cassandra (e.g. via Docker):
   ```bash
   docker run --name bd2_cassandra -d cassandra:4
   docker exec -it bd2_cassandra cqlsh
   ```

2. In CQLSH, run `Scripts/scriptcassandra.sql` to:
   - Create keyspace `goodbooks_keyspace`
   - Define table `books_all` and query-specific tables
   - Load data with `COPY` from CSV
   - Execute the six analytical CQL queries

### 3. Neo4j

1. Start Neo4j (Desktop or Server) and place the CSV files in the `import` folder.

2. In Neo4j Browser or `cypher-shell`, run `Scripts/scriptneo4j.sql` to:
   - Clear existing graph
   - Create `Book`, `Tag`, `User` nodes
   - Establish `HAS_TAG`, `RATED`, `TO_READ` relationships
   - Execute the six analytical Cypher queries

## Report

All design decisions, data models, query results and comparative discussion are documented in **Relatório Final BD2 - 2023.pdf**.

## Contributing

Feel free to open issues or submit pull requests for:
- Additional queries or visualisations  
- Improvements to data modelling  
- Automation scripts (e.g. Docker Compose)  

