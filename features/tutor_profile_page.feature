Feature: Visiting a tutor's profile page

    Tutor profile should display 'Verified account' if verified
    It should show subjects taught

Background: tutors have been added to database
  
  Given the following tutors exist:
  | name      | rate  | full_address                  | city       | area            | degree      | institution | email                    | approved |
  | Geralt    | 5000  | Rivia, Northern Kingdoms      | Rivia      | Rivia and Lyria | Witcher     | Wolf School | geralt.riv@wolf.com      | true     |
  | Yennefer  | 8000  | Vengerberg, Northern Kingdoms | Vengerberg | Aedirn          | Sorceress   | Aretuza     | yen.veng@aretuza.com.edu | false    |


Scenario: 'Verified account' displayed if tutor verified
  Given I am on tutor Geralt's profile
  Then I should see "Verified account"
  And should not see "Message"
  And should not see "Send Request"
  
Scenario: 'credentials has not been verified' in the profile page if tutor unverified
  Given I am on tutor Yennefer's profile
  Then I should see "credentials has not been verified"
  
Scenario: visiting student is not on the student list
  Given student named "John Doe" is logged in
  And he visits tutor Yennefer's profile
  Then he should see "Send Request"
  And he should also see "Message"
  And he should not see "Write a review"
  
Scenario: visiting student is on the student list
  Given student named "Cirilla Fiona" is logged in
  And she is in Geralt's student list
  When she visits tutor Geralt's profile
  Then she should see "Write a review"
  And she should not see "Send Request"

Scenario: visiting student is on some other tutor's student list
  Given student named "Cirilla Fiona" is logged in
  And she is in Yennefer's student list
  When she visits tutor Geralt's profile
  Then she should not see "Write a review"
  And she should see "Send Request"
  
Scenario: display reviews on the profile page
  Given a student named "Cirilla Fiona" exists
  And Yennefer has a review with rating "5" from her saying "She is amazing."
  When I am on tutor Yennefer's profile
  Then I should see "Cirilla"
  And should also see "She is amazing."
  But I should not see "Edit"
  And I should not see "Delete"
  
Scenario: display edit/delete links under review
  Given student named "Cirilla Fiona" is logged in
  And Yennefer has a review with rating "5" from her saying "She is amazing."
  When she visits tutor Yennefer's profile
  Then she should see "Edit"
  And she should also see "Delete"
  
Scenario: display edit/delete links under review
  Given student named "Julian Alfred" is logged in
  And she is in Geralt's student list
  When he is on tutor Geralt's profile
  And he clicks on "Write a review"
  Then he selects "5" and comments "My best friend. Has got me out of a lot of hairy situations."
  Then he should be on tutor Geralt's profile
  Then he should see "My best friend. Has got me out of a lot of hairy situations."
  