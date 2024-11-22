# HW2 - Normalization by SQL

This project demonstrates database normalization principles using SQL. It includes scripts for setting up a PostgreSQL database, populating it with random data, and running it inside a Docker container.

---

## Project Structure
- **`docker-compose.yml`**: Defines the Docker Compose configuration for the PostgreSQL database container.
- **`Dockerfile`**: Builds the PostgreSQL container with initialization scripts.
- **`setup.sql`**: SQL script to create the `books` table with the appropriate schema.
- **`populates_value_random.sql`**: SQL script to populate the `books` table with randomly generated values.
- **`README.md`**: This file, containing information on how to set up and use the project.

---

## Prerequisites
- Docker and Docker Compose installed on your system.

---

## Getting Started
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd HW2-Normalization-by-SQL
   ```

2. Build and start the PostgreSQL container:
   ```bash
   docker-compose up --build
   ```

3. Access the PostgreSQL database:
   - Use a PostgreSQL client.
   - Connect to `localhost:5432` with the credentials defined in the `docker-compose.yml` or Dockerfile:
     - **User**: `admin`
     - **Password**: `admin`
     - **Database**: `ada_db`

4. Load the database schema:
   The `setup.sql` script is automatically executed when the container is first started. It creates the `books` table.

5. Populate the table with random values:
   Run the `populates_value_random.sql` script manually inside the PostgreSQL container or using your database client.

   Example using `psql`:
   ```bash
   psql -h localhost -p 5432 -U admin -d ada_db -f populates_value_random.sql
   ```
## Stop and Start the Container
To stop the container:
```bash
docker-compose stop
```
To start the container:
```bash
docker-compose start
```

## Stopping And Deleting the Container
To stop and remove the container:
```bash
docker-compose down
```

## Additional Notes
- Data persistence is handled via Docker volumes, so the data will remain intact even after stopping the container.
- Modify the SQL scripts as needed for your specific requirements.