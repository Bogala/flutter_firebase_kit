Feature: Sign-Out

  Scenario: Successful sign-out
    Given the user is authenticated
    When they tap sign out
    Then their session is terminated and they are redirected to the sign-in screen

  Scenario: Back button after sign-out
    Given the user has signed out
    When they press the back button
    Then they cannot access any authenticated screen
