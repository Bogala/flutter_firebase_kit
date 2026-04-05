Feature: Email/Password Sign-In

  Scenario: Successful sign-in with valid credentials
    Given the user is on the sign-in screen
    When they enter valid credentials
    Then they are authenticated and redirected to the home screen

  Scenario: Sign-in with incorrect password
    Given the user is on the sign-in screen
    When they enter an incorrect password
    Then they see an error message indicating invalid credentials

  Scenario: Sign-in with non-existent email
    Given the user is on the sign-in screen
    When they enter an email that does not correspond to any account
    Then they see a generic invalid credentials error
