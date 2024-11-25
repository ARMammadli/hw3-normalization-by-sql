
# HW3 - Normalization by SQL

This project demonstrates the principles of **database normalization** using SQL. The entire process, from setting up the database to executing normalization queries, is automated using shell scripts. It includes Dockerized PostgreSQL, data loading from Excel, and the execution of SQL normalization queries.

---

## Project Structure

- **`docker-compose.yml`**: Defines the Docker Compose configuration for the PostgreSQL database container, including environment variables and volume mappings.
- **`Dockerfile`**: Builds a customized PostgreSQL container with the schema initialization script.
- **`setup.sql`**: SQL script to create the normalized database schema, which is automatically executed during container setup.
- **`data/`**: Directory containing the Excel file(s) with the raw data to be loaded into the database.
- **`queries/`**: Directory containing SQL scripts for normalization queries.
- **`load_data.sh`**: Shell script to load data from the Excel files into the PostgreSQL database.
- **`full_run_process.sh`**: Shell script that automates the entire workflow, from building the Docker container to running all SQL queries.
- **`README.md`**: This file, providing comprehensive instructions on setting up and using the project.

---

##Prerequisites

Before running the project, ensure you have:

1. **Docker** and **Docker Compose** installed on your system.
   - [Download Docker](https://www.docker.com/get-started)
   - [Install Docker Compose](https://docs.docker.com/compose/install/)
2. A basic understanding of **SQL** and **PostgreSQL** is helpful but not mandatory.

---

## Quick Start

The entire process is automated. You only need to execute the provided shell script.

### 1. Clone the Repository

```bash
git clone <repository-url>
cd hw3-normalization-by-sql
```

### 2. Run the Full Automation Script

Execute the `full_run_process.sh` script to build the Docker container, load data, and run all queries:

```bash
bash full_run_process.sh
```

This script performs the following steps:
1. Builds the PostgreSQL container using the `Dockerfile`.
2. Starts the container using `docker-compose.yml`.
3. Executes the `setup.sql` script to create the schema.
4. Loads the Excel data into the database using `load_data.sh`.
5. Executes the normalization queries from the `queries/` directory.

---

## Detailed Explanation of Components

### 1. **Database Schema (`setup.sql`)**

The setup.sql script begins with an unnormalized table called unnormalized, which contains the raw data. This table includes fields such as course information, book details, authors, publisher information, and more. However, the data in this table contains redundancy and does not adhere to normalization principles.

As part of the normalization process, the data from the unnormalized table is systematically transformed into a normalized schema. This involves decomposing the unnormalized table into multiple related tables that follow the principles of normalization, eliminating redundancy and ensuring data integrity.

The normalized schema includes the following tables:
	•	publishers: Contains unique publisher names and their addresses.
	•	books: Stores information about books, including ISBN, title, edition, publisher, pages, and year.
	•	authors: Stores unique author names.
	•	courses: Contains unique course information, such as course names and CRNs.
	•	book_authors: Manages the many-to-many relationships between books and their authors.
	•	course_books: Manages the many-to-many relationships between courses and the books used in those courses.

The normalization process ensures that data is stored efficiently, avoids redundancy, and adheres to the principles of database design. This process is automated as part of the workflow and is executed during the Docker container setup.

### 2. **Data (`data/`)**

This directory contains the raw data in Excel format. The data is loaded into the PostgreSQL database using the `load_data.sh` script. Ensure the data follows the expected structure to avoid errors during the loading process.

### 3. **Normalization Queries (`queries/`)**

The `queries/` directory contains SQL scripts that perform normalization on the raw data. These scripts address common normalization principles, such as eliminating redundancy and ensuring atomicity.

### 4. **Automation Scripts**

- **`load_data.sh`**: Loads raw data from Excel files into the PostgreSQL database using appropriate tools like `psql` or other supported data import utilities.
- **`full_run_process.sh`**: Automates the entire process:
  - Builds and starts the Docker container.
  - Loads the raw data into the database.
  - Runs the normalization queries.

---

## Project Workflow

1. **Docker Setup**
   - The `Dockerfile` and `docker-compose.yml` set up a PostgreSQL database container.
   - The `setup.sql` script is executed during container initialization to create the schema.

2. **Data Loading**
   - The raw data (in Excel format) is loaded into the database using the `load_data.sh` script.

3. **Normalization**
   - SQL scripts in the `queries/` directory are executed to normalize the data.

4. **Verification**
   - After normalization, the database is ready for querying and further analysis.

---

## Managing the Docker Container

### Stopping the Container

To stop the running PostgreSQL container:

```bash
docker-compose stop
```

### Starting the Container

To start the stopped PostgreSQL container:

```bash
docker-compose start
```

### Restarting the Container

To restart the PostgreSQL container:

```bash
docker-compose restart
```

### Stopping and Removing the Container

To stop and remove the PostgreSQL container along with the associated networks:

```bash
docker-compose down
```

- **Note**: This command **does not** remove the Docker volumes, ensuring data persistence.

---