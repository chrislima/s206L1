@jsonplaceholder
Feature: Testar as operações presentes em JSONPlaceholder

Background: Executa antes de cada teste.
    * def url_base = "https://jsonplaceholder.typicode.com"
    * def request_json = read('json_post.json')
    * def request_json2 = read('json_post_2.json')

# Lembrando que: $ = response
# # = objeto ou expressão de response 

Scenario: Testar a operação GET em /posts e verificar o retorno em formato array.
    Given url url_base
    And path '/posts'
    When method get
    Then status 200
    And match $ == '#[]'
    And match $ == '#[100]'
    And match each $ contains {title: '#string', id: '#number'}

Scenario: Testar a criação de recursos com o metodo POST na API /posts
    Given url url_base
    And path '/posts'
    And request request_json
    When method post
    Then status 201
    And match $.id == 101
    And match $.title == '#string'
    And match $.body == "Essa é uma demonstracao da aula no Inatel"
    And print karate.sizeOf(response)
    And match karate.sizeOf(response) == 4

Scenario Outline: Testar a criação de recursos com o metodo POST na API /posts
    Given url url_base
    And path '/posts'
    And request <request_json>
    When method post
    Then status 201
    And match $.id == 101
    And match $.title == '#string'
    And match $.body == '<texto_body>'
    And print karate.sizeOf(response)
    And match karate.sizeOf(response) == 4

    Examples:
    |request_json       |texto_body                                 |
    |request_json       |Essa é uma demonstracao da aula no Inatel|
    |request_json2      |Essa é uma demonstracao da aula no Inatel2|



