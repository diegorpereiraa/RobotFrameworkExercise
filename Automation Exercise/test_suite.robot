*** Settings ***
Library    SeleniumLibrary
Resource    keywords.resource
Test Teardown    Remove all products

*** Test Cases ***
Addition
    Given I am in Automation Exercise page
    When Login into page    ${EMAIL}    ${PASSWORD}
    And Search for a product    ${PRODUCT_MEN_T_SHIRT}
    Then Validate product is visible    ${PRODUCT_MEN_T_SHIRT}
    When Add product to chart
    And Close add cart success modal
    And Search for a product    ${PRODUCT_FANCY_GREEN_TOP}
    Then Validate product is visible    ${PRODUCT_FANCY_GREEN_TOP}
    When Add product to chart
    And Go to cart through add cart success modal
    Then Validate that 2 products are visible on cart    ${PRODUCT_MEN_T_SHIRT}    ${PRODUCT_FANCY_GREEN_TOP}
    And Validate that the total amount of 2 products is calculated correctly    ${PRODUCT_MEN_T_SHIRT}    ${PRODUCT_FANCY_GREEN_TOP}