# GoodBooks Cross-Database Migration & Analysis

A sample pipeline demonstrating how to migrate and analyse the GoodBooks dataset across three database systems:

- **MySQL** (relational model)  
- **Apache Cassandra** (distributed NoSQL column store)  
- **Neo4j** (property graph)

---

## Table of Contents

1. [Overview](#overview)  
2. [Repository Structure](#repository-structure)  
3. [Prerequisites](#prerequisites)  
4. [Data Loading](#data-loading)  
   - [MySQL](#mysql)  
   - [Cassandra](#cassandra)  
   - [Neo4j](#neo4j)  
5. [Analytical Queries](#analytical-queries)  
6. [Final Report](#final-report)  
7. [License](#license)  

---

## Overview

The GoodBooks dataset (from [Goodreads](https://github.com/zygmuntz/goodbooks-10k)) contains books, authors, user ratings and tags. In this project we:

- **Design normalized schemas** in MySQL and run classic SQL queries.  
- **Model a wide table** in Cassandra with appropriate partition/clustering keys and use CQL.  
- **Represent a graph** in Neo4j, creating `Book`, `User` and `Tag` nodes plus relationships like `RATED` and `HAS_TAG`, then run Cypher queries.

This lets you compare modelling, loading and querying patterns across relational, NoSQL and graph paradigms.

---

## Prerequisites

- Docker (optional containers for Cassandra/Neo4j)  
- MySQL 5.7+  
- Apache Cassandra 4.x  
- Neo4j 4.x  
- DBeaver or another SQL/CQL GUI (optional, but I used DBeaver)

