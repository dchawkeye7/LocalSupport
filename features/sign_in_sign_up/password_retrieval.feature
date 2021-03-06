Feature: Password retrieval
  As an existing User
  So that I can recover a lost password
  I want to be able to ask that system for a new password
  Tracker story ID: https://www.pivotaltracker.com/story/show/47376361

  Background:
    Given the following organizations exist:
      | name     | description             | address        | postcode | telephone | email                            |
      | Friendly | Bereavement Counselling | 34 pinner road | HA1 4HZ  | 020800000 | registered-org-admin@example.com |

    Given the following users are registered:
      | email                            | password | confirmed_at        | organization |
      | registered-user@example.com      | pppppppp | 2014-01-20 16:27:36 |              |
      | registered-org-admin@example.com | pppppppp | 2014-01-20 16:27:36 | Friendly     |

    And cookies are approved

    Given I am on the home page
    And I follow "Forgot your password?"
    And the email queue is clear

  @email
  Scenario Outline: Retrieving passwords
    When I fill in "user_retrieval_email" with "<email>" within the main body
    And I press "Send me reset password instructions"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."
    And I should receive a "Reset password instructions" email
    Given I click on the retrieve password link in the email to "<email>"
    Then I should be on the password reset page
    And I fill in "user_password" with "12345678" within the main body
    And I fill in "user_password_confirmation" with "12345678" within the main body
    And I press "Change my password"
    Then I should be on the <page>
  Examples:
    | email                            | page      |
    | registered-user@example.com      | home page |
    | registered-org-admin@example.com | home page |

  @email
  Scenario: Retrieve password for a non-existent user
    When I fill in "user_retrieval_email" with "non-existent_user@example.com" within the main body
    And I press "Send me reset password instructions"
    And I should see "Email not found in our database. Sorry!"
    And I should not receive an email
  #And I should be on the sign up page 
