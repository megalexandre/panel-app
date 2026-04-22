Feature: Login Failed And Validation

    Background:
        Given the login app is running

    Scenario: Submit with empty fields should fail

        When I tap {'Login'} text
        Then the authentication API should be called {0} time
        And I see {'Informe seu e-mail'} text
        And I see {'Informe sua senha'} text
        And I see {'Preencha os campos para continuar.'} text

    Scenario Outline: Invalid email format should fail

        When I enter {'<email>'} text into {0} text field
        And I enter {'12345678'} text into {1} text field
        And I tap {'Login'} text
        Then the authentication API should be called {0} time
        And I see {'Informe um e-mail valido'} text

        Examples:
            | email     |
            | alex      |
            | alex@     |
            | alex@site |
            | @mail.com |
            

    Scenario: Email with spaces should call API {1} time and authenticate
        When I enter {'  alexandre@mail.com  '} text into {0} text field
        And I enter {'12345678'} text into {1} text field
        And I tap {'Login'} text
        Then the authentication API should be called {1} time
        And I see {'Area autenticada'} text
