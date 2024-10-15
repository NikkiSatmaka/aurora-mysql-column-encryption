import unittest

from db.encryption import decrypt_data, derive_key, encrypt_data, key


class TestEmployeeEncryption(unittest.TestCase):
    def setUp(self):
        self.encryption_key = derive_key(key)

    def test_encryption_and_decryption(self):
        ssn = "123-45-6789"
        encrypted_ssn = encrypt_data(ssn, self.encryption_key)
        decrypted_ssn = decrypt_data(encrypted_ssn, self.encryption_key)

        # Test if decryption matches the original
        self.assertEqual(ssn, decrypted_ssn)


if __name__ == "__main__":
    unittest.main()
