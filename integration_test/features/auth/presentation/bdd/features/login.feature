Feature: Login

    test database has a user with email 'alexandre@mail.com' and password '12345678'

    Background:
        Given the login app is running


    Scenario: Login with valid credentials calls API and redirects

        When I enter {'alexandre@mail.com'} text into {0} text field
        And I enter {'12345678'} text into {1} text field
        And I tap {'Login'} text
        Then the authentication API should be called {1} time
        And I see {'Area autenticada'} text

    Scenario: Login with invalid credentials does not call API

        When I enter {'alex-site.com'} text into {0} text field
        And I enter {'123456'} text into {1} text field
        And I tap {'Login'} text
        Then the authentication API should not be called
        And I see {'Entrar'} text