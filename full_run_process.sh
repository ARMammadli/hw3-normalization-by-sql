#!/bin/bash

# Step 1: Build and start the Docker container
echo "Building and starting Docker containers..."
docker-compose up --build -d

# Wait for the database to initialize
echo "Waiting for PostgreSQL to initialize..."
sleep 15

# Step 2: Convert Excel to CSV and load unnormalized data
echo "Converting Excel to CSV and loading unnormalized data..."
docker-compose exec postgres /usr/local/bin/load_data.sh

# Step 3: Run SQL normalization scripts in order
echo "Running 1st normalization..."
docker-compose exec postgres psql -U admin -d ada_db -f /queries/1st_normalization.sql

echo "Running 2nd normalization..."
docker-compose exec postgres psql -U admin -d ada_db -f /queries/2nd_normalization.sql

echo "Running 3rd normalization..."
docker-compose exec postgres psql -U admin -d ada_db -f /queries/3rd_normalization.sql


# Completion message
echo "Full process completed successfully."