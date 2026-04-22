Feature: Login

    test database has a user with email 'alexandre@mail.com' and password '12345678'

    Background:
        Given the login app is running


    Scenario: Login with valid credentials should call API {1} time and redirect

        When I enter {'alexandre@mail.com'} text into {0} text field
        And I enter {'12345678'} text into {1} text field
        And I tap {'Login'} text
        Then the authentication API should be called {1} time
        And I see {'Area autenticada'} text

    Scenario: Login with non-existing user should call API {1} time and stay on login

        When I enter {'naoexiste@mail.com'} text into {0} text field
        And I enter {'12345678'} text into {1} text field
        And I tap {'Login'} text
        Then the authentication API should be called {1} time
        And I see {'Credenciais invalidas.'} text
        And I see {'Entrar'} text