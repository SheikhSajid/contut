Feature: The navbar changes when a user logs in/out
  
Background: tutors have been added to database

  Given the following tutors exist:
  | name      | rate  | full_address                  | city       | area            | degree      | institution | email                    | approved |
  | Geralt    | 5000  | Rivia, Northern Kingdoms      | Rivia      | Rivia and Lyria | Witcher     | Wolf School | geralt.riv@wolf.com      | true     |
  | Yennefer  | 8000  | Vengerberg, Northern Kingdoms | Vengerberg | Aedirn          | Sorceress   | Aretuza     | yen.veng@aretuza.com.edu | false    |

Scenario: shows login buttons when not signed in
  Given I am on the homepage
  Then I should see "Tutors Sign in"
  And I should also see "Students Sign in"
  
Scenario: Tutors Sign in link works
  Given I am on the homepage
  And click on "Tutors Sign in"
  Then I should be taken to the Tutor login page
  
Scenario: Students Sign in link works
  Given I am on the homepage
  And click on "Students Sign in"
  Then I should be taken to the Student login page

Scenario: Tutor logs in
  Given tutor Geralt is logged in
  And he should see "Upload New Certificate"
  And he should see "Edit Profile"
  And he should see "Log Out"
  And he should not see "Tutors Sign in"
  And he should not see "Students Sign in"
  
Scenario: Student logs in
  Given student named "Cirilla Fiona" is logged in
  And she should see "Edit Profile"
  And she should see "Log Out"
  Then she should not see "Tutors Sign in"
  And she should not see "Students Sign in"
  And he should not see "Upload New Certificate"
  