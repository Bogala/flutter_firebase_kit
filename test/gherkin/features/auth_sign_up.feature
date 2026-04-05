Feature: Email/Password Sign-Up

  Scenario: Successful sign-up with valid credentials
    Given the user is on the sign-up screen
    When they enter a valid email and a password meeting complexity requirements and submit
    Then their account is created and they are redirected to the home screen

  Scenario: Sign-up with existing email
    Given the user is on the sign-up screen
    When they enter an email already associated with an existing account
    Then they see an error message indicating the email is already in use

  Scenario: Sign-up with weak password
    Given the user is on the sign-up screen
    When they enter a password that does not meet complexity requirements
    Then they see a specific error describing the password policy

  Scenario: Sign-up with invalid email format
    Given the user is on the sign-up screen
    When they enter an invalid email format
    Then they see an error indicating the email format is incorrect
