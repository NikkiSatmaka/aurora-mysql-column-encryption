SELECT
    BIN_TO_UUID(id),
    name,
    AES_DECRYPT(ssn, UNHEX(SHA2('secure_key', 512)))
FROM employees;
