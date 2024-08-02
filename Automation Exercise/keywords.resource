*** Settings ***
Library    SeleniumLibrary
Library    String


*** Variables ***
${LOGIN_URL}    https://automationexercise.com/
${BROWSER}    Chrome
${CHROME_OPTIONS}    --incognito
${PRODUCT_MEN_T_SHIRT}    Men Tshirt
${PRODUCT_PEACOCK_BLUE}    Beautiful Peacock Blue Cotton Linen Saree
${PRODUCT_FANCY_GREEN_TOP}    Fancy Green Top
${EMAIL}    1@admin.com
${PASSWORD}    admin

*** Keywords ***
I am in Automation Exercise page
    Open Browser    ${LOGIN_URL}    ${BROWSER}    ${CHROME_OPTIONS}
    Maximize Browser Window

Login into page
    [Arguments]    ${username}    ${password}
    Click Element    //a[text()=' Signup / Login']
    Input Text    //input[@data-qa="login-email"]    ${username}
    Input Text    //input[@data-qa="login-password"]    ${password}
    Click Button    //button[@data-qa="login-button"]

Search for a product
    [Arguments]    ${product_name}
    Click Element    //a[text()=' Products']
    Input Text    //input[@id="search_product"]    ${product_name}
    Click Element    //button[@id="submit_search"]

Validate product is visible
    [Arguments]    ${product_name}
    Element Should Be Visible    //p[text()='${product_name}']/parent::div[@class="productinfo text-center"]

Add product to chart
    Click Element    //a[text()='View Product']
    Click Element    //button[@class="btn btn-default cart"]

Close add cart success modal
    Wait Until Element Is Visible    //button[@class="btn btn-success close-modal btn-block"]
    Click Element    //button[@class="btn btn-success close-modal btn-block"]

Go to cart through add cart success modal
    Wait Until Element Is Visible    //button[@class="btn btn-success close-modal btn-block"]
    Click Element    //u[text()='View Cart']//parent::a

Validate that 2 products are visible on cart
    [Arguments]    ${product_name_1}    ${product_name_2}
    Element Should Be Visible    //a[text()='${product_name_1}']/ancestor::tr
    Element Should Be Visible    //a[text()='${product_name_2}']/ancestor::tr
Validate that the total amount of 2 products is calculated correctly
    [Arguments]    ${product_name_1}    ${product_name_2}
    ${PRICE_1}    Get Text    //a[text()='${product_name_1}']/ancestor::tr/descendant::p[@class="cart_total_price"]
    ${SUBS_PRICE_1}    Get Substring    ${PRICE_1.strip()}    3
    ${PRICE_2}    Get Text    //a[text()='${product_name_2}']/ancestor::tr/descendant::p[@class="cart_total_price"]
    ${SUBS_PRICE_2}    Get Substring    ${PRICE_2.strip()}    3
    ${TOTAL_PRICE}  Evaluate    ${SUBS_PRICE_1} + ${SUBS_PRICE_2}
    Wait Until Element Is Visible    //a[@class="btn btn-default check_out"]/parent::div
    Click Element    //a[@class="btn btn-default check_out"]
    Wait Until Element Is Visible    //b[text()='Total Amount']//ancestor::tr//descendant::p[@class="cart_total_price"]
    ${TOTAL_AMOUNT}    Get Text    //b[text()='Total Amount']//ancestor::tr//descendant::p[@class="cart_total_price"]
    ${SUBS_TOTAL_AMOUNT}    Get Substring    ${TOTAL_AMOUNT.strip()}    3
    Should Be Equal As Numbers    ${SUBS_TOTAL_AMOUNT}    ${TOTAL_PRICE}

Remove all products
    Click Element    //a[text()=' Cart']
    Click Element    //tr[2]//a[@class="cart_quantity_delete"]
    Click Element    //tr[1]//a[@class="cart_quantity_delete"]
    Close Browser