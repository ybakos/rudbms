Feature: Starting the Server
  As a hacker learning about databases
  I want to be able to run rudbms
  In order to start a database server

  Scenario: Run the rudbms executable
    Given I have no directory called "testdb"
    And I have execute permissions on the file "bin/rudbms"
    When I run "bundle exec bin/rudbms start testdb"
    Then a directory named "testdb" should exist
    And the exit status should be 0
    And the output should contain:
    """
    Starting rudbms with database testdb...
    """