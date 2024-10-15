INSERT INTO employees (id, name, ssn)
VALUES
    (UUID_TO_BIN(UUID()), 'John Doe', AES_ENCRYPT('123-45-6789', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Jane Smith', AES_ENCRYPT('234-56-7890', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Robert Brown', AES_ENCRYPT('345-67-8901', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Lucy Black', AES_ENCRYPT('456-78-9012', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Anna White', AES_ENCRYPT('567-89-0123', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Tom Green', AES_ENCRYPT('678-90-1234', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'George Blue', AES_ENCRYPT('789-01-2345', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Maria Yellow', AES_ENCRYPT('890-12-3456', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Chris Red', AES_ENCRYPT('901-23-4567', UNHEX(SHA2('secure_key', 512)))),
    (UUID_TO_BIN(UUID()), 'Alex Gray', AES_ENCRYPT('012-34-5678', UNHEX(SHA2('secure_key', 512))));
