import uuid

import polars as pl

from db.connection import get_session
from db.encryption import decrypt_data, derive_key, encrypt_data, key
from models.employee import Employee


def insert_employees_from_csv(csv_file):
    session = get_session()

    # Read data from CSV
    df = pl.read_csv(csv_file)

    # Derive encryption key
    encryption_key = derive_key(key)

    # Insert each employee into the database, encrypting the SSN
    for row in df.iter_rows(named=True):
        employee_id = uuid.uuid4().bytes
        encrypted_ssn = encrypt_data(row["ssn"], encryption_key)
        employee = Employee(id=employee_id, name=row["name"], ssn=encrypted_ssn)
        session.add(employee)

    session.commit()
    session.close()


def query_and_decrypt_employees():
    session = get_session()

    # Derive the encryption key
    decryption_key = derive_key(key)

    # Query all employees
    employees = session.query(Employee).all()

    for employee in employees:
        decrypted_ssn = decrypt_data(employee.ssn, decryption_key)
        employee_uuid = Employee.to_uuid(employee.id)
        print(f"ID: {employee_uuid}, Name: {employee.name}, SSN: {decrypted_ssn}")

    session.close()
