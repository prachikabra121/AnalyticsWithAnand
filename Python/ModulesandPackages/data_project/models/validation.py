# utilities/validation.py

def validate_email(email):
    return "@" in email and "." in email


def validate_age(age):
    return age >= 18


def validate_name(name):
    return isinstance(name, str) and len(name.strip()) > 0