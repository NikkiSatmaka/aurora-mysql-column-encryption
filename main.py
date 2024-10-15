from db.crud import insert_employees_from_csv, query_and_decrypt_employees
from db.setup import create_tables, drop_tables

if __name__ == "__main__":
    csv_file_path = "data/employees.csv"

    # Drop all tables first
    drop_tables()

    # Create all tables
    create_tables()

    # Insert data from CSV
    insert_employees_from_csv(csv_file_path)

    # Query and decrypt employees
    query_and_decrypt_employees()
