# FPL-SQL
SQL Schema Dump

This repo contains the SQL Schema and Procs required by the FPL project and are a prerequisite to getting the project running.

## Usage

- Install MySQL
- Clone this repo
- Initialise the DB with the cloned dump data
```bash
sudo mysql -u root -p
CREATE DATABASE fpl;
exit
sudo mysql -u root -p fpl < fpl-sql-dump.sql
```
- Seed the DB with the most up to date FPL Data by running the FPL-AI /data/gameweekinput endpoint
- Use the FPL-AI /models/predict endpoint to generate and store predictions using the stored FPL Data
