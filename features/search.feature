Feature: Search using the search bar
  
  The search bar can search tutors based on name, subjects taught and address. 
  
Background: tutors have been added to database
  
  Given the following tutors exist:
  | name      | rate  | full_address                  | city       | area            | zip | degree      | institution | year | email                    | approved | password | password_confirmation |
  | Geralt    | 5000  | Rivia, Northern Kingdoms      | Rivia      | Rivia and Lyria | 0   | Witcher     | Wolf School | 1100 | geralt.riv@wolf.com      | true     | passwrd  | passwrd               |
  | Yennefer  | 8000  | Vengerberg, Northern Kingdoms | Vengerberg | Aedirn          | 0   | Sorceress   | Aretuza     | 1140 | yen.veng@aretuza.com.edu | false    | passwrd  | passwrd               |

Scenario: Search using the full name
  When I put "Yennefer" in the search bar
  Then I should see "Yennefer"
  
Scenario: Search using the full name
  When I put "Yen" in the search bar
  Then I should see "Yennefer"
  
Scenario: search for a address 
  When I put "Vengerberg" in the search bar
  Then I should see "Yennefer"
  
Scenario: search for a subject
  Given Yennefer teaches "Spells"
  And Geralt teaches "Swordplay"
  When I put "Spells" in the search bar
  Then I should see "Yennefer"
  And should not see "Geralt"

Scenario: Search query partially matches subject
  Given Yennefer teaches "Spells"
  And Geralt teaches "Swordplay"
  When I put "Sword" in the search bar
  Then I should see "Geralt"
  And should not see "Yennefer"
  
Scenario: search using area
  When I put "Rivia and Lyria" in the search bar
  Then I should see "Geralt"
  