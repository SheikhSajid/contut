Feature: display profile page

    Tutor profile should display 'Verified account' if verified
    It should show subjects taught

Background: tutors have been added to database
  
  Given the following tutors exist:
  | name      | rate  | full_address                  | city       | area            | zip | degree      | institution | year | email                    | approved | password | password_confirmation |
  | Geralt    | 5000  | Rivia, Northern Kingdoms      | Rivia      | Rivia and Lyria | 0   | Witcher     | Wolf School | 1100 | geralt.riv@wolf.com      | true     | passwrd  | passwrd               |
  | Yennefer  | 8000  | Vengerberg, Northern Kingdoms | Vengerberg | Aedirn          | 0   | Sorceress   | Aretuza     | 1140 | yen.veng@aretuza.com.edu | false    | passwrd  | passwrd               |


Scenario: 'Verified account' in the profile page if tutor verified
  Given I am on tutor Geralt's profile
  Then I should see "Verified account"